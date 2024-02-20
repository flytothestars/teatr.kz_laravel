<?php

namespace App\Models\Specific;

use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Translatable\HasTranslations;

class Section extends Model {

    use HasTranslations;
    use LogsActivity;

    protected $table = 'sections';

    protected $fillable = [
        'title',
        'venue_scheme_id',
        'svg',
        'for_sale'
    ];

    public $translatable = [
        'title'
    ];

    protected $attributes = [
        'title' => '{}',
    ];

    protected $casts = [
        'svg'      => 'json',
        'for_sale' => 'boolean'
    ];

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Relations *** ///

    public function scheme() {
        return $this->belongsTo(VenueScheme::class, 'venue_scheme_id');
    }

    public function seats() {
        return $this->hasMany(Seat::class);
    }
}
