<?php

namespace App\Models\General;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Cache;
use Spatie\Translatable\HasTranslations;

class MenuItem extends Model
{
    use HasTranslations;

    protected $table = 'menu_items';

    protected $fillable = [
        'title',
        'url',
        'sort_order',
        'header',
        'footer1',
        'footer2',
        'footer3'
    ];

    public $translatable = [
        'title'
    ];

    protected $attributes = [
        'title' => '{}',
    ];

    protected $casts = [
        'header' => 'boolean',
        'footer1' => 'boolean',
        'footer2' => 'boolean',
        'footer3' => 'boolean',
    ];



    public static function getMenu() {
        return Cache::remember('menu',3600, function() {
            return MenuItem::orderBy('sort_order','desc')->get();
        });
    }

}
