<?php

namespace App\Models\Specific;

use App\Models\Types\TicketType;
use App\Models\Types\TimetableType;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Translatable\HasTranslations;

class Ticket extends Model {

    use LogsActivity;

    protected $table = 'tickets';

    protected $fillable = [
        'api_id',
        'pricegroup_id',
        'timetable_id',
        'section_id',
        'row',
        'seat',
        'seat_id',
        'price',
        'blocked',
        'sold',
        'barcode',
    ];

    protected $casts = [
        'blocked' => 'boolean',
        'sold' => 'boolean',
    ];

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Scopes *** ///

    public function scopeAvailable($query) {
        return $query->where('blocked', 0)->where('sold', 0);
    }

    public function scopeUnavailable($query) {
        return $query->where(function($q) {
            $q->where('blocked',1)->orWhere('sold',1);
        });
    }

    /// *** Relations *** ///

    public function timetable() {
        return $this->belongsTo(Timetable::class);
    }

    public function pricegroup() {
        return $this->belongsTo(Pricegroup::class);
    }

    public function section() {
        return $this->belongsTo(Section::class);
    }

    public function seatModel() {
        return $this->belongsTo(Seat::class, 'seat_id');
    }

    /// *** Custom *** ///

    public static function generateTickets($timetable, $group_id, $price, $seats_or_amount, $ticket_type) {
        if($timetable->type == TimetableType::PRICEGROUPS) {
            self::generateTicketsForPricegroup($timetable->id, $group_id, $price, $seats_or_amount);
        }
        if($timetable->type == TimetableType::SECTIONS) {
            if($ticket_type == TicketType::ENTER) {
                self::generateTicketsForEnterSection($timetable->id, $group_id, $price, $seats_or_amount);
            }
            if($ticket_type == TicketType::SEATS) {
                self::generateTicketsForSeatsSection($timetable->id, $group_id, $price, $seats_or_amount);
            }
        }
    }

    public static function generateTicketsForPricegroup($timetable_id, $pricegroup_id, $price, $amount) {
        for($i = 0; $i < $amount; $i++) {
            self::create([
                'timetable_id'  => $timetable_id,
                'price'         => $price,
                'pricegroup_id' => $pricegroup_id,
            ]);
        }
    }

    public static function generateTicketsForEnterSection($timetable_id, $section_id, $price, $amount) {
        self::where('timetable_id',$timetable_id)
            ->where('section_id',$section_id)
            ->update([
                'price' => $price
            ]);
        $already_exists_amount = self::where('timetable_id',$timetable_id)->where('section_id',$section_id)->count();
        if($amount > $already_exists_amount) {
            $amount = $amount - $already_exists_amount;
            for($i = 0; $i < $amount; $i++) {
                self::create([
                    'timetable_id'  => $timetable_id,
                    'price'         => $price,
                    'section_id'    => $section_id
                ]);
            }
            return true;
        }
        if($amount < $already_exists_amount) {
            $amount_to_delete = $already_exists_amount - $amount;
            self::where('timetable_id',$timetable_id)
                ->where('section_id',$section_id)
                ->available()
                ->take($amount_to_delete)
                ->delete();
            return true;
        }
        return false;
    }

    public static function generateTicketsForSeatsSection($timetable_id, $section_id, $price, $seats) {
        $existing_tickets = self::where('section_id', $section_id)
            ->where('timetable_id', $timetable_id)
            ->whereIn('seat_id', $seats)
            ->pluck('seat_id')->toArray();
        self::where('section_id', $section_id)->where('timetable_id', $timetable_id)->whereIn('seat_id',$existing_tickets)->update([
            'price' => $price
        ]);
        $seats = array_diff($seats, $existing_tickets);
        foreach($seats as $seat) {
            $obj = Seat::find($seat);
            if($obj) {
                self::create([
                    'timetable_id'  => $timetable_id,
                    'price'         => $price,
                    'section_id'    => $section_id,
                    'row'           => $obj->row,
                    'seat'          => $obj->seat,
                    'seat_id'       => $seat,
                ]);
            }
        }
    }


    public static function arrayPrices($array_of_prices) {
        $prices = array_values(array_unique($array_of_prices));
        sort($prices);
        return $prices;
    }

}
