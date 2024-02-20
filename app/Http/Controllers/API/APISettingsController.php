<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\General\Setting;
use Illuminate\Http\Request;

class APISettingsController extends Controller {


    public function getSettings(Request $request) {
        $user = $request->user('api');
        return response()->json([
            'settings'  => Setting::getSettings(),
            'user'      => $user,
        ]);
    }




}
