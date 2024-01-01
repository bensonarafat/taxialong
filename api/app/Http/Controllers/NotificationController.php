<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;

class NotificationController extends Controller
{
    public function notifications(): JsonResponse
    {

        $notifications = Notification::latest()->get();
        return response()->json(
            [
                "status" => true,
                "message" => "Notification fetched",
                "data" => $notifications,
            ]
        );
    }

    public function read(int $id) : JsonResponse
    {
        Notification::where(["id" => $id, "user_id" => auth()->user()->id])->update([
            "read_at" => Carbon::now(),
        ]);
        return response()->json(["status" => true, "message" => "Notification Read", ]);
    }

    public function readAll() : JsonResponse
    {
        Notification::where(["user_id" => auth()->user()->id])->whereNull('read_at')->update([
            "read_at" => Carbon::now()
        ]);
        return response()->json(["status" => true, "message"  => "All Notification Read"]);
    }
}
