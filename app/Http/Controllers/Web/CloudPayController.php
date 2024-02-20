<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Specific\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class CloudPayController extends Controller {

    public function index(Request $request, $action = 'check') {
        Log::error('cloud pay response');
        Log::error($action);
//        Log::error($request->all());
        $id = $request->InvoiceId;
        $hash = $request->Data ? json_decode($request->Data)->hash : '';
        $order = Order::where('id',$id)
            ->where('hash',$hash)
            ->first();
        if(!$order) {
            Log::error('order not found');
            return response()->json(['code' => 10]);
        }
        if($action == 'check' && $order) {
            return response()->json(['code' => 0]);
        }
        $response = Http::withBasicAuth(env('CLOUD_PAY_PUBLIC_AUTH'), env('CLOUD_PAY_API_KEY'))
            ->post('https://api.cloudpayments.ru/v2/payments/find', [
                'InvoiceId' => $id
        ]);
        $response = $response->json();
        Log::error($response);
        $success = $response['Success'];
        if(!$success) {
            return response()->json(['code' => 10]);
        }
        $model = $response['Model'];
        if(in_array($model['Status'], ['Authorized','Completed'])) {
            Log::error('successfully paid');
            $order->successfullyPaid($model['Amount'], true, date('Y-m-d H:i:s'), $model['TransactionId']);
            return response()->json(['code' => 0]);
        }
        Log::error('just finished without success');
        return response()->json(['code' => 10]);
    }

}
