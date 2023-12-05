<?php

use App\Http\Controllers\AccountController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DocumentController;
use App\Http\Controllers\DriverController;
use App\Http\Controllers\TerminalController;
use App\Http\Controllers\TripController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['middleware' => 'auth:api'], function () {
    //auth
    Route::group(["prefix" => "auth"], function() {
        Route::post("telephone", [AuthController::class, "telephone"])->withoutMiddleware("auth:api");
        Route::post('otp-login', [AuthController::class, "otpLogin"])->withoutMiddleware("auth:api");
        Route::post('otp-register', [AuthController::class, "otpRegister"])->withoutMiddleware("auth:api");
        Route::post("o-auth", [AuthController::class, "oAuth"])->withoutMiddleware("auth:api");
        Route::post('create-account', [AuthController::class, "createAccount"])->withoutMiddleware("auth:api");
        Route::get('logout', [AuthController::class, "logout"]);
        Route::get('refresh', [AuthController::class, "refresh"]);
        Route::get('me', [AuthController::class, "me"]);
    });

    //account
    Route::group(["prefix" => "account"], function() {
        Route::post("/upload-image", [AccountController::class, "uploadImage"]);
        Route::put("/update-profile", [AccountController::class,"updateProfile"]);
        Route::get("/switch/{role}", [AccountController::class, "switchRole"]);
        Route::get("/delete", [AccountController::class, "deleteAccount"]);
    });

    //terminals
    Route::group(["prefix" => "terminal"], function(){
        Route::post("/axis", [TerminalController::class, "axis"]);
        Route::post("/bus-stops", [TerminalController::class, "busStops"]);
    });

    // driver
    Route::group(["prefix" => "driver"], function() {
        //driver
        Route::get("/", [DriverController::class, "driver"]);
        Route::post("/ride-settings", [DriverController::class, "rideSettings"]);
        Route::get("/get-settings", [DriverController::class, "getSettings"]);
        Route::post("/update-position", [DriverController::class, "updatePosition"]);
        Route::get("/go-online", [DriverController::class, "goOnline"]);
        // documents
        Route::group(["prefix" => "document"], function(){
            Route::get("/" , [DocumentController::class, "document"]);
            Route::post("/upload", [DocumentController::class, "upload"]);
            Route::get("/complete", [DocumentController::class, "complete"]);
        });
    });

    // trips
    Route::group(["prefix" => "trips"], function() {
        Route::post("/recent", [TripController::class, "recent"]);
        Route::post("/ongoing", [TripController::class, "ongoing"]);
    });
});
