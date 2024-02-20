<?php

namespace App\Models\Specific;

use App\Traits\ActiveScopeTrait;
use Illuminate\Database\Eloquent\Model;
use Spatie\Activitylog\Traits\LogsActivity;
use Spatie\Translatable\HasTranslations;

class Category extends Model {

    use HasTranslations;
    use LogsActivity;
    use ActiveScopeTrait;

    protected $table = 'categories';

    public $translatable = [
        'title'
    ];

    protected $fillable = [
        'title', 'active'
    ];

    protected $attributes = [
        'title' => '{}',
    ];

    protected $casts = [
        'active' => 'boolean'
    ];

    /// *** Logging *** ///

    protected static $logFillable = true;

    protected static $logOnlyDirty = true;

    /// *** Relations *** ///

    public function events() {
        return $this->hasMany(Event::class);
    }


}
