<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Web\HomeController;
use App\Http\Controllers\Web\EventController;
use App\Http\Controllers\Web\ContentController;
use App\Http\Controllers\Web\ProfileController;
use App\Http\Controllers\Web\CloudPayController;
use App\Http\Controllers\Admin\AdminController;
use App\Http\Controllers\Admin\EloquentController;
use App\Http\Controllers\Admin\TranslationController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\TimetableController;
use App\Http\Controllers\Admin\VenueController;
use App\Http\Controllers\Admin\TicketsController;
use App\Http\Controllers\Admin\PricegroupsController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Auth::routes();

///*****  ADMIN  *****///

Route::group(['middleware' => ['admin'], 'prefix' => 'admin', 'namespace' => 'Admin'], function () {

    Route::get('/eloquent/{model}', [EloquentController::class, 'eloquentIndex']);
    Route::get('/eloquent/{model}/autocomplete/{field?}', [EloquentController::class, 'eloquentAutocomplete']);
    Route::get('/eloquent/{model}/{id}/get', [EloquentController::class, 'eloquentGet']);
    Route::get('/eloquent/{model}/create', [EloquentController::class, 'eloquentAdd']);
    Route::get('/eloquent/{model}/config', [EloquentController::class, 'eloquentConfig']);
    Route::post('/eloquent/{model}', [EloquentController::class, 'eloquentStore']);
    Route::get('/eloquent/{model}/{id}/edit', [EloquentController::class, 'eloquentEdit']);
    Route::post('/eloquent/{model}/{id}/clone', [EloquentController::class, 'eloquentClone']);
    Route::put('/eloquent/{model}/{id}/', [EloquentController::class, 'eloquentUpdate']);
    Route::delete('/eloquent/{model}/{id}', [EloquentController::class, 'eloquentDestroy']);
    Route::delete('/eloquent/{model}/bulk/delete', [EloquentController::class, 'eloquentDestroyBulk']);
    Route::delete('/media/delete', [EloquentController::class, 'mediaDelete']);
    Route::patch('/eloquent/{model}/{id}/media/move', [EloquentController::class, 'mediaMove']);
    Route::get('/eloquent/json_configs/get', [EloquentController::class, 'eloquentGetConfigs']);
    Route::post('/eloquent/json_configs/new', [EloquentController::class, 'eloquentNewConfig']);
    Route::get('/eloquent/json_configs/get/{file}', [EloquentController::class, 'eloquentGetConfigFile']);
    Route::post('/eloquent/json_configs/save/{file}', [EloquentController::class, 'eloquentStoreConfig']);
    Route::post('/eloquent/json_configs/delete/{file}', [EloquentController::class, 'eloquentDeleteConfig']);
    Route::post('/eloquent/json_configs/class', [EloquentController::class, 'createClass']);

    Route::post('/cache/clear', [AdminController::class, 'clearCache']);
    Route::get('/instructions', [AdminController::class, 'getInstruction']);
    Route::get('/permissions', [AdminController::class, 'getPermissions']);
    Route::get('/mypermissions', [AdminController::class, 'getMyPermissions']);
    Route::post('/sitemap', [AdminController::class, 'sitemap']);
    Route::get('/tags', [AdminController::class, 'getTags']);
    Route::get('/env', [AdminController::class, 'env']);
    //        Route::post('/env', [AdminController::class,'saveEnv');
    Route::get('/file/{attr}/{filename}', [AdminController::class, 'getFile']);


    Route::get('/language/{lang}', [TranslationController::class, 'getLangJSON']);
    Route::post('/translation', [TranslationController::class, 'saveTranslation']);
    Route::post('/translation/languages/refresh', [TranslationController::class, 'manuallyAddKeysFromEnToOtherLangs']);

    Route::get('/dashboard/details', [DashboardController::class, 'getDetails']);
    Route::get('/dashboard/update', [DashboardController::class, 'updateData']);

    Route::get('/timetable/{id}', [TimetableController::class, 'get']);

    Route::get('/schemes', [VenueController::class, 'allSchemes']);
    Route::get('/scheme/{id}', [VenueController::class, 'getScheme']);
    Route::post('/scheme/{id}', [VenueController::class, 'save']);
    Route::delete('/scheme/{id}', [VenueController::class, 'deleteSector']);
    Route::get('/section/{id}', [VenueController::class, 'getSeats']);
    Route::post('/section/{id}', [VenueController::class, 'saveSeats']);
    Route::post('/section/{id}/deleteSeats', [VenueController::class, 'deleteSeats']);

    Route::get('/timetable/{timetable_id}/group/{group_id}', [TicketsController::class, 'getTickets']);
    Route::post('/timetable/{timetable_id}/group/{group_id}/tickets', [TicketsController::class, 'saveTickets']);
    Route::post('/timetable/{timetable_id}/group/{group_id}/tickets/delete', [TicketsController::class, 'deleteTickets']);

    Route::get('/timetable/{timetable_id}/pricegroups', [PricegroupsController::class, 'get']);
    Route::post('/timetable/{timetable_id}/pricegroups', [PricegroupsController::class, 'save']);
    Route::delete('/timetable/{timetable_id}/pricegroups/{id}', [PricegroupsController::class, 'delete']);

    Route::get('/order/{id}/ticket/send', [TicketsController::class, 'sendTickets']);
    Route::get('/order/{id}/ticket/withoutpay/send', [TicketsController::class, 'sendTicketsWithoutPay']);
    Route::get('/order/{id}/details', [TicketsController::class, 'orderDetails']);
    Route::get('/report/sales/excel', [DashboardController::class, 'salesExcel']);
    //        Route::get('/page/pages/get','PagesController@getPages');
//        Route::post('/page/pages/save','PagesController@savePage');
//        Route::delete('/page/pages/delete','PagesController@deletePage');
//        Route::post('/page/pages/increment','PagesController@incrementPage');

    Route::get('/{any?}', [AdminController::class, 'index'])->where('any', '.*');
    //    Route::post('/',[AdminController::class, 'adminImage']);
});


