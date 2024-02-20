<?php

namespace App\Models\Specific;

use App\Models\General\User;
use App\Models\Helpers\AfishaFilter;
use App\Traits\ActiveScopeTrait;
use App\Traits\AnimatedMedia;
use Cviebrock\EloquentSluggable\Sluggable;
use Cviebrock\EloquentSluggable\SluggableScopeHelpers;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Translatable\HasTranslations;

class Event extends Model {

    use HasTranslations;
    use LogsActivity;
    use ActiveScopeTrait;
    use SoftDeletes;
    use AnimatedMedia;
    use Sluggable;
    use SluggableScopeHelpers;

    protected $table = 'events';

    public $translatable = [
        'title', 'description'
    ];

    protected $fillable = [
        'title',
        'description',
        'api_id',
        'api',
        'category_id',
        'ticket_design_id',
        'organizator_id',
        'primary_media_id',
        'primary_media_ext',
        'min_price',
        'max_price',
        'duration',
        'active',
    ];

    protected $attributes = [
        'title' => '{}',
        'description' => '{}',
    ];

    protected $casts = [
        'active' => 'boolean'
    ];

    public function sluggable(): array
    {
        return [
            'slug' => [
                'source' => 'title'
            ]
        ];
    }

    protected $appends = ['link', 'teaser', 'short'];

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Media *** ///

    public $media_dir = 'events';

    public $store_primary_image = true;

    public $image_limit = 6;

    public $conversions = [
        'thumb' => [
            'type' => 'fit',
            'width' => 150,
            'height' => 150,
            'collections' => ['default']
        ],
        'teaser' => [
            'type' => 'fit',
            'width' => 720,
            'height' => 400,
            'collections' => ['default']
        ],
        'main' => [
            'type' => 'resize',
            'width' => 1200,
            'height' => 1000,
            'collections' => ['default']
        ]
    ];

    /// *** Attributes *** ///

    public function getLinkAttribute() {
        return '/event/'.$this->slug;
    }

    public function getTeaserAttribute() {
        return $this->imagePrimarySrc('teaser');
    }

    public function getShortAttribute() {
        return Str::limit(strip_tags($this->description), 100, '');
    }

    /// *** Relations *** ///

    public function category() {
        return $this->belongsTo(Category::class);
    }

    public function ticketDesign() {
        return $this->belongsTo(TicketDesign::class, 'ticket_design_id');
    }

    public function organizator() {
        return $this->belongsTo(User::class, 'organizator_id');
    }

    public function timetables() {
        return $this->hasMany(Timetable::class)->orderBy('datetime','asc');
    }

    public function cast() {
        return $this->belongsToMany(Cast::class, 'event_cast', 'event_id', 'cast_id');
    }

    public function feedbacks() {
        return $this->hasMany(Feedback::class, 'event_id');
    }

    /// *** Custom *** ///

    public static function afisha($filters = []) {
        $city = isset($filters->city) ? $filters->city : session('city', env('DEFAULT_CITY'));
        $order_ids = Timetable::future()->active()->orderBy('datetime','asc')->pluck('event_id')->toArray();
        $rawOrder = DB::raw(sprintf('FIELD(id, %s)', implode(',', $order_ids)));
        $q = Event::active()
            ->whereHas('timetables',function($q) use($filters, $city) {
                $q->future()->active()->whereHas('venue', function($q) use($city) {
                    $q->where('city_id', $city);
                })->orderBy('datetime', 'asc');
                if($filters && isset($filters->venue)) {
                    $q->where('venue_id',$filters->venue);
                }
                if($filters && isset($filters->time)) {
                    switch($filters->time) {
                        case "today":
                            $q->today();
                            break;
                        case "weekend":
                            $q->weekend();
                            break;
                        case "month":
                            $q->month();
                            break;
                    }
                }
            })
            ->with('category')
            ->with('timetables')
            ->with('timetables.venue');

        if($filters && isset($filters->genre)) {
            $q->where('category_id',$filters->genre);
        }
        if($filters && isset($filters->ids)) {
            $q->whereIn('id', $filters->ids);
        }
        if($filters && isset($filters->cast)) {
            $q->whereHas('cast', function($q) use($filters) {
                $q->where('id', $filters->cast);
            });
        }
        if($filters && isset($filters->q)) {
            $q->whereRaw('JSON_UNQUOTE(JSON_EXTRACT(title,"$.ru")) LIKE ?', ['%'.$filters->q.'%']);
        }
        $q->orderByRaw($rawOrder);
//        return $q->paginate(2);
        return $q->paginate(14);
    }


    public static function recentlySeen() {
        return self::afisha(new AfishaFilter(json_encode(['ids' => session('looked', [])])));
    }

    public function addToRecentlySeen() {
        $looked = session('looked',[]);
        $looked[] = $this->id;
        $looked = array_unique($looked);
        $limit = 9;
        if(count($looked) > $limit) {
            $looked = array_slice($looked,-$limit, $limit);
        }
        session(['looked' => $looked]);
    }


    public static function customCreate($request) {
        $data = $request->all();
        $obj = self::create($data);
        $obj->cast()->sync($request->cast);
        return $obj;
    }


    public function customUpdate($request) {
        $data = $request->all();
        $this->update($data);
        $this->cast()->sync($request->cast);
        return $this;
    }

}
