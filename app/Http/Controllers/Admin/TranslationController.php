<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;

class TranslationController extends Controller
{

    public function getLangJSON($language = 'ru') {
        return file_get_contents(resource_path('/lang/'.$language.'.json'));
    }


    public function saveTranslation(Request $request) {
        $lang = $request->lang;
        $string = $request->filecontent;
        $json = json_decode($string,true);
//        Log::error($json);
//        dd($json);
        if(json_last_error() != JSON_ERROR_NONE) {
            return back()->withErrors("Wrong content format");
        }
        ksort($json,SORT_STRING | SORT_FLAG_CASE);
        $string = json_encode($json,JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
        file_put_contents(resource_path('lang/'.$lang.'.json'),$string);
        Cache::forget('lang.js');
        return back()->with('message',__("Saved"));
    }


    public static function addKeysFromEnToOtherLangs() {
//        $en_voc = json_decode(file_get_contents(resource_path('/lang/en.json')),true);
//        $langs = ['fr','pt','nl'];
//        foreach($langs as $l) {
//            $voc = json_decode(file_get_contents(resource_path('/lang/'.$l.'.json')),true);
//            $added_voc = array_merge($en_voc,$voc);
//            ksort($added_voc,SORT_STRING | SORT_FLAG_CASE);
//            $string = json_encode($added_voc,JSON_PRETTY_PRINT);
//            file_put_contents(resource_path('/lang/'.$l.'.json'),$string);
//        }
        $ru_voc = json_decode(file_get_contents(resource_path('/lang/ru.json')),true);
        $langs = ['en','kz'];
        foreach($langs as $l) {
            $voc = json_decode(file_get_contents(resource_path('/lang/'.$l.'.json')),true);
            $added_voc = array_merge($ru_voc,$voc);
            ksort($added_voc,SORT_STRING | SORT_FLAG_CASE);
            $string = json_encode($added_voc,JSON_PRETTY_PRINT);
            file_put_contents(resource_path('/lang/'.$l.'.json'),$string);
        }
        Cache::forget('lang.js');
    }

    public function manuallyAddKeysFromEnToOtherLangs() {
        self::addKeysFromEnToOtherLangs();
//        return back()->with('message',__("Success"));
    }


}
