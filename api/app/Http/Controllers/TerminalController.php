<?php

namespace App\Http\Controllers;

use Exception;
use App\Models\Axis;
use App\Models\BusStop;
use App\Trait\Distance;
use App\Models\Terminal;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class TerminalController extends Controller
{

    use Distance;

    public function terminals() : JsonResponse {
        try {
            $terminals = Terminal::latest()->get();
            return response()->json([
                "status" => true,
                "message" => "terminal fetched",
                "data" => $terminals,
            ]);
        } catch (Exception $e) {
            return response()->json([
                "status" => false,
                "message" => "Oops, there was an error",
            ]);
        }
    }

    public function axis(Request $request) : JsonResponse{
        $perPage = $request->get('per_page', 10);
        $page = $request->get('page', 1);
        if(!is_numeric($perPage)){
            $perPage = 10;
        }
        if(!is_numeric($page)){
            $page = 1;
        }
        if($request->latitude == null || $request->longitude == null){
            $axis = Axis::orderBy('sequence', 'asc')->select('point_a', 'point_b')->distinct()->with(['terminalA', 'terminalB'])->distinct()->paginate($perPage, ['*'], 'page', $page);
            return response()->json(
                [
                    "status" => true,
                    "message" => "Fetch Axis without my location",
                    "data" => $axis->items(),
                    "pagination" => [
                        "per_page" => $axis->perPage(),
                        "current_page" => $axis->currentPage(),
                    ],
                ]
            );
        }else{
            $latitude = $request->latitude;
            $longitude = $request->longitude;
            $busstopsQuery = BusStop::selectRaw("
                id,
                name,
                latitude,
                longitude,
                (6371 * acos(cos(radians($latitude)) * cos(radians(latitude)) * cos(radians(longitude) - radians($longitude)) + sin(radians($latitude)) * sin(radians(latitude)))) AS distance
            ")
            ->orderBy('distance');
            $busstops = $busstopsQuery->paginate($perPage*10, ['*'], 'page', $page);
            $sortedBusStops = collect($busstops->items())->map(function ($value) use ($request) {
            $axisData = Axis::where(['bus_stop_id' => $value->id])
                    ->select('point_a', 'point_b')
                    ->with(['terminalA', 'terminalB'])
                    ->distinct()
                    ->get();
            $isPointBClosest = $this->isPointClosest($request, $axisData);

                return $axisData->map(function ($axis) use ($isPointBClosest) {
                    $tempTerminalA = $axis->terminalA;
                    $axis->terminalA = $isPointBClosest ? $axis->terminalB : $axis->terminalA;
                    $axis->terminalB = $isPointBClosest ? $tempTerminalA : $axis->terminalB;
                    return $axis;
                })->map(function ($axis) {
                    return [
                        "point_a" => $axis->point_a,
                        "point_b" => $axis->point_b,
                        "terminal_a" => $axis->terminalA,
                        "terminal_b" => $axis->terminalB,
                    ];
                });;
            });

            return response()->json([
                "status" => true,
                "message" => "fetch Axis with my location",
                "data" => $sortedBusStops->flatten(1)->unique()->values()->all(),
                "pagination" => [
                    "per_page" => $perPage,
                    "current_page" => $page,
                ],
            ]);
        }
    }


    public function busStops(Request $request) : JsonResponse {
        $axis = Axis::where(["point_a" => $request->pointa, "point_b" => $request->pointb])->orWhere(["point_b" => $request->pointa, "point_a" => $request->pointb])->with(['busStop'])->get();
        return response()->json([
            "status" => true,
            "message" => "Bus stop fetched",
            "data" => $axis,
        ]);
    }
}
