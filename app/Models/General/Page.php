<?php

namespace App\Models\General;
use App\Traits\ActiveScopeTrait;
use Cviebrock\EloquentSluggable\Sluggable;
use Cviebrock\EloquentSluggable\SluggableScopeHelpers;
use Illuminate\Database\Eloquent\Model;
use Spatie\Translatable\HasTranslations;

class Page extends Model
{
    use HasTranslations;
    use Sluggable;
    use SluggableScopeHelpers;
    use ActiveScopeTrait;


    protected $fillable = [
        'title',
        'body',
        'page_group',
        'slug',
        'active',
    ];

    public $translatable = [
        'title', 'body'
    ];

    public function sluggable(): array
    {
        return [
            'slug' => [
                'source' => 'title'
            ]
        ];
    }

    protected $attributes = [
        'title' => '{}',
        'body'  => '{}',
    ];

    protected $casts = [
        'active' => 'boolean'
    ];

    protected $appends = ['link'];

    public function getLinkAttribute() {
        return '/'.$this->slug;
    }



}
