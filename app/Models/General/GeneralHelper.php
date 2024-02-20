<?php

function issetOrNull($var, $attr) {
    return isset($var[$attr]) ? $var[$attr] : null;
}

//use Carbon\Carbon;
//
//function targetBlank($url) {
//    return (strpos($url, 'http') === 0) ? '_blank' : '_self';
//}
//
//function limitLength($string) {
//    $limit = 40;
//    if(mb_strlen($string) > $limit) {
//        return mb_substr($string, 0, ($limit-3)).'...';
//    }
//    return $string;
//}
//
//function presentNum($sum) {
//    return number_format($sum,0,"."," ");
//}
//
//function presentSum($sum) {
//    return presentNum($sum).' &#8376;';
//}
//
//function currency() {
//    return ' &#8376;';
//}
//
function dateFormat($datetime, $time = false, $year = false) {
    $months = ['января','февраля',"марта","апреля","мая","июня","июля","августа","сентября","октября","ноября",
        "декабря"];
    $date_unix = strtotime($datetime);
    $month = $months[(date("m",$date_unix)-1)];
    $date = date("j",$date_unix) .' '. $month;
    if($year) {
        $date .= ' '.date('Y',$date_unix);
    }
    if ($time) {
        $date .= ', '. date("H:i",$date_unix);
    }
    return $date;
}
//
//function fromStringToUTCString($string, $timezone) {
//    return Carbon::createFromFormat('Y-m-d H:i:s', $string, $timezone)
//        ->setTimezone('UTC')
//        ->format('Y-m-d H:i:s');
//}
//
//function zeroOneFromJavascript($value) {
//    $v = 0;
//    if($value && in_array($value, ['true',1])) {
//        $v = 1;
//    }
//    return $v;
//
//}
//
//function generateFileName($file,$extension = null) {
//    $part = time() .'_'.\Illuminate\Support\Str::random(6). '.';
//    if($extension) {
//        return $part.$extension;
//    }
//    return  $part.$file->getClientOriginalExtension();
//}
//
//
//function renderSlots($slot_id, $pages = null, $header = false, $classes = '', $svg = true) {
//    return \App\Models\Slot::renderSlots($slot_id, $pages, $header, $classes, $svg);
//}
//
//
//function convert_filesize($bytes, $decimals = 2) {
//    $size = array('B','KB','MB','GB','TB','PB','EB','ZB','YB');
//    $factor = floor((strlen($bytes) - 1) / 3);
//    return sprintf("%.{$decimals}f", $bytes / pow(1024, $factor)) . ' '.@$size[$factor];
//}
//
//
function getNumbers($str) {
    return preg_replace('/[^0-9.]+/', '', $str);
}

//function getLangUrl($lang = null) {
//    $lang_url = env('LANG_IN_LINK') ? '/'.($lang ? $lang : app()->getLocale()) : '';
//    return $lang_url;
//}
//
//
//function startsWith($haystack, $needle)
//{
//    $length = strlen($needle);
//    return (substr($haystack, 0, $length) === $needle);
//}
//
//function endsWith($haystack, $needle)
//{
//    $length = strlen($needle);
//    if ($length == 0) {
//        return true;
//    }
//
//    return (substr($haystack, -$length) === $needle);
//}
//
//function getExtensionFromUrl($url) {
//    $arr = explode(".", (is_array($url) ? $url[0] : $url));
//    $extension = end($arr);
//    return $extension ? $extension : '-';
//}
//
//
//if (!function_exists('mb_ucfirst')) {
//    function mb_ucfirst($str, $encoding = "UTF-8", $lower_str_end = false) {
//        $first_letter = mb_strtoupper(mb_substr($str, 0, 1, $encoding), $encoding);
//        $str_end = "";
//        if ($lower_str_end) {
//            $str_end = mb_strtolower(mb_substr($str, 1, mb_strlen($str, $encoding), $encoding), $encoding);
//        }
//        else {
//            $str_end = mb_substr($str, 1, mb_strlen($str, $encoding), $encoding);
//        }
//        $str = $first_letter . $str_end;
//        return $str;
//    }
//}
