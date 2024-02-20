<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;

use App\Models\API\CloudPaymentAPI;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Spaceduck\Shop\Mail\ClientOrderMade;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Spaceduck\Shop\Models\Driver;
use Spaceduck\Shop\Models\Order;
use Spaceduck\Shop\Models\OrderItem;
use Spaceduck\Shop\Models\PDF\PDFOrder;
use Spaceduck\Shop\Models\PDF\PDFRoutesList;

class OrdersController extends Controller
{

    public function orderShow($order_id) {
        $order = $this->orderForPage($order_id);
        return json_encode($order);
    }

    public function orderForPage($order_id) {
        $order = Order::with('orderItems')->with('orderItems.product')->with('bonusTransactions')->find($order_id);
        $order->sum_before_general_discount = $order->sum_before_general_discount();
        $order->sum_to_pay = $order->getSumToPay();
        return $order;
    }

    public function mailSend($id, Request $request) {
        $order = Order::find($id);
        if(env('SEND_EMAILS') ==  1) {
            Mail::send(new ClientOrderMade($order,app()->getLocale()));
        }
    }

    public function approve($order_id, Request $request) {
        $order = Order::findOrFail($order_id);
        $amount = $order->getSumToPay();
//        $approval_code = $order->approval_code;
        $pay_id = $order->pay_id;
        $to_confirm = min($amount, $order->pay_summ);
//        $response = CloudPaymentAPI::confirmPayment($pay_id, $to_confirm);
//        Log::error("::: CLOUD APPROVE :::");
//        Log::error((array)$response);
//        if($response->Success) {
//            if($amount > $to_confirm) {
//                $response = CloudPaymentAPI::tokenPayment($order, ($amount - $to_confirm));
//                Log::error("::: CLOUD TOKEN PAY :::");
//                Log::error((array)$response);
//                if($response->Success) {
//                    $order->paidSuccessfully($pay_id, $amount);
//                    return json_encode(['success' => 1, 'order' => $this->orderForPage($order_id)]);
//                } else {
//                    return json_encode(['success' => 0]);
//                }
//            } else {
//                $order->paidSuccessfully($pay_id, $amount);
//                return json_encode(['success' => 1, 'order' => $this->orderForPage($order_id)]);
//            }
//        } else {
//            return json_encode(['success' => 0]);
//        }
        if($amount > $to_confirm) {
            $response = CloudPaymentAPI::tokenPayment($order, ($amount - $to_confirm));
            Log::error("::: CLOUD TOKEN PAY :::");
            Log::error((array)$response);
            if(!$response->Success) {
                return json_encode(['success' => 0]);
            }
            $order->update([
                'pay_id_add' => $response->Model->TransactionId,
                'pay_summ_add' => $response->Model->Amount,
            ]);
            $response = CloudPaymentAPI::confirmPayment($pay_id, $to_confirm);
            Log::error("::: CLOUD APPROVE :::");
            Log::error((array)$response);
            if(!$response->Success) {
                CloudPaymentAPI::refundPayment($order->pay_id_add, $order->pay_summ_add);
                return json_encode(['success' => 0]);
            }
            $order->paidSuccessfully($pay_id, $to_confirm);
            return json_encode(['success' => 1, 'order' => $this->orderForPage($order_id)]);

        } else {
            $response = CloudPaymentAPI::confirmPayment($pay_id, $to_confirm);
            Log::error("::: CLOUD APPROVE :::");
            Log::error((array)$response);
            if(!$response->Success) {
                return json_encode(['success' => 0]);
            }
            $order->paidSuccessfully($pay_id, $amount);
            return json_encode(['success' => 1, 'order' => $this->orderForPage($order_id)]);
        }
    }


    public function cancel($order_id, Request $request) {
        $order = Order::findOrFail($order_id);
        if($order->pay_method == 'card' && $order->status == 'authorized') {
            $pay_id = $order->pay_id;
            $response = CloudPaymentAPI::cancelPayment($pay_id);
            Log::error("::: CLOUD CANCEL :::");
            Log::error((array)$response);
            if($response->Success) {
                $order->orderCancelled();
                return json_encode(['success' => 1, 'order' => $this->orderForPage($order_id)]);
            } else {
                return json_encode(['success' => 0]);
            }
        } else {
            $order->orderCancelled();
            return json_encode(['success' => 1, 'order' => $this->orderForPage($order_id)]);
        }
    }


