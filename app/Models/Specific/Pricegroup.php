<?php

namespace App\Models\Specific;

use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Translatable\HasTranslations;

class Pricegroup extends Model {

    use HasTranslations;
    use LogsActivity;

    protected $table = 'pricegroups';

    public $translatable = [
        'title'
    ];

    protected $fillable = [
        'title',
        'api_id',
        'timetable_id',
        'price',
        'sort_order'
    ];

    protected $attributes = [
        'title' => '{}',
    ];

    protected $appends = ['amount'];

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Attributes *** ///

    public function getAmountAttribute() {
        return $this->tickets_count ? $this->tickets_count : null;
    }

    /// *** Relations *** ///

    public function tickets() {
        return $this->hasMany(Ticket::class);
    }

    /// *** Custom *** ///

    public function setTicketsAmount($amount) {
        $this->tickets()->update([
            'price' => $this->price
        ]);
        $already_exists_amount = $this->tickets()->count();
        if($amount >= $already_exists_amount) {
            $amount = $amount - $already_exists_amount;
            for($i = 0; $i < $amount; $i++) {
                Ticket::create([
                    'timetable_id'  => $this->timetable_id,
                    'price'         => $this->price,
                    'pricegroup_id' => $this->id,
                ]);
            }
            return true;
        }
        if($amount < $already_exists_amount) {
            $amount_to_delete = $already_exists_amount - $amount;
            Ticket::where('timetable_id',$this->timetable_id)
                ->where('pricegroup_id',$this->id)
                ->available()
                ->take($amount_to_delete)
                ->delete();
            return true;
        }
        return false;
    }


    public function delete() {
        if($this->tickets()->unavailable()->count() > 0) {
            return false;
        }
        $this->tickets()->delete();
        return parent::delete();
    }

}


