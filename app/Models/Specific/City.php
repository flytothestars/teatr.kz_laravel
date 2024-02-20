<?php

namespace App\Models\Specific;

use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Translatable\HasTranslations;

class City extends Model {

    use HasTranslations;
    use LogsActivity;

    protected $table = 'cities';

    public $timestamps = false;

    public $translatable = [
        'title'
    ];

    protected $fillable = [
        'title'
    ];

    protected $attributes = [
        'title' => '{}',
    ];

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Relations *** ///

    public function venues() {
        return $this->hasMany(Venue::class);
    }
}
