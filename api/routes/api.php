<?php

use App\Http\Controllers\AccountController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CarController;
use App\Http\Controllers\DocumentController;
use App\Http\Controllers\DriverController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\TerminalController;
use App\Http\Controllers\TransactionController;
use App\Http\Controllers\TripController;
use App\Http\Controllers\WalletController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['middleware' => 'auth:api'], function () {
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

    Route::group(["prefix" => "account"], function() {
        Route::post("/upload-image", [AccountController::class, "uploadImage"]);
        Route::put("/update-profile", [AccountController::class,"updateProfile"]);
        Route::get("/switch/{role}", [AccountController::class, "switchRole"]);
        Route::get("/delete", [AccountController::class, "deleteAccount"]);
        Route::post("/update-settings", [AccountController::class, "updateSettings"]);
        Route::get("/get-settings", [AccountController::class, "getSettings"]); //  under consideration
    });

    Route::group(["prefix" => "terminal"], function(){
        Route::get("/", [TerminalController::class, "terminals"]);
        Route::post("/axis", [TerminalController::class, "axis"]);
        Route::post("/bus-stops", [TerminalController::class, "busStops"]);
    });

    Route::group(["prefix" => "driver"], function() {
        Route::get("/", [DriverController::class, "driver"]);
        Route::post("/update-position", [DriverController::class, "updatePosition"]);
        Route::get("/go-online", [DriverController::class, "goOnline"]);
        Route::group(["prefix" => "document"], function(){
            Route::get("/" , [DocumentController::class, "document"]);
            Route::post("/upload", [DocumentController::class, "upload"]);
            Route::get("/complete", [DocumentController::class, "complete"]);
        });
    });

    Route::group(["prefix" => "trips"], function() {
        Route::post("/available-rides", [TripController::class, "availableRides"]);
        Route::post("/confirm-ride", [TripController::class, "confirmRide"]);
        Route::get("/recent", [TripController::class, "recent"]);
        Route::get("/requests", [TripController::class, "requests"]);
        Route::post("/cancel", [TripController::class, "cancel"]);
        Route::get("/update-pickup", [TripController::class, "updatePickup"]);
        Route::get("/update-completed", [TripController::class, "updateCompleted"]);
        Route::get("/history", [TripController::class, "history"]);
    });

    Route::group(["prefix" => "wallet"], function(){
        Route::get("", [WalletController::class, "wallet"]);
        Route::post("/update-payment-method", [WalletController::class, "updatePaymentMethod"]);
        Route::get("/verify-payment/{reference}", [WalletController::class, "verifyPayment"]);
    });

    Route::group(["prefix" => "transactions"], function() {
        Route::get("", [TransactionController::class, "transactions"]);
    });

    Route::group(["prefix" => "notification"], function(){
        Route::get("/", [NotificationController::class, "notifications"]);
        Route::get("/read/{id}", [NotificationController::class, "read"]);
        Route::get("read-all", [NotificationController::class, "readAll"]);
    });

    Route::group(["prefix" => "car"], function() {
        Route::get("{id}", [CarController::class, "car"]);
        Route::get("cars", [CarController::class, "cars"]);
        Route::post("create", [CarController::class, "create"]);
        Route::delete("delete/{id}", [CarController::class, "delete"]);
        Route::get("set-default/{id}", [CarController::class, "setDefault"]);

    });
});
