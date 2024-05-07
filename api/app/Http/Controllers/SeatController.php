<?php

namespace App\Http\Controllers;

use App\Models\Seat;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class SeatController extends Controller
{
    public function seats() : JsonResponse
    {
        $seats = Seat::latest()->get();
        foreach ($seats as $row) {
            $row->seats = json_decode($row->seats);
        }
        return response()->json($seats);
    }

    public function seat($id) : JsonResponse
    {
        $seat = Seat::find($id);
        $seat['seats'] = json_decode($seat);
        return response()->json($seat);
    }

    public function create(Request $request) : JsonResponse {
        try {
            $meta = [];
            foreach ($request->seats as $row) {
                $new_sub_array = $row;
                $new_sub_array['status'] = "available";
                $meta[] = $new_sub_array;
            }
            Seat::create([
                "total" => $request->total,
                "name"=> $request->name,
                "seats" => json_encode($request->seats),
                "meta" => json_encode($meta),
            ]);
            return response()->json([
                "status" => true,
                "message" => "Created",
            ]);
        } catch (Exception $e) {
            return response()->json([
                "status" => false,
                "message" => "oops, there was an error"
            ]);
        }
    }

    public function update(Request $request, $id) : JsonResponse {
        try {
            Seat::whereId($id)->update([
                "total" => $request->total,
                "name"=> $request->name,
                "seats" => json_encode($request->seats)
            ]);
            return response()->json([
                "status" => true,
                "message" => "Updated",
            ]);
        } catch (Exception $e) {
            return response()->json([
                "status" => false,
                "message" => "oops, there was an error"
            ]);
        }
    }
}
