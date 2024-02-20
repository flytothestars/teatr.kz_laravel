<?php

namespace App\Models\Specific;

use App\Mail\SendTicket;
use App\Models\General\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Spatie\Activitylog\Traits\LogsActivity;

class Order extends Model {

    use LogsActivity;
    use SoftDeletes;

    protected $table = 'orders';

    protected $fillable = [
        'timetable_id',
        'api',
        'user_id',
        'name',
        'email',
        'phone',
        'comment',
        'price',
        'pay_id',
        'pay_sum',
        'pay_date',
        'pay_system',
        'hash',
        'ip',
        'paid',
        'sent',
    ];

    protected $casts = [
        'paid' => 'boolean',
        'sent' => 'boolean',
    ];

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Scopes *** ///

    public function scopePaid($query) {
        return $query->where('paid', 1);
    }

    /// *** Relations *** ///

    public function orderItems() {
        return $this->hasMany(OrderItem::class);
    }

    public function timetable() {
        return $this->belongsTo(Timetable::class);
    }

    public function user() {
        return $this->belongsTo(User::class);
    }

    /// *** Attributes *** ///

    public function getTicketsLinkAttribute() {
        if(!$this->paid) { return null; }
        return '/order/'.$this->id.'/'.$this->hash.'/pdf';
    }

    /// *** Custom *** ///

    public function generateHash() {
        $hash = md5($this->id.'spaceduck'.$this->created_at);
        $this->hash = $hash;
        return $hash;
    }

    public function populateFromCart($cart) {
        $total_sum = 0;
        DB::beginTransaction();
//        Log::error($cart);
        foreach($cart as $ticket) {
            $local_ticket = null;
            if(isset($ticket['ticket_id']) && $ticket['ticket_id']) {
                $local_ticket = Ticket::find($ticket['ticket_id']);
            } else {
                if(isset($ticket['section_id']) && $ticket['section_id']) {
                    $local_ticket = Ticket::available()
                        ->where('timetable_id', $this->timetable_id)
                        ->where('section_id', $ticket['section_id'])
                        ->first();
                }
                if(isset($ticket['pricegroup_id']) && $ticket['pricegroup_id']) {
                    $local_ticket = Ticket::available()
                        ->where('timetable_id', $this->timetable_id)
                        ->where('pricegroup_id', $ticket['pricegroup_id'])
                        ->first();
                }
            }
            $oi = OrderItem::create([
                'order_id'      => $this->id,
                'timetable_id'  => $this->timetable_id,
                'price'         => $ticket['price'],
                'section_id'    => issetOrNull($ticket,'section_id'),
                'pricegroup_id' => issetOrNull($ticket,'pricegroup_id'),
                'row'           => issetOrNull($ticket,'row'),
                'seat'          => issetOrNull($ticket,'seat'),
                'ticket_id'     => $local_ticket ? $local_ticket->id : null,
            ]);
            if(!$this->api) {
                $oi->generateBarcode();
            }
            if($local_ticket) {
                $local_ticket->blocked = 1;
                $local_ticket->save();
            }
            $total_sum += $ticket['price'];
        }
        DB::commit();
        return $total_sum;
    }

    public function sendByEmail($email = NULL) {
        if(!env('SEND_EMAILS')) {
            return true;
        }
        if(!$email) {
            $email = $this->email;
        }
        try {
            Mail::to($email)->send(new SendTicket($this));
            $this->sent = 1;
            $this->save();
//            Log::('mail was sent successfully','Order id'.$this->id);
            return true;
        } catch(\Exception $e) {
            \Illuminate\Support\Facades\Log::error($e);
            return false;
        }
    }

    public static function deleteOldOrders() {
        $now = strtotime("now");
        $orders = self::where("paid",0)
            ->where('created_at','>',date('Y-m-d H:i:s',strtotime('-90 days')))
            ->get();
        $time = 30*60; // полчаса
        foreach($orders as $key => $order) {
            $orderTime = strtotime($order->created_at);
            if(abs($now - $orderTime) > $time) {
                $order->delete();
            }
        }
    }


    public function successfullyPaid($amount, $send = true, $pay_date = null, $int_ref = null, $auth_code = null) {
//        aalog("response_from_processing",'order successfully paid and should be sent. Order id'.$this->id);
        $timetable = $this->timetable;
        if($timetable && $this->api) {
            $api_class = $timetable->getAPIClass();
            $api = new $api_class;
            $response = $api->confirmOrder($this);
            if(!$response) {
                return false;
            }
        }
        $update_data = [
            'pay_sum' => $amount,
            'paid' => 1
        ];
        if($pay_date) {
            $update_data['pay_date'] = $pay_date;
        }
        if(!$pay_date && !$this->pay_date) {
            $update_data['pay_date'] = date('Y-m-d H:i:s');
        }
        if($int_ref) {
            $update_data['pay_id'] = $int_ref;
        }
        if($auth_code) { $update_data['auth_code'] = $auth_code; }

        unset($update_data['']);
        $this->update($update_data);

        $ticket_ids = $this->orderItems()
            ->whereNotNull('ticket_id')
            ->pluck('ticket_id')
            ->toArray();
        if(count($ticket_ids) > 0) {
            Ticket::whereIn('id', $ticket_ids)
                ->where('timetable_id',$this->timetable_id)
                ->update(['sold' => 1]);
        }

        if($send && !$this->sent) {
            $this->sendByEmail();
        }
        return true;

    }


    public function delete() {
        $timetable = $this->timetable;
        if($timetable && $timetable->api) {
            $api_class = $timetable->getAPIClass();
            $api = new $api_class;
            $api->cancelOrder($this->id);
        }
        $ticket_ids = $this->orderItems()
            ->whereNotNull('ticket_id')
            ->pluck('ticket_id')
            ->toArray();
        if(count($ticket_ids) > 0) {
            Ticket::whereIn('id',$ticket_ids)
                ->where('timetable_id',$this->timetable_id)
                ->update([
                    'blocked' => 0,
                    'sold'    => 0
                ]);
        }

        return parent::delete();
    }


    public static function additionalSearchQuery($query, $search) {
        if(isset($search['event_id']) && $search['event_id']) {
            $query->whereHas('timetable', function($q) use($search){
                $q->whereHas('event', function($qt) use ($search) {
                    $qt->where('id',$search['event_id'])
                        ->orWhereRaw('LOWER(title) LIKE ?', ['%' . mb_strtolower($search['event_id']) . '%']);
                });
            });
        }
        return $query;
    }


}
