<?php

namespace App\Models\Specific;

use App\Traits\AnimatedMedia;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;

class TicketDesign extends Model {

    use LogsActivity;
    use AnimatedMedia;

    protected $table = 'ticket_designs';

    public $timestamps = false;

    protected $fillable = [
        'title',
        'title_exists','title_l','title_r','title_t',
        'ticketn_exists','ticketn_l','ticketn_r','ticketn_t',
        'barcode_exists','barcode_l','barcode_r','barcode_t',
        'qr_exists','qr_l','qr_r','qr_t',
        'date_exists','date_l','date_r','date_t',
        'section_exists','section_l','section_r','section_t',
        'row_exists','row_l','row_r','row_t',
        'seat_exists','seat_l','seat_r','seat_t',
        'price_exists','price_l','price_r','price_t',
        'order_exists','order_l','order_r','order_t',
        'user_exists','user_l','user_r','user_t',
        'price_exists','price_l','price_r','price_t',
        'venue_exists','venue_l','venue_r','venue_t',
    ];

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Media *** ///

    public $media_dir = 'ticket_designs';

    public $image_limit = 1;

    public $conversions = [
        'thumb' => [
            'type' => 'fit',
            'width' => 150,
            'height' => 150,
            'collections' => ['default']
        ],
        'teaser' => [
            'type' => 'fit',
            'width' => 600,
            'height' => 600,
            'collections' => ['default']
        ],
        'main' => [
            'type' => 'resize',
            'width' => 1200,
            'height' => 1000,
            'collections' => ['default']
        ]
    ];

}
