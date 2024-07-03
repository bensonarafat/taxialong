<?php

namespace App\Http\Controllers;

use Exception;
use App\Models\Car;
use App\Models\Seat;
use App\Models\Driver;
use Illuminate\Http\Request;

class CarController extends Controller
{
    public function create(Request $request){
        try {

            $seat = Seat::find($request->seatId);
            $car = Car::create([
                "seatId" => $seat->id,
                "color" => $request->color,
                "plate_number" => $request->plateNumber,
                "model" => $request->model,
                "user_id" => auth()->user()->id,
                "seats" => $seat->meta,
                "classes" => json_encode($request->classes),
                "total" => $seat->total,
                "driver_id" => Driver::where("user_id", auth()->user()->id)->first()->id, // driver id
            ]);
            $count = Car::where("user_id", auth()->user()->id)->count();
            if($count == 1) Car::whereId($car->id)->update(["default" => 1]);
            return response()->json([
                "status" => true,
                "message" => "Cars Created",
                "data" => $car
            ]);
        } catch (Exception $e) {
            return response()->json([
                "status" => false,
                "message" => "Oops, there was an error"
            ]);
        }
    }

    public function update(Request $request, int $id){
        try {
            $seat = Seat::find($request->seatId);
            Car::whereId($id)->update([
                "seatId" => $seat->id,
                "color" => $request->color,
                "plate_number" => $request->plateNumber,
                "model" => $request->model,
                "user_id" => auth()->user()->id,
                "seats" => $seat->meta,
                "classes" => json_encode($request->classes),
                "total" => $seat->total,
            ]);
            return response()->json([
                "status" => true,
                "message" => "Car updated",
            ]);
        } catch (Exception $e) {
            return response()->json([
                "status" => false,
                "message" => "Oops, there was an error"
            ]);
        }
    }

    public function cars(){
        try {
            $cars = Car::where(["user_id" => auth()->user()->id, "status" => 1])->orderBy('default', "DESC")->get();
            return response()->json([
                "status" => true,
                "message" => "Cars Fetched",
                "cars" => $cars
            ]);
        } catch (Exception $e) {
            return response()->json(
                [
                    "status"=> false,
                    "message"  => "Oops, there was an error"
                ]
            );
        }

    }

    public function delete($id){
        $car = Car::whereId($id)->first();
        $car->status = 0;
        $car->save();

        if($car->default == 1){
            $thiscar = Car::where(["user_id" => auth()->user()->id, "status" => 1])->whereNotIn("id", [$car->id])->first();
            if($thiscar != null) {
                $thiscar->default = 1;
                $thiscar->save();
            }
        }

        return response()->json([
            "status" => true,
            "message" => "Cars Deleted",
        ]);
    }


    public function car($id){
        $car = Car::find($id);
        return response()->json([
            "status" => true,
            "message" => "Car Fetched",
            "data" => $car
        ]);
    }

    public function setDefault($id){
        Car::whereId($id)->update(["default" => 1]);
        Car::whereNotIn("id", [$id])->update(['default'=> 0]);
        return response()->json([
            "status" => true,
            "message" => "Cars Updated",
        ]);
    }
}
