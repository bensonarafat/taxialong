<?php

namespace App\Http\Controllers;

use App\Models\Car;
use Exception;
use Illuminate\Http\Request;

class CarController extends Controller
{
    public function create(Request $request){
        try {
            $car = Car::create([
                "seats" => $request->seats,
                "color" => $request->color,
                "plate_number" => $request->plateNumber,
                "model" => $request->model,
                "user_id" => auth()->user()->id,
            ]);
            $count = Car::where("user_id", auth()->user()->id)->count();
            if($count == 0) Car::whereId($car->id)->update(["default" => "1"]);
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

    public function cars(){
        $cars = Car::where("user_id", auth()->user()->id)->latest()->get();
        return response()->json([
            "status" => true,
            "message" => "Cars Fetched",
            "data" => $cars
        ]);
    }

    public function delete($id){
        Car::whereId($id)->update(["status" => "0"]);
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
        Car::whereId($id)->update(["default" => "1"]);
        Car::whereNotIn("id", [$id])->update(['default'=> '0']);
        return response()->json([
            "status" => true,
            "message" => "Cars Updated",
        ]);
    }
}
