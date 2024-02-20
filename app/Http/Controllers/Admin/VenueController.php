<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;

use App\Models\Specific\Seat;
use App\Models\Specific\Section;
use App\Models\Specific\Timetable;
use App\Models\Specific\Venue;
use App\Models\Specific\VenueScheme;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class VenueController extends Controller
{

    public function allSchemes() {
        $schemes = VenueScheme::all()->groupBy('venue_id')->all();
        return response()->json($schemes);
    }


    public function getScheme($id) {
        $scheme = VenueScheme::findOrFail($id);
        $scheme->sections;
        $scheme->venue;
        return response()->json($scheme);
    }


    public function save($id, Request $request) {
        foreach($request->sections as $section) {
            if(!isset($section['id'])) {
                Section::create([
                    'title'           => $section['title'],
                    'venue_scheme_id' => $id,
                    'svg'             => $section['svg'],
                    'for_sale'        => $section['for_sale'],
                ]);
            } else {
                Section::where('id',$section['id'])
                    ->where('venue_scheme_id', $id)
                    ->update([
                        'title'     => $section['title'],
                        'svg'       => $section['svg'],
                        'for_sale'  => $section['for_sale'],
                    ]);
            }
        }
        return $this->getScheme($id);
    }


    public function deleteSector($id) {
        $section = Section::findOrFail($id);
        $scheme_id = $section->venue_scheme_id;
        $section->delete();
        return $this->getScheme($scheme_id);
    }


    public function getSeats($id) {
        $section = Section::findOrFail($id);
        $section->seats;
        $section->scheme;
        $section->scheme->venue;
        return response()->json($section);
    }


    public function saveSeats($id, Request $request) {
        foreach($request->seats as $seat) {
            if(!isset($seat['id'])) {
                Seat::create([
                    'section_id' => $id,
                    'x' => $seat['x'],
                    'y' => $seat['y'],
                    'row' => $seat['row'],
                    'seat' => $seat['seat'],
                ]);
            } else {
                Seat::where('id',$seat['id'])
                    ->where('section_id', $id)
                    ->update([
                        'x' => $seat['x'],
                        'y' => $seat['y'],
                        'row' => $seat['row'],
                        'seat' => $seat['seat'],
                    ]);
            }
        }
        return $this->getSeats($id);
    }

    public function deleteSeats($id, Request $request) {
        Seat::where('section_id',$id)->whereIn('id',$request->seats)->delete();
        return $this->getSeats($id);
    }


}
