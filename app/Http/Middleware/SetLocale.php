<?php

namespace App\Http\Middleware;

use App\Models\Specific\City;
use Closure;
use Illuminate\Support\Facades\View;
use App\Models\General\Setting;

class SetLocale
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request $request
     * @param  \Closure $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
//        $lang = $request->segment(1);
//        if(!in_array($lang,['en','kz'])) {
//            $lang = 'ru';
//        }
        $lang = 'ru';
        View::share(['lang' => $lang]);
        View::share(['settings' => Setting::getSettings()]);
        View::share(['city' => City::find(session('city', 1))]);
        app()->setLocale($lang);
        return $next($request);
    }
}
