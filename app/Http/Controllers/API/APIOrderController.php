<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\OrderFillRequest;
use App\Http\Requests\OrderInitRequest;
use App\Models\API\TicketAPIInterface;
use App\Models\Specific\Event;
use App\Models\Specific\Order;
use App\Models\Specific\OrderItem;
use App\Models\Specific\Timetable;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class APIOrderController extends Controller
{


    public function getOrder($id, $hash, Request $request)
    {
        $order = Order::where('id', $id)
            ->with('timetable')
            ->with('timetable.event')
            ->with('orderItems')
            ->with('orderItems.section')
            ->where('hash', $hash)
            ->first();
        if (!$order) {
            abort(404);
        }
        return response()->json([
            'order' => $order,
            'user' => $request->user('api')
        ]);
    }


    public function initOrder(OrderInitRequest $request)
    {

        $timetable = Timetable::findOrFail($request->timetable_id);

        if (!$timetable->active) {
            return response()->json(['error' => 'Мероприятие недоступно']);
        }

        $user = $request->user('api');

        $order = Order::create([
            'articul' => $this->generateRandomArticul(),
            'timetable_id' => $request->timetable_id,
            'user_id' => $user ? $user->id : null,
            'api' => $timetable->api,
            'ip' => $request->ip()
        ]);

        $order->price = $order->populateFromCart($request->cart);

        if ($timetable->api_id) {
            $api_class = $timetable->getAPIClass();
            if (!$api_class) {
                return response()->json(['error' => 'API недоступен']);
            }
            $api = new $api_class;
            $response = $api->createOrder($timetable, $request->cart, $order);
            if (!$response) {
                return response()->json(['error' => 'Произошла ошибка - попробуйте позднее']);
            }
        }

        $order->generateHash();
        $order->save();

        return response()->json([
            'order' => $order,
            'user' => $request->user('api')
        ]);
    }

    function generateRandomArticul($length = 8)
    {
        $characters = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters) - 1;

        $randomString = '';
        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[rand(0, $charactersLength)];
        }

        return $randomString;
    }


    public function fillOrder(OrderFillRequest $request, $id, $hash)
    {
        $user = $request->user('api');
        $order = Order::where('id', $id)
            ->with('orderItems')
            ->where('hash', $hash)
            ->first();

        if (!$order) {
            abort(404);
        }
        if ($order->paid) {
            return response()->json(['error' => "Заказ уже оплачен"]);
        }

        $pay_system = $request->pay_system;

        $order->update([
            // 'name'       => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'user_id' => null,
            'pay_system' => $pay_system,
        ]);

        // if ($user) {
        //     $user->update([
        //         'name' => $request->name,
        //         'phone' => $request->phone,
        //     ]);
        // }

        // if ($user && $user->id == 1) {
            // return response()->json(['success' => 1]);
        // }
        if ($pay_system == 'card') { // cloud payment
            return response()->json(['success' => 1]);
        }

        return response()->json(['success' => 0]);
    }

    public function cancelOrder(Request $request, $id, $hash)
    {
        $order = Order::where('id', $id)
            ->with('orderItems')
            ->where('hash', $hash)
            ->first();
        if ($order && !$order->paid) {
            $order->delete();
        }
        return response()->json(true);
    }

    public function getAboutTicket(Request $request, $code)
    {
        $orderItem = OrderItem::where('barcode', $code)
            ->with('order')
            ->with('timetable')
            ->with('section')
            ->with('section.scheme')
            ->with('timetable.event')
            ->with('timetable.venue')->first();
        $order = Order::where('id', $orderItem->order_id)->first();
        if ($order) {
            if ($order->confirmed) {
                return response()->json([
                    'success' => false,
                    'data' => $orderItem,
                    'msg' => 'Билет проверен',
                ]);
            }
            return response()->json([
                'success' => true,
                'data' => $orderItem,
                'msg' => 'Билет не проверен'
            ]);
        }
        return response()->json([
            'success' => false,
            'data' => null
        ]);
    }

    public function ticketChecked($code)
    {

        $orderItem = OrderItem::where('barcode', $code)->first();
        $order = Order::where('id', $orderItem->order_id)->first();
        if ($order) {
            if ($order->confirmed) {
                return response()->json([
                    'success' => false,
                    'data' => '',
                    'msg' => 'Билет был проверен',
                ]);
            }
            $order->confirmed = 1;
            $order->save();
            return response()->json([
                'success' => true,
                'data' => 'Билет проверен'
            ]);
        }
        return response()->json([
            'success' => false,
            'data' => 'Билет недействителен'
        ]);
    }

}
