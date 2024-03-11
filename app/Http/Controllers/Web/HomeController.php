<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Mail\TestMail;
use App\Models\API\LermontovAPI;
use App\Models\General\Subscription;
use App\Models\PDF\PDFTicket;
use App\Models\Specific\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Mail;

class HomeController extends Controller {

    public function langFile() {
        $lang = config('app.locale');
        $strings = Cache::remember('lang.js',3600, function () use($lang) {
            $lang = config('app.locale');
            return file_get_contents(resource_path('lang/' . $lang . '.json'));
        });
        header('Content-Type: text/javascript');
        echo('window.lang = "' . $lang . '";');
        echo('window.i18n = ' . $strings . ';');
        exit();
    }


    public function test() {
//        dd("test");
//        Mail::send(new TestMail());
    }

    public function pdfTicket($order_id, $hash) {
//        if(Auth::guest()) {
//            abort(404);
//        }
        $user = Auth::user();
        $query = Order::where('id',$order_id)
            ->where('hash',$hash);
//        if($user->role == 'organizator') {
//            $query->whereIn('timetable_id',$user->timetableIds());
//        }
//        if($user->role == 'user') {
//            $query->where('user_id',Auth::id());
//        }
        $order = $query->first();
        if(!$order) {
            abort(404);
        }
        $cheque = new PDFTicket($order);
        return $cheque->stream();


    }


    public function updateCity(Request $request) {
        $id = $request->id;
        session(['city' => $id]);
    }


    public function subscribe(Request  $request) {
        $request->validate([
            'email' => ['email','unique:subscriptions']
        ]);
        Subscription::create([
            'email'     => $request->email,
            'ip'        => $request->ip(),
            'user_id'   => Auth::id()
        ]);
        return response()->json('Спасибо, вы подписаны');
    }




}
