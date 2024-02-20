<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\ReportRequest;
use App\Models\General\User;
use App\Models\Reports\SalesListReport;
use App\Models\Reports\Timeline;
use App\Models\Specific\Order;
use App\Models\Specific\OrderItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Box\Spout\Common\Type;

class DashboardController extends Controller
{
    public function getDetails(Request $request) {
        return $this->getData($request->timeframe);
    }


    public function getData($timeframe) {
        Cache::forget('admin_dashboard_day');
        return Cache::remember('admin_dashboard_'.$timeframe,300, function() use($timeframe) {
            $from = date('Y-m-d').' 00:00:00';
            $data = [];
            if($timeframe == 'all') {
                $data_users = User::count();
//                $data_orders = Order::count();
//                $data_news = News::count();
            } else {
                $data_users = User::where('created_at','>=',$from)->count();
//                $data_orders = Order::where('created_at','>=',$from)->count();
//                $data_news = News::where('created_at','>=',$from)->count();
            }
//            $data['orders'] = ['data' => $data_orders, 'url' => '/admin/#order', 'badge' => 'finished'];
            $key = 'DATE_FORMAT(created_at,"%Y-%m-%d")';
            $sales = Order::paid()
                ->groupBy(DB::raw($key))
                ->selectRaw('SUM(price) as value, '.$key.' as date')
                ->get();
//            dd($sales);
            $data['chart'] = Timeline::prepareCollectionForChart($sales);
            $data['users'] = [
                'data' => $data_users,
                'url' => '/admin/#user',
                'badge' => 'waiting_payment'
            ];
//            $data['products'] = ['data' => $data_products, 'url' => '/admin/#product', 'badge' => 'authorized'];
//            $data['news'] = ['data' => $data_news, 'url' => '/admin/#news', 'badge' => 'success'];
            return response()->json($data);
        });
    }


    public function updateData(Request $request) {
        $timeframe = $request->timeframe;
        Cache::forget('admin_dashboard_'.$timeframe);
        return $this->getData($timeframe);
    }


    public function salesExcel(ReportRequest $request) {
        $data = $request->only('event_ids','timetable_ids','date_from','date_to');
        Log::error($data);
        $report = new SalesListReport($data);
        $report->generate();
        if (!$report->data || count($report->data) < 1) {
            return redirect('/admin#/report')->withErrors('Продаж не было');
//            return 'Продаж не было';
        }
        $report->toExcel();
    }




}
