<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Support\Facades\Session;

class BasicAuth
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
        if($request->expectsJson()) {
            return $next($request);
        }
        $AUTH_USER = 'stages';
        $AUTH_PASS = 'qwerty123!';
        header('Cache-Control: no-cache, must-revalidate, max-age=0');
        $has_supplied_credentials = !(empty($_SERVER['PHP_AUTH_USER']) && empty($_SERVER['PHP_AUTH_PW']));
        $is_not_authenticated = (
            !$has_supplied_credentials ||
            $_SERVER['PHP_AUTH_USER'] != $AUTH_USER ||
            $_SERVER['PHP_AUTH_PW']   != $AUTH_PASS
        );
        if ($is_not_authenticated) {
            header('HTTP/1.1 401 Authorization Required');
            header('WWW-Authenticate: Basic realm="Access denied"');
            exit;
        }
        return $next($request);
    }
}
