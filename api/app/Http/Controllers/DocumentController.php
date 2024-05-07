<?php

namespace App\Http\Controllers;

use Exception;
use App\Models\User;
use App\Trait\Driver;
use App\Models\Document;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;

class DocumentController extends Controller
{

    use Driver;

    public function document(){
        $documents = Document::where("user_id", auth()->user()->id)->latest()->get();
        return response()->json([
            "status" => true,
            "message" => "Documents Fetched",
            "data" => $documents
        ]);
    }

    public function upload(Request $request){
        try {
            $exists = Document::where(["type" => $request->type, "user_id" => $request->user()->id])->exists();
            if($exists){
                $document =  Document::where(["type" => $request->type, "user_id" => $request->user()->id])->first();
                Cloudinary::destroy($document->publicId);
                Document::where(["type" => $request->type, "user_id" => $request->user()->id])->delete();
            }
            $filename = strtolower($request->user()->firstname) .'_'. $request->type . '_' . time(). rand(1000,9999);
            $result = $request->file->storeOnCloudinaryAs('documents', $filename);
            $document = Document::create([
                "user_id"=> $request->user()->id,
                "file" => $result->getPath(),
                "publicId" => $result->getPublicId(),
                "type" => $request->type,
            ]);

            return response()->json(["status" => true, "message" => "Document Uploaded", "data" => $document ]);
        } catch (Exception $e) {
            return response()->json(["status" => false, "message" => "Oops, there was an error"]);
        }
    }

    public function complete(){
        $count = Document::where("user_id", auth()->user()->id)->count();
        if($count == 3){
            User::whereId(auth()->user()->id)->update([
                "role" => "driver",
            ]);
            $this->DriverTrip();
            return response()->json([
                "status" => true,
                "message" => "All documents recieved"
            ]);
        }else{
            return response()->json([
                "status" => false,
                "message" => "Oops, there was an error!"
            ]);
        }
    }
}
