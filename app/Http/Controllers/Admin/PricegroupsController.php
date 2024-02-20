<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;

use App\Http\Requests\PricegroupRequest;
use App\Models\Specific\Pricegroup;
use Illuminate\Http\Request;

class PricegroupsController extends Controller
{


    public function get($timetable_id) {
        $pricegroups = Pricegroup::where('timetable_id',$timetable_id)
            ->withCount('tickets')
            ->get();
        return response()->json($pricegroups);
    }


    public function save($timetable_id, PricegroupRequest $request) {
        if($request->id) {
            $pricegroup = Pricegroup::find($request->id);
            if($pricegroup) {
                $pricegroup->update([
                    'title'     => $request->title,
                    'price'     => $request->price,
                ]);
            }
        } else {
            $pricegroup = Pricegroup::create([
                'timetable_id'  => $timetable_id,
                'title'         => $request->title,
                'price'         => $request->price,
            ]);
        }
        if($pricegroup) {
            $pricegroup->setTicketsAmount($request->amount);
        }
        return $this->get($timetable_id);
    }


    public function delete($timetable_id, $id) {
        $pricegroup = Pricegroup::find($id);
        $pricegroup->delete();
        return $this->get($timetable_id);
    }



}
