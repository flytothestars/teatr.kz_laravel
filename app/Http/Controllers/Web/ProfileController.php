<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class ProfileController extends Controller {



    public function profile() {
        $user = Auth::user();
        return view('content.profile.profile', compact('user'));
    }

    public function tickets() {
        $user = Auth::user();
        $orders = $user->orders()
            ->with('timetable')
            ->with('timetable.event')
            ->withCount('orderItems')
            ->orderBy('id','desc')
            ->paginate(10);
        return view('content.profile.tickets', compact('user','orders'));
    }

    public function profileSave(Request $request) {
        $user = Auth::user();
        $request->validate([
            'name'  => ['required','string','max:100'],
            'phone' => ['required','string','max:30'],
        ]);
        if($request->password) {
            $request->validate([
                'password'  => ['string', 'min:8', 'confirmed'],
            ]);
        }
        if($user->email != $request->email) {
            $request->validate([
                'email' => 'email|unique:users'
            ]);
        }
        $user->update($request->only('name','phone','email'));
        if($request->password) {
            $user->password = Hash::make($request->password);
            $user->save();
        }
        return response()->json('Данные изменены успешно');
    }

}
