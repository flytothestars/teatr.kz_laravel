<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\General\News;
use App\Models\Helpers\AfishaFilter;
use App\Models\Specific\Event;
use App\Models\Specific\Feedback;
use App\Models\Specific\Venue;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class EventController extends Controller {


    public function afisha() {
        $events = Event::allAfisha();
        $news = News::active()->orderBy('date','desc')->simplePaginate(6);
        $feedbacks = Feedback::active()->simplePaginate(6);
        $city_id = session('city', 1);
        $venues = Venue::where('city_id', $city_id)->simplePaginate(8);
        return view('content.home.home',compact('events','news','feedbacks','venues'));
    }


    public function afishaDynamic(Request $request) {
        $filter = new AfishaFilter($request->filters);
        $events = $filter->time == 'all' ? Event::allAfisha($filter) : Event::afisha($filter);
        return response()->json([
            'events' => $events,
            'html'   => view('content.home.home__events_dynamic', compact('events'))->render()
        ]);
    }


    public function search(Request $request) {
        $events = Event::afisha(new AfishaFilter(json_encode(['q' => $request->q])));
        return view('content.search.search',compact('events'));
    }


    public function event($slug) {
        $event = Event::findBySlug($slug);
        $event->addToRecentlySeen();
        $media = $event->getMedia();
        $timetables = $event->timetables()
            ->future()
            ->active()
            ->with('venue')
            ->with('event')
            ->get();
        $cast = $event->cast()->get()->all();
        $feedbacks = $event->feedbacks()->active()->simplePaginate(6);
        $venues = [];
        $tmp_ids = [];
        foreach($timetables as $t) {
            if(!in_array($t->venue_id, $tmp_ids)) {
                $venues[] = $t->venue;
                $tmp_ids[] = $t->venue_id;
            }
        }
        return view('content.event.event',compact('event','timetables', 'venues', 'cast', 'media','feedbacks'));
    }


    public function widget(Request $request) {
        $user = Auth::user();
        if($user && !$user->api_token) {
            $user->generateAPIToken();
        }
        return view('content.event.widget', ['widget' => true]);
    }

    public function new_widget()
    {
        $user = Auth::user();
        if($user && !$user->api_token) {
            $user->generateAPIToken();
        }
        // dd(view('content.event.new_widget', ['new_widget' => true]));
        return view('content.event.new_widget', ['new_widget' => true]);    
    }
    public function widget_without_pay(Request $request) {
        $user = Auth::user();
        if($user && !$user->api_token) {
            $user->generateAPIToken();
        }
        return view('content.event.widget_without_pay', ['widget_without_pay' => true]);
    }

}