    public function update(Request $request, $id)
    {
        $order = Order::find($id);

        $old_status = $order->status;
        $new_status = $request->status;
        $type_of_operation = 'unchanged';
        if($old_status == 'cancelled' && $new_status != 'cancelled') {
            $type_of_operation = 'decrement';
        }
        if($old_status != 'cancelled' && $new_status == 'cancelled') {
            $type_of_operation = 'increment';
        }

        $input = $request->all();
        $order->update($input);
        $order->orderAffectQuantities($type_of_operation);

        return redirect('admin/orders')->with('message', __("Operation successfully completed"));
    }


    public function transferPayment($order_id, Request $request) {
        $order = Order::findOrFail($order_id);
        $order->paidSuccessfully();
        return json_encode(['success' => 1, 'order' => $this->orderForPage($order_id)]);
//        return back()->with('message', __("Operation successfully completed"));
    }


    public function returnOrder($order_id, Request $request) {
        $order = Order::findOrFail($order_id);
        if($order->pay_method == 'card' && $order->status == 'paid') {
            $sum_to_return = $request->sum;
            $pay_id = $order->pay_id;
            $response = CloudPaymentAPI::refundPayment($pay_id, min($sum_to_return, $order->pay_summ));
            Log::error("::: CLOUD REFUND :::");
            Log::error((array)$response);
            if(!$response->Success) {
                return json_encode(['success' => 0]);
            }
            $sum_to_return = $sum_to_return - $order->pay_summ;
            if($order->pay_id_add && $order->pay_summ_add && $sum_to_return > 0) {
                $response2 = CloudPaymentAPI::refundPayment($order->pay_id_add, min($sum_to_return, $order->pay_summ_add));
                if(!$response2->Success) {
                    return json_encode(['success' => 0]);
                }
            }
            $order->orderCancelled();
            return json_encode(['success' => 1, 'order' => $this->orderForPage($order_id)]);
        }
        $order->orderCancelled();
        return json_encode(['success' => 1, 'order' => $this->orderForPage($order_id)]);
//        return back()->with('message', __("Operation successfully completed"));
    }


    public function deliverOrder($order_id, Request $request) {
        $order = Order::findOrFail($order_id);
        $order->update(['status' => 'delivered']);
        return json_encode(['success' => 1, 'order' => $this->orderForPage($order_id)]);
    }

    public function report($id) {
        $c = Order::findOrFail($id);
        $certificate = new PDFOrder($c);
        return $certificate->stream();
    }


    public function routelist($driver_id, $day) {
        $driver = Driver::findOrFail($driver_id);
        if(date('Y-m-d', strtotime($day)) != $day) {
            return 'Неверен формат даты';
        }
        $certificate = new PDFRoutesList($driver, $day);
        return $certificate->stream();
    }


    public function changeOrderItems($order_id, Request $request) {
        $order = Order::findOrFail($order_id);
        $items = $request->items;
        $ids = [];
        foreach($items as $item) {
            $ids[] = $item['id'];
            OrderItem::where('id',$item['id'])->where('order_id',$order->id)->update([
                'quantity' => $item['quantity'],
                'price' => $item['price'],
            ]);
        }
        OrderItem::where('order_id',$order->id)->whereNotIn('id',$ids)->delete();
        $order->recountDelivery();
        return json_encode(['success' => 1, 'order' => $this->orderForPage($order_id)]);
    }


    public function changeDriver($order_id, Request $request) {
        $order = Order::findOrFail($order_id);
        $order->update([
            'driver_id' => $request->driver_id,
            'internal_comments' => $request->internal_comments,
        ]);
        return json_encode(['success' => 1, 'order' => $this->orderForPage($order_id)]);
    }

}
