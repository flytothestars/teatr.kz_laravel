<?php

namespace App\Models\General;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Cache;
use Spatie\Translatable\HasTranslations;

class Setting extends Model
{
    use HasTranslations;

    protected $table = 'settings';

    public $translatable = [
        'body'
    ];

    protected $fillable = [
        'body', 'description','code'
    ];

    protected $attributes = [
        'body' => '{}',
    ];

//    public static function customCreate($request) {
//        $data = $request->all();
//        $set = Setting::create($data);
//        return $set;
//    }
//
//    public function customUpdate($request) {
//        $data = $request->all();
//        $this->update($data);
//        return $this;
//    }

    public static function getSettings() {
        return Cache::remember('settings',3600, function() {
            return Setting::all()->keyBy('code');
        });
    }


}
