<?php

namespace App\Models\General;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class EloquentHandler {

    public static function getModelConfig($model) {
        $data = json_decode(file_get_contents(config_path('admin/'.$model.'.json')),true);
        return $data;
    }

    public static function getModelFields($model) {
        $config = self::getModelConfig($model);
        return  $config["fields"];
    }


    public static function getModelValidationRules($model,$type = 'store') {
        $fields = self::getModelFields($model);
        $rules = [];
        foreach($fields as $id => $field) {
            if(isset($field['type']) && $field['type'] == 'file') {
                $id = $id.'.*';
            }
            if($type == 'update' && isset($field["validation_update"])) {
                $rules[$id] = $field["validation_update"];
            } else {
                if(isset($field["validation"])) {
                    $rules[$id] = $field["validation"];
                }
            }
        }
        return $rules;
    }

    //Некорректно работает
    public static function checkPermissions($model_config, $operation, $object = NULL) {
        if(isset($model_config["permissions"]) && isset($model_config["permissions"][$operation])) {
            foreach($model_config["permissions"][$operation] as $perm) {
                if(Auth::guest() || Auth::user()->can($perm,$object)) {
                    abort(403, 'Access denied');
                }
            }
        }
    }


    public static function addSelectOptions($model_config) {
        $fields = $model_config['fields'];
        $select_models = [];
        foreach($fields as $id => $field) {
            if($field['type'] == 'select') {
                if($field['select_data']['type'] == 'model' && (!isset($field["autocomplete"]) || !$field["autocomplete"])) {
                    $class_name = $field["select_data"]["model"];
                    $data = $class_name::all();
                    $select_models[$id] = $data;
                }
            }
        }
        return $select_models;
    }


    public static function getMediaTeasers($config, $obj) {
//        if(in_array('Spatie\\MediaLibrary\\HasMedia\\HasMediaTrait',class_uses(get_class($obj)))) {
        if(in_array('App\\Traits\\AnimatedMedia',class_uses(get_class($obj)))) {
            $collections = ['default'];
            foreach($config['fields'] as $f) {
                if($f['type'] == 'file' && isset($f['subtype']) && $f['subtype'] == 'image' && isset($f['collection'])) {
                    $collections[] = $f['collection'];
                }
            }
            $collections = array_unique($collections);
            $arr = [];
            foreach($collections as $c) {
                $media = $obj->getMedia($c);
                foreach($media as $m) {
                    try {
                        $m->url = $m->getUrl('thumb');
                    } catch(\Exception $e) {
                        $m->url = $m->getUrl();
                    }
                    $arr[] = $m;
                }
            }
            return $arr;
        }
        return [];
    }


    public static function getClassNameFromModel($model) {
        return "App\\Models\\".Str::studly($model);
    }

}