<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Support\Facades\Session;

class Admin
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
        if (Auth::check()) {
            $user = Auth::user();
            if ($user->can('admin_panel'))
                return $next($request);
            else
                return redirect('/')->withErrors('У вас не достаточно прав для просмотра запрашиваемой
                страницы.');
        }
        return redirect('/login')->withErrors('Вам необходимо авторизоваться.');
    }
}
