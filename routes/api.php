<?php

use App\Http\Controllers\ApiController\API;



use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ApiController;

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

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Route::post('create-user', [ApiController::class, 'createUser']);
// Route::get('get-user', [ApiController::class, 'getUsers']);
Route::post('update-user/{id}', [ApiController::class, 'updateUser']);
Route::delete('delete-user/{id}', [ApiController::class, 'deleteUser']);
Route::post('login', [ApiController::class, 'login']);



// Route::get('unauthenticate', [ApiController::class, 'unauthenticate'])->name('unauthenticate');
Route::get('unauthenticate', [ApiController::class, 'unauthenticate'])->name('unauthenticate');
// secure route within auth middleware;

Route::middleware('auth:api')->group(function () {
    Route::get("get-user", [ApiController::class, "getUser"]);
    Route::get('get-user-detail/{id}', [ApiController::class, 'getUserDetail']);
    Route::post('logout', [ApiController::class, 'logout']);
});
