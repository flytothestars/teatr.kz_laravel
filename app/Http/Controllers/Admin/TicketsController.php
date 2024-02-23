<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;

use App\Models\Specific\Order;
use App\Models\Specific\Ticket;
use App\Models\Specific\Timetable;
use Illuminate\Http\Request;

class TicketsController extends Controller
{


    public function getTickets($timetable_id, $group_id) {
        $timetable = Timetable::findOrFail($timetable_id);
        return response()->json($timetable->getTicketsForGroup($group_id, true));
    }


    public function saveTickets($timetable_id, $group_id, Request $request) {
        $timetable = Timetable::findOrFail($timetable_id);
        $rules = [
            'price' => 'required|numeric|min:1',
            'type'  => 'required|in:enter,seats',
        ];
        $type = $request->type;
        if($type == 'enter') {
            $rules['amount'] = 'required|numeric|min:0';
        }
        if($type == 'seats') {
            $rules['seats'] = 'required|array|min:1';
        }
        $request->validate($rules);
        Ticket::generateTickets($timetable, $group_id, $request->price, $type == 'enter' ? $request->amount : $request->seats, $type);
        return $this->getTickets($timetable_id, $group_id);
    }


    public function deleteTickets($timetable_id, $group_id, Request $request) {
        $timetable = Timetable::findOrFail($timetable_id);

        $timetable->tickets()
            ->where('section_id',$group_id)
            ->whereIn('seat_id',$request->seats)
            ->available()
            ->delete();

        return $this->getTickets($timetable_id, $group_id);
    }


    public function sendTickets($id) {
        $order = Order::where('id',$id)->where('paid',1)->first();
        if(!$order) {
            abort(404);
        }
        if($order->sendByEmail()) {
            return "письмо отправлено";
        } else {
            return "из-за технической ошибки письмо не отправлено";
        }
    }


    public function orderDetails($id) {
        $order = Order::withTrashed()->findOrFail($id);
        $order->orderItems;
        $order->timetable;
        $html = view('admin.orderdetails',compact('order'))->render();
        return response()->json([
            'order' => $order,
            'html'  => $html
        ]);
    }

}
