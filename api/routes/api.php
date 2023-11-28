<?php

use App\Http\Controllers\AccountController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\TerminalController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['middleware' => 'api'], function () {
    //auth
    Route::group(["prefix" => "auth"], function() {
        Route::post("telephone", [AuthController::class, "telephone"]);
        Route::post('otp-login', [AuthController::class, "otpLogin"]);
        Route::post('otp-register', [AuthController::class, "otpRegister"]);
        Route::post("o-auth", [AuthController::class, "oAuth"]);
        Route::post('create-account', [AuthController::class, "createAccount"]);
        Route::get('logout', [AuthController::class, "logout"]);
        Route::get('refresh', [AuthController::class, "refresh"]);
        Route::get('me', [AuthController::class, "me"]);
    });

    //account
    Route::group(["prefix" => "account"], function() {
        Route::put("/update-profile/{field}", [AccountController::class,"updateProfile"]);
    });

    //terminals
    Route::group(["prefix" => "terminal"], function(){
        Route::post("/axis", [TerminalController::class, "axis"]);
    });
});
