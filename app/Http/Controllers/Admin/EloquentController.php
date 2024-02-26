<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\General\Spacemedia;
use Illuminate\Http\Request;
use App\Models\General\EloquentHandler;
use File;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class EloquentController extends Controller
{

    public function index()
    {
        return view('home');
    }


    public function eloquentIndex($model, Request $request) {
        $model_config = EloquentHandler::getModelConfig($model);
        if(!$this->checkIfModelExists($model, $model_config['path'])) {
            abort(404);
        }
        $class_name = $model_config["path"];
        if($request->all_for_select) {
            return json_encode($class_name::pluck($request->title_for_select ? $request->title_for_select : 'title','id'));
        }
        $select_data = [];
        foreach($model_config['fields'] as $id => $f) { // collecting dropdowns on table for filtering
            if(isset($f['table_filter_select']) && $f['table_filter_select']) {
                $c_name = $f['select_data']['model'];
                $select_data[$id] = $c_name::pluck(is_array($f['select_data']['title']) ? $f['select_data']['title'][0] : $f['select_data']['title'],'id')->toArray();
            }
        }
        $sort = isset($request->sort) ? $request->sort : $model_config["initial_order"][0];
        $order = isset($request->order) ? $request->order : $model_config["initial_order"][1];

        $query = $class_name::orderBy($sort,$order);
        if($model  == 'deleted_order') {
            $query->onlyTrashed();
        }

        $search = [];
        if(isset($request->search)) {
            parse_str($request->search,$search);
        }

        foreach($search as $key => $val) {
            if(!$val) { continue; }
            if(isset($model_config["fields"][$key]["skipsearch"])) { continue; }
            if($val === 'false') { $val = 0; }
            if($val === 'true') { $val = 1; }
            if(isset($model_config["fields"][$key]["likesearch"]) && $model_config["fields"][$key]["likesearch"]) {
                $query->whereRaw("LOWER($key) LIKE ?", ['%' . mb_strtolower($val) . '%']);
            } else {
                $query->whereRaw("LOWER($key) = ?", [$val]);
            }
        }

        if(method_exists($class_name,'additionalSearchQuery')) {
            $query = $class_name::additionalSearchQuery($query,$search);
        }

        if(isset($model_config["with"]) && $model_config["with"]) {
            foreach($model_config["with"] as $w) {
                $query->with($w);
            }
        }

        if(method_exists($class_name,'additionalListQuery')) {
            $query = $class_name::additionalListQuery($query);
        }

        $data = $query->paginate(isset($request->paginate) ? $request->paginate : 50);

        $result = [];
        $result['paginator'] = (string)$data->appends(Request::capture()->except('page'))->render("pagination::bootstrap-4");
        $result['list'] = $data;
        $result['select_data'] = $select_data;
        $result['total'] = $data->total();
        return response()->json($result);
    }


    public function eloquentAutocomplete($model, Request $request, $field = 'title') {
        $model_config = EloquentHandler::getModelConfig($model);
        if(!$this->checkIfModelExists($model, $model_config['path'])) {
            abort(404);
        }
        $class_name = $model_config["path"];

        $q = $class_name::selectRaw('id, '.$field.' as text')->orderBy($field,'asc');

        if($request->ids) {
            return json_encode($q->whereIn('id',$request->ids)->take(10)->get());
        }
        if($request->id) {
            return json_encode([$q->where('id',$request->id)->first()]);
        }
        if($model == 'timetable') {
            $res = $class_name::selectRaw('timetables.id, CONCAT('.$field.', " - ", JSON_UNQUOTE(JSON_EXTRACT(events.title,"$.ru"))) as text')
                ->orderBy($field,'asc')
                ->join('events','timetables.event_id','=','events.id')
                ->whereHas('event', function($qry) use($request) {
                    $qry->whereRaw('JSON_UNQUOTE(JSON_EXTRACT(title,"$.ru")) LIKE ?', ['%' . mb_strtolower($request->search) . '%']);
                })
                ->orWhere('timetables.id','LIKE', $request->search.'%')
                ->take(10)
                ->get();
        } else {
            $res = $q->where($field,'LIKE', '%' . $request->search . '%')->take(10)->get();
        }
        return json_encode($res);
    }



    public function eloquentAdd($model) {
        $model_config = EloquentHandler::getModelConfig($model);
        $class_name = $model_config["path"];
        $obj = new $class_name();
        $select_models = EloquentHandler::addSelectOptions($model_config);
        $this->clearCaches($model_config);
        return json_encode(['object' => $obj, 'select_models' => $select_models,'media' => []]);
    }



    public function clearCaches($model_config) {
        if(isset($model_config["clearcache"])) {
            foreach($model_config["clearcache"] as $cache) {
                Cache::forget($cache);
            }
        }
    }



    public function eloquentStore($model, Request $request) {
        $request->validate(EloquentHandler::getModelValidationRules($model,'store'));
        $model_config = EloquentHandler::getModelConfig($model);
        $class_name = $model_config["path"];
        EloquentHandler::checkPermissions($model_config,"create");
        if(method_exists($class_name,'customCreate')) {
            $obj = $class_name::customCreate($request);
            if($class_name == 'App\Models\General\User'){
                $obj->assignRole($request->roles);
            }
        } else {
            $obj = $class_name::create($request->all());
            if($class_name == 'App\Models\General\User'){
                $obj->assignRole($request->roles);
            }
        }
        $this->eloquentCheckImages($obj, $request);
        $this->clearCaches($model_config);
        $obj = $this->loadEloquentRelations($class_name, $model_config, $obj->id);
        return json_encode($obj);
    }



    public function eloquentEdit($model, $id) {
        $model_config = EloquentHandler::getModelConfig($model);
        $class_name = $model_config["path"];
        $obj = $this->loadEloquentRelations($class_name, $model_config, $id);
        $media = EloquentHandler::getMediaTeasers($model_config,$obj);
        $select_models = EloquentHandler::addSelectOptions($model_config);
        return json_encode(['object' => $obj, 'select_models' => $select_models, 'media' => $media]);
    }



    public function eloquentUpdate($model, $id, Request $request) {
        if(!$request->_source || $request->_source != 'useradminpage') {
            $request->validate(EloquentHandler::getModelValidationRules($model,'update'));
        }
        $model_config = EloquentHandler::getModelConfig($model);
        $class_name = $model_config["path"];
        $obj = $class_name::findOrFail($id);

        EloquentHandler::checkPermissions($model_config,"update",$obj);
        if(method_exists($obj,'customUpdate')) {
            $obj->customUpdate($request);
            if($class_name == 'App\Models\General\User'){
                $obj->syncRoles($request->roles);
            }
        } else {
            $obj->update($request->all());
            if($class_name == 'App\Models\General\User'){
                $obj->syncRoles($request->roles);
            }        
        }
        $this->eloquentCheckImages($obj, $request);
        $this->clearCaches($model_config);
        $obj = $this->loadEloquentRelations($class_name, $model_config, $id);
        return json_encode($obj);
    }


    public function eloquentClone($model, $id, Request $request) {
        $model_config = EloquentHandler::getModelConfig($model);
        $class_name = $model_config["path"];
        $obj = $class_name::findOrFail($id);
        if(method_exists($obj,'customReplicate')) {
            $new_obj = $obj->customReplicate($obj);
        } else {
            $new_obj = $obj->replicate();
            $new_obj->push();
        }
        $new_obj = $this->loadEloquentRelations($class_name, $model_config, $new_obj->id);
        return json_encode($new_obj);
    }




    public function loadEloquentRelations($class_name, $model_config, $id) {
        $obj = $class_name::findOrFail($id);
        if(isset($model_config["with"]) && $model_config["with"]) {
            foreach($model_config["with"] as $w) {
                $obj->{$w} = $obj->{$w};
            }
        }
        return $obj;
    }



    public function eloquentView($model, $id) {
        $model_config = EloquentHandler::getModelConfig($model);
        $class_name = $model_config["path"];
        $obj = $class_name::findOrFail($id);
        return response()->json(view('eloquent.custom.'.$model.'.view',compact('model','model_config','obj','id'))->render());
    }



    public function eloquentDestroy($model, $id, Request $request) {
        $model_config = EloquentHandler::getModelConfig($model);
        $class_name = $model_config["path"];
        $obj = $class_name::findOrFail($id);
        $obj->delete();
        return back()->with('message',__('Operation went successfully'));
    }


    public function eloquentDestroyBulk($model, Request $request) {
        $model_config = EloquentHandler::getModelConfig($model);
        $class_name = $model_config["path"];
        foreach($request->ids as $id) {
            $obj = $class_name::findOrFail($id);
            $obj->delete();
        }
    }

    public function eloquentCheckImages($object, $request) {
        if(in_array('App\\Traits\\AnimatedMedia',class_uses(get_class($object)))) {
            $object->saveImage($request, false);
        }
    }


    public function eloquentConfig($model) {
        $model_config = EloquentHandler::getModelConfig($model);
        return json_encode($model_config);
    }


    public function checkIfModelExists($model, $modelpath = null) {
        $name = Str::studly($model);
        if($modelpath) {
            if(class_exists($modelpath)) {
                return true;
            }
        }
        if(class_exists(('App\\Models\\'.$name))) {
            return true;
        }
        return false;
    }


    public function mediaDelete(Request $request) {
        $media = Spacemedia::find($request->id);
        $media->delete();
    }


    public function mediaMove($model, $id, Request $request) {
        $model_config = EloquentHandler::getModelConfig($model);
        $class_name = $model_config["path"];
        $obj = $this->loadEloquentRelations($class_name, $model_config, $id);
        $media = Spacemedia::find($request->id);
        $object_media = Spacemedia::where('model_type',$media->model_type)
            ->where('model_id',$media->model_id)
            ->orderBy('sort_order','desc')
            ->get();
        $sort = count($object_media);
        $buffer = null;
        foreach($object_media as $i => $m) {
            if($m->id == $media->id && $i != (count($object_media)-1)) {
                $buffer = $m;
                continue;
            }
            $m->sort_order = $sort;
            $m->save();
            $sort--;
            if($buffer) {
                $buffer->sort_order = $sort;
                $buffer->save();
                $buffer = null;
                $sort--;
            }

        }
        $model = $class_name::find($obj->id);
        if($model && $model->store_primary_image) {
            $mediaObject = $obj->getFirstMedia();
            if($mediaObject) {
                Log::error("tryin");
                $model->update([
                    'primary_media_id' => $mediaObject->id,
                    'primary_media_ext' => $mediaObject->getExtensionAttribute()
                ]);
            }
        }

        $media = EloquentHandler::getMediaTeasers($model_config, $obj);
        return json_encode($media);
    }



}
