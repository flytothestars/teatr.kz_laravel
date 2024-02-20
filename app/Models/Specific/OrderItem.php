<?php

namespace App\Models\Specific;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;
use Spatie\Activitylog\Traits\LogsActivity;

class OrderItem extends Model {

    use LogsActivity;

    protected $table = 'order_items';

    public $timestamps = false;

    protected $fillable = [
        'order_id',
        'timetable_id',
        'section_id',
        'pricegroup_id',
        'ticket_id',
        'row',
        'seat',
        'price',
        'barcode'
    ];

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Relations *** ///

    public function order() {
        return $this->belongsTo(Order::class);
    }

    public function timetable() {
        return $this->belongsTo(Timetable::class);
    }

    public function section() {
        return $this->belongsTo(Section::class);
    }

    public function pricegroup() {
        return $this->belongsTo(Pricegroup::class);
    }

    /// *** Custom *** ///

    public function generateBarcode() {
        if(!$this->barcode) {
            $this->barcode = Str::padLeft($this->id, 8, '0').random_int(1000,9999);
            $this->save();
        }
    }


}
