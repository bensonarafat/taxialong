<?php

namespace App\Http\Controllers;

use Exception;
use App\Models\Document;
use Illuminate\Http\Request;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;

class DocumentController extends Controller
{
    public function upload(Request $request){
        try {
            $exists = Document::where(["type" => $request->type, "user_id" => $request->user()->id])->exists();
            if($exists){
                // delete
                $document =  Document::where(["type" => $request->type, "user_id" => $request->user()->id])->first();
                //destory
                Cloudinary::destroy($document->publicId);
                Document::where(["type" => $request->type, "user_id" => $request->user()->id])->delete();
            }
            $filename = strtolower($request->user()->firstname) .'_'. $request->type . '_' . time(). rand(1000,9999);
            $result = $request->file->storeOnCloudinaryAs('documents', $filename);
            //update user avatar
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
}
