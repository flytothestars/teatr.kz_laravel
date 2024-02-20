<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;

use App\Models\Specific\Timetable;

class TimetableController extends Controller
{

    public function get($id) {
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



}
