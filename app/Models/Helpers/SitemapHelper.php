<?php

namespace App\Models\Helpers;

//use Illuminate\Support\Facades\DB;
//use Spaceduck\Shop\Models\Product;
//use Spaceduck\Shop\Models\ProductCategory;
use Carbon\Carbon;
use Spatie\Sitemap\Sitemap;
//use Spatie\Sitemap\SitemapGenerator;
use Spatie\Sitemap\Tags\Url;

class SitemapHelper {

    public static function generateSitemap($write_to_file = true) {


//        $gen = SitemapGenerator::create(env('APP_URL'))->getSitemap();
//        $gen = Sitemap::create(env('APP_URL'));
        $gen = Sitemap::create();
        $gen->add(Url::create('/')->setPriority(1)
            ->setChangeFrequency(Url::CHANGE_FREQUENCY_DAILY)
            ->setLastModificationDate(Carbon::yesterday())
        );
//        $gen->add(Url::create('/ru')->setPriority(1));
//        $gen->add(Url::create('/ru/category')->setPriority(1));
//        $gen->add(Url::create('/ru/news')->setPriority(0.9));
//        $gen->add(Url::create('/ru/manufacturers')->setPriority(0.9));
//        $gen->add(Url::create('/kz')->setPriority(1));

//        $pages = Page::where('published',1)->get();
//        foreach($pages as $page) {
//            $gen->add(Url::create($page->link('ru'))->setPriority(1));
//        }
//        foreach($categories as $category) {
//            $gen->add(Url::create($category->link('ru'))->setPriority(0.9));
//        }
//        foreach($portfolio as $d) {
//            $gen->add(Url::create($d->link('ru'))->setPriority(0.8));
//        }
        if($write_to_file) {
            $gen->writeToFile(public_path('sitemap.xml'));
        }

    }
}