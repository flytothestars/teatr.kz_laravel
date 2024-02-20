<?php


namespace App\Models\Specific;

use App\Traits\AnimatedMedia;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Translatable\HasTranslations;

class Partner extends Model
{
    use HasTranslations;
    use LogsActivity;
    use AnimatedMedia;

    protected $table = 'partners';

    protected $fillable = [
        'title',
        'description',
        'primary_media_id',
        'primary_media_ext',
    ];

    public $translatable = [
        'title',
        'description'
    ];

    protected $attributes = [
        'title' => '{}',
        'description' => '{}',
    ];

    /// *** Media *** ///

    public $media_dir = 'partners';

    public $store_primary_image = true;

    public $image_limit = 1;

    public $conversions = [
        'thumb' => [
            'type' => 'resize',
            'width' => 240,
            'height' => 240,
            'collections' => ['default']
        ],
        'main' => [
            'type' => 'resize',
            'width' => 600,
            'height' => 600,
            'collections' => ['default']
        ]
    ];

    public function sluggable(): array
    {
        return [
            'slug' => [
                'source' => 'title'
            ]
        ];
    }

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

}
