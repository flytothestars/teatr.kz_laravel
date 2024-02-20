<?php

namespace App\Models\Specific;

use App\Models\General\User;
use App\Traits\ActiveScopeTrait;
use App\Traits\AnimatedMedia;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Translatable\HasTranslations;

class Feedback extends Model {

    use HasTranslations;
    use LogsActivity;
    use ActiveScopeTrait;
    use AnimatedMedia;

    protected $table = 'feedbacks';

    public $translatable = [
        'title', 'description'
    ];

    protected $fillable = [
        'title',
        'description',
        'active',
        'date',
        'event_id',
        'primary_media_id',
        'primary_media_ext',
        'name',
        'user_id'
    ];

    protected $attributes = [
        'title' => '{}',
        'description' => '{}',
    ];

    protected $casts = [
        'active' => 'boolean'
    ];

    /// *** Media *** ///

    public $media_dir = 'feedbacks';

    public $store_primary_image = true;

    public $image_limit = 1;

    public $conversions = [
        'thumb' => [
            'type' => 'fit',
            'width' => 150,
            'height' => 150,
            'collections' => ['default']
        ],
        'main' => [
            'type' => 'resize',
            'width' => 1000,
            'height' => 1000,
            'collections' => ['default']
        ]
    ];

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Relations *** ///

    public function user() {
        return $this->belongsTo(User::class);
    }

    public function event() {
        return $this->belongsTo(Event::class);
    }

}
