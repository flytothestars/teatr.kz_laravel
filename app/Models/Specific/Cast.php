<?php

namespace App\Models\Specific;

use App\Traits\AnimatedMedia;
use Cviebrock\EloquentSluggable\Sluggable;
use Cviebrock\EloquentSluggable\SluggableScopeHelpers;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Translatable\HasTranslations;

class Cast extends Model {

    use HasTranslations;
    use LogsActivity;
    use AnimatedMedia;
    use Sluggable;
    use SluggableScopeHelpers;

    protected $table = 'cast';

    public $translatable = [
        'name', 'description'
    ];

    protected $fillable = [
        'name',
        'description',
        'primary_media_id',
        'primary_media_ext',
        'actor',
        'director',
        'artist',
        'active'
    ];

    protected $attributes = [
        'name'        => '{}',
        'description' => '{}',
    ];

    protected $casts = [
        'active'    => 'boolean',
        'actor'     => 'boolean',
        'director'  => 'boolean',
        'artist'    => 'boolean',
    ];

    /// *** Media *** ///

    public $media_dir = 'cast';

    public $store_primary_image = true;

    public $image_limit = 6;

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

    public function sluggable(): array {
        return [
            'slug' => [
                'source' => 'name'
            ]
        ];
    }

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Relations *** ///

    public function events() {
        return $this->belongsToMany(Event::class, 'event_cast', 'cast_id', 'event_id');
    }

    /// *** Attributes *** ///

    public function getLinkAttribute() {
        return '/cast/'.$this->slug;
    }

}