///*****  COMMON  *****///

Route::get('/js/lang.js', [HomeController::class, 'langFile'])->name('assets.lang');


///*****  USER PART  *****///

Route::group(['middleware' => ['web', 'basicauth'], 'namespace' => 'Web'], function () {
    //Route::group(['middleware' => ['web'], 'namespace' => 'Web'], function () {
    //    Route::redirect('login', '/');
    Route::get('/', [EventController::class, 'afisha'])->name('afisha');
    Route::get('/afisha/dynamic', [EventController::class, 'afishaDynamic']);
    Route::get('/widget', [EventController::class, 'widget'])->name('widget');
    Route::get('/widget_without_pay', [EventController::class, 'widget_without_pay'])->name('widget_without_pay');
    Route::get('/event/{slug}', [EventController::class, 'event'])->name('event');

    Route::get('/theatres', [ContentController::class, 'venues'])->name('venues');
    Route::get('/theatres/{slug}', [ContentController::class, 'venueItem'])->name('venueitem');
    Route::get('/cast/{slug}', [ContentController::class, 'cast'])->name('cast');

    Route::get('/news', [ContentController::class, 'news'])->name('news');
    Route::get('/news/{slug}', [ContentController::class, 'newsItem'])->name('newsitem');

    Route::get('/partners', [ContentController::class, 'partners'])->name('partners');
    Route::get('/feedbacks', [ContentController::class, 'feedbacks'])->name('feedbacks');
    Route::get('/search', [EventController::class, 'search'])->name('search');

    Route::get('/test', [HomeController::class, 'test'])->name('test');
    Route::get('/order/{order_id}/{hash}/pdf', [HomeController::class, 'pdfticket'])
        ->middleware('auth')
        ->name('pdfticket');

    Route::post('/city/update', [HomeController::class, 'updateCity']);
    Route::post('/subscribe', [HomeController::class, 'subscribe']);

    Route::post('/cloud/pay/{action?}', [CloudPayController::class, 'index']);

    Route::get('/profile', [ProfileController::class, 'profile'])->name('profile')->middleware('auth');
    Route::post('/profile', [ProfileController::class, 'profileSave'])->name('profilePost')->middleware('auth');
    Route::get('/profile/tickets', [ProfileController::class, 'tickets'])->name('tickets')->middleware('auth');

    Route::get('/{slug}', [ContentController::class, 'page'])->name('page');
});
