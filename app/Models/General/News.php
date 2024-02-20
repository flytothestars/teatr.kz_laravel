<?php

namespace App\Models\General;

use App\Traits\ActiveScopeTrait;
use App\Traits\AnimatedMedia;
use Cviebrock\EloquentSluggable\Sluggable;
use Cviebrock\EloquentSluggable\SluggableScopeHelpers;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Translatable\HasTranslations;

class News extends Model {

    use HasTranslations;
    use LogsActivity;
    use AnimatedMedia;
    use ActiveScopeTrait;
    use Sluggable;
    use SluggableScopeHelpers;

    protected $table = 'news';

    public $translatable = [
        'title', 'teaser', 'description'
    ];

    protected $fillable = [
        'title',
        'teaser',
        'description',
        'primary_media_id',
        'primary_media_ext',
        'date',
        'user_id',
        'active'
    ];

    protected $attributes = [
        'title'       => '{}',
        'teaser'      => '{}',
        'description' => '{}',
    ];

    protected $casts = [
        'active' => 'boolean',
    ];

    public function sluggable(): array
    {
        return [
            'slug' => [
                'source' => 'title'
            ]
        ];
    }

    /// *** Media *** ///

    public $media_dir = 'news';

    public $store_primary_image = true;

    public $image_limit = 1;

    public $conversions = [
        'thumb' => [
            'type' => 'fit',
            'width' => 300,
            'height' => 300,
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

    /// *** Attributes *** ///

    public function getLinkAttribute() {
        return '/news/'.$this->slug;
    }

    /// *** Relations *** ///

    public function user() {
        return $this->hasMany(User::class);
    }
}
