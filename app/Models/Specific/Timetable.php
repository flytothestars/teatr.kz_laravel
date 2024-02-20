<?php

namespace App\Models\Specific;

use App\Models\API\LermontovAPI;
use App\Models\Types\TicketAPIType;
use App\Models\Types\TimetableType;
use App\Traits\ActiveScopeTrait;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Translatable\HasTranslations;

class Timetable extends Model {

    use HasTranslations;
    use LogsActivity;
    use ActiveScopeTrait;
    use SoftDeletes;

    protected $table = 'timetables';

    public $translatable = [
        'note'
    ];

    protected $fillable = [
        'api',
        'api_id',
        'event_id',
        'venue_id',
        'venue_scheme_id',
        'datetime',
        'type',
        'note',
        'active',
    ];

    protected $attributes = [
        'note' => '{}',
    ];

    protected $casts = [
        'active' => 'boolean'
    ];

    protected $appends = ['formatted_date'];

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Scopes *** ///

    public function scopeFuture($query) {
        return $query->where('datetime', '>=', date('Y-m-d H:i:s'));
    }

    public function scopeToday($query) {
        return $query->whereBetween('datetime', [date('Y-m-d').' 00:00:00',date('Y-m-d').' 23:59:59']);
    }

    public function scopeWeekend($query) {
        $start = date("Y-m-d", strtotime('saturday this week')).' 00:00:00';
        $end = date("Y-m-d", strtotime('sunday this week')).' 23:59:59';
        return $query->whereBetween('datetime', [$start, $end]);
    }

    public function scopeMonth($query) {
        $start = date("Y-m-d", strtotime('first day of this month')).' 00:00:00';
        $end = date("Y-m-d", strtotime('last day of this month')).' 23:59:59';
        return $query->whereBetween('datetime', [$start, $end]);
    }

    /// *** Relations *** ///

    public function event() {
        return $this->belongsTo(Event::class);
    }

    public function venue() {
        return $this->belongsTo(Venue::class);
    }

    public function scheme() {
        return $this->belongsTo(VenueScheme::class, 'venue_scheme_id');
    }

    public function tickets() {
        return $this->hasMany(Ticket::class);
    }

    public function pricegroups() {
        return $this->hasMany(Pricegroup::class);
    }

    /// *** Attributes *** ///

    public function getAvailableForSaleAttribute() {
        return $this->datetime > date('Y-m-d H:i:s',strtotime('-4 hours')) && $this->active;
    }

    public function getFormattedDateAttribute() {
        return dateFormat($this->datetime, true);
    }


    /// *** Custom *** ///

    public function getGroupFieldAttribute() {
        $group_field = 'section_id';
        if($this->type == 'pricegroups') {
            $group_field = 'pricegroup_id';
        }
        return $group_field;
    }

    public function groupedCountTickets() {
        if($this->api_id) {
            $api_class = $this->getAPIClass();
            if(!$api_class) { return []; }
            $api = new $api_class;
            return $api->getTickets($this);
        }
        $data = $this->tickets()
            ->available()
            ->selectRaw('COUNT(id) as cnt, '.$this->group_field)
            ->groupBy($this->group_field)
            ->get()
            ->keyBy($this->group_field)
            ->toArray();
        if($this->type == TimetableType::PRICEGROUPS) {
            $pgs = $this->pricegroups()
                ->get()
                ->keyBy('id')
                ->toArray();
            $data = array_map(function($item) use($pgs) {
                $item['pricegroup'] = isset($pgs[$item['pricegroup_id']]) ? $pgs[$item['pricegroup_id']] : null;
                return $item;
            }, $data);
        }
        return $data;
    }


    public function getTicketsForGroup($id, $withblocked = false) {
        $q = $this->tickets()->where($this->group_field, $id);
        if(!$withblocked) {
            $q->available();
        }
        $tickets = $q->get();
        $prices = Ticket::arrayPrices($tickets->pluck('price')->toArray());
        $seats = $this->type == TimetableType::SECTIONS ? Seat::where('section_id',$id)->get() : [];
        if($this->type == TimetableType::SECTIONS && count($tickets) > 0 && $tickets[0]->seat_id) {
            $ticks = $tickets->keyBy('seat_id')->toArray();
            $seats->map(function($item) use($ticks) {
                 if(isset($ticks[$item->id])) {
                     $item->ticket = $ticks[$item->id];
                 }
                 return $item;
            });
        }
        return [
            'prices'  => $prices,
            'seats'   => $seats,
            'tickets' => $tickets
        ];
    }

    public function getAPIClass() {
        if(!$this->api) {
            return null;
        }
        $classes = [
            TicketAPIType::LERMONTOV => LermontovAPI::class,
        ];
        return isset($classes[$this->api]) ? $classes[$this->api] : null;
    }


}
