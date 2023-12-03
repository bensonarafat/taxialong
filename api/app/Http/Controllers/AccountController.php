<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
use Exception;

class AccountController extends Controller
{
    public function updateProfile(Request $request){
        $firstname = ucfirst(strtolower(trim($request->firstname)));
        $lastname = ucfirst(strtolower(trim($request->lastname)));
        $email = trim(strtolower($request->email));
        $telephone = trim($request->telephone);
        $data = [
            "lastname" => $lastname,
            "firstname" => $firstname,
        ];

        if($email != request()->user()->email){
            $data['email'] = $email;
        }

        $exists = User::where("email", $email)
                ->where('id', '!=', request()->user()->id)
                ->exists();
        if($exists){
            return response()->json([
                'status'=> false,
                'response' => 'found',
                'message'=> "Email already",
                ]);
        }

        if($telephone != request()->user()->telephone){
            $data['telephone'] = $telephone;
        }

        $exists = User::where("telephone", $telephone)
            ->where('id', '!=', request()->user()->id)
            ->exists();
        if($exists){
            return response()->json([
                'status'=> false,
                'response' => 'found',
                'message'=> "Telephone already been used",
            ]);
        }

        User::whereId(request()->user()->id)->update($data);

        return response()->json([
           "status"=>true,
           "response"=> "OK",
           "message" => "Profile Updated",
        ]);
    }

    public function uploadImage(Request $request){
        try {
            $filename = strtolower($request->user()->firstname) . '_' . time(). rand(1000,9999);
            $result = $request->file->storeOnCloudinaryAs('avatar', $filename);
            //destory
            if($request->user()->avatar_publicId){
                Cloudinary::destroy($request->user()->avatar_publicId);
            }
            //update user avatar
            User::whereId($request->user()->id)->update([
                "avatar" => $result->getPath(),
                "avatar_publicId" => $result->getPublicId(),
            ]);
            return response()->json(["status" => true, "message" => "Profile Updated"]);
        } catch (Exception $e) {
            return response()->json(["status" => false, "message" => "Oops, there was an error"]);
        }

    }

    public function switchRole($role){
        //update user role to driver
        User::whereId(auth()->user()->id)->update([
            "role" => $role,
        ]);
        return response()->json([
            "status" => true,
            "message" => "Account Switched"
        ]);
    }
}
