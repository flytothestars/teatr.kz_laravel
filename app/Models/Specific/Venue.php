<?php


namespace App\Models\Specific;

use App\Traits\AnimatedMedia;
use Cviebrock\EloquentSluggable\Sluggable;
use Cviebrock\EloquentSluggable\SluggableScopeHelpers;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Translatable\HasTranslations;

class Venue extends Model
{
    use HasTranslations;
    use LogsActivity;
    use AnimatedMedia;
    use Sluggable;
    use SluggableScopeHelpers;

    protected $table = 'venues';

    protected $fillable = [
        'title',
        'description',
        'address',
        'city_id',
        'x_coord',
        'y_coord',
        'primary_media_id',
        'primary_media_ext',
    ];

    public $translatable = [
        'title',
        'address',
        'description'
    ];

    protected $attributes = [
        'title' => '{}',
        'address' => '{}',
        'description' => '{}',
    ];

    /// *** Media *** ///

    public $media_dir = 'venues';

    public $store_primary_image = true;

    public $image_limit = 6;

    public $conversions = [
        'thumb' => [
            'type' => 'resize',
            'width' => 400,
            'height' => 240,
            'collections' => ['default']
        ],
        'main' => [
            'type' => 'resize',
            'width' => 1200,
            'height' => 1000,
            'collections' => ['default']
        ]
    ];

    protected $appends = ['link'];

    public function sluggable(): array {
        return [
            'slug' => [
                'source' => 'title'
            ]
        ];
    }

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Relations *** ///

    public function city() {
        return $this->belongsTo(City::class,'city_id');
    }

    public function schemes() {
        return $this->hasMany(VenueScheme::class,'venue_id');
    }

    /// *** Attributes *** ///

    public function getLinkAttribute() {
        return '/theatres/'.$this->slug;
    }

}
