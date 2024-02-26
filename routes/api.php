<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\APIEventController;
use App\Http\Controllers\API\APIOrderController;
use App\Http\Controllers\API\APISettingsController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group(['middleware' => [], 'namespace' => 'API'], function () {
    Route::get('/events', [APIEventController::class, 'getEvents']);
    Route::get('/events/filters', [APIEventController::class, 'getFilters']);
    Route::get('/event/{id}', [APIEventController::class, 'getEvent']);
    Route::get('/timetable/{id}', [APIEventController::class, 'getTimetable']);
    Route::get('/timetable/{timetable_id}/section/{id}', [APIEventController::class, 'getSection']);
    Route::post('/order/init', [APIOrderController::class, 'initOrder']);
    Route::post('/order/{id}/{hash}/fill', [APIOrderController::class, 'fillOrder']);
    Route::get('/order/{id}/{hash}', [APIOrderController::class, 'getOrder']);
    Route::delete('/order/{id}/{hash}', [APIOrderController::class, 'cancelOrder']);
    Route::get('/settings', [APISettingsController::class, 'getSettings']);
    //check ticket
    Route::post('/order/{code}/ticket', [APIOrderController::class, 'getAboutTicket']);
    Route::post('/order/{code}/check', [APIOrderController::class, 'ticketChecked']);
});
