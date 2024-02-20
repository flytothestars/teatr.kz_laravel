<?php


namespace App\Models\Specific;

use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Translatable\HasTranslations;

class VenueScheme extends Model
{
    use HasTranslations;
    use LogsActivity;

    protected $table = 'venue_schemes';

    public $timestamps = false;

    protected $fillable = [
        'title', 'venue_id'
    ];

    public $translatable = [
        'title'
    ];

    protected $attributes = [
        'title' => '{}',
    ];

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Relations *** ///

    public function venue() {
        return $this->belongsTo(Venue::class,'venue_id');
    }

    public function sections() {
        return $this->hasMany(Section::class,'venue_scheme_id');
    }
}