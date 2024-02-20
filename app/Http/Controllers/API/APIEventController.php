<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Helpers\AfishaFilter;
use App\Models\Specific\Category;
use App\Models\Specific\Event;
use App\Models\Specific\Timetable;
use App\Models\Specific\Venue;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;

class APIEventController extends Controller {


    public function getEvents(Request $request) {
        $filter = new AfishaFilter($request->filters);
        $events = Event::afisha($filter);
        return response()->json([
            'events' => $events,
        ]);
    }


    public function getFilters() {
        $venues = Venue::all();
        $genres = Category::active()->get();
        return response()->json([
            'venues' => $venues,
            'genres' => $genres,
        ]);
    }

    public function getEvent($id) {
        $event = Event::findOrFail($id);
        $event->timetables = $event->timetables()
            ->active()
            ->with('venue')
            ->get();
//        $event->timetables->venue;
        return response()->json([
            'event' => $event,
        ]);
    }

    public function getTimetable($id) {
        $timetable = Timetable::findOrFail($id);
        $timetable->event;
        $timetable->pricegroups;
        $venue = $timetable->venue;
        $scheme = $timetable->scheme;
        $scheme->sections;
        $tickets = $timetable->groupedCountTickets();
        return response()->json([
            'timetable' => $timetable,
            'tickets'   => $tickets,
            'venue'     => $venue,
            'scheme'    => $scheme,
        ]);
    }


    public function getSection($timetable_id, $id) {
        $timetable = Timetable::findOrFail($timetable_id);
        return response()->json($timetable->getTicketsForGroup($id, false));
    }




}
