<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\General\News;
use App\Models\General\Page;
use App\Models\Helpers\AfishaFilter;
use App\Models\Specific\Cast;
use App\Models\Specific\Event;
use App\Models\Specific\Feedback;
use App\Models\Specific\Partner;
use App\Models\Specific\Timetable;
use App\Models\Specific\Venue;

class ContentController extends Controller {

    public function partners() {
        $partners = Partner::all();
        return view('content.partners.partners', compact('partners'));
    }

    public function feedbacks() {
        $feedbacks = Feedback::paginate(10);
        return view('content.reviews.reviews', compact('feedbacks'));
    }

    public function news() {
        $news = News::active()->orderBy('date','desc')->paginate(12);
        return view('content.news.news', compact('news'));
    }

    public function newsItem($slug) {
        $newsitem = News::findBySlug($slug);
        if(!$newsitem || !$newsitem->active) { abort(404); }
        $latest = News::where('id', '<>', $newsitem->id)->orderBy('date','desc')->take(3)->get();
        return view('content.news.newsitem', compact('newsitem','latest'));
    }

    public function cast($slug) {
        $cast = Cast::findBySlug($slug);
        if(!$cast) { abort(404); }
        $media = $cast->getMedia();
        $timetables = Timetable::whereIn('event_id', $cast->events()->pluck('id')->toArray())->future()->active()->get();
        return view('content.cast.cast', compact('cast', 'media','timetables'));
    }

    public function venues() {
        $city_id = session('city', 1);
        $venues = Venue::where('city_id', $city_id)->paginate(10);
        return view('content.venues.venues', compact('venues'));
    }

    public function venueItem($slug) {
        $venueitem = Venue::findBySlug($slug);
        $media = $venueitem->getMedia();
        $venues = Venue::where('id','<>',$venueitem->id)->simplePaginate(8);
        $events = Event::afisha(new AfishaFilter(json_encode(['venue' => $venueitem->id])));
        return view('content.venues.venueitem', compact('venueitem','media', 'events','venues'));
    }

    public function page($slug) {
        $page = Page::findBySlug($slug);
        if(!$page || !$page->active) {
            abort(404);
        }
        return view('content.page.page', compact('page'));
    }
}
