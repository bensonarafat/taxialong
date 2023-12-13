<?php

namespace App\Http\Controllers;

use Exception;
use App\Models\User;
use App\Http\Trait\Driver;
use App\Models\RideSettings;
use Illuminate\Http\Request;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;

class AccountController extends Controller
{

    use Driver;

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
            if($request->user()->avatar_publicId){
                Cloudinary::destroy($request->user()->avatar_publicId);
            }
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
        User::whereId(auth()->user()->id)->update([
            "role" => $role,
        ]);
        if($role == "driver"){
            $this->DriverTrip();
        }
        return response()->json([
            "status" => true,
            "message" => "Account Switched"
        ]);
    }

    public function deleteAccount(){
        $user = User::find(auth()->user()->id);
        if(!$user){
            return response()->json(
                [
                    "status" => false,
                    "message" => "User not found"
                ]
            );
        }

        $user->delete();
        return response()->json([
            "status" => true,
            "message" => "User Account deleted"
        ]);
    }

        // ride settings
        public function updateSettings(Request $request){
            //update
            try {
                RideSettings::where(["user_id" =>  $request->user()->id])->update([
                    "pointa" => $request->pointa,
                    "pointb" => $request->pointb,
                    "payment_method" => $request->payment_method,
                    "ride_class" => $request->ride_class,
                ]);
                return response()->json(["status" => true,  "message" => "Setting updated"]);
            } catch (Exception $e) {
                return response()->json([
                    "status" => false,
                    "message" => "Oops, there was an error"
                ]);
            }

        }

        public function getSettings(){
            $settings = RideSettings::where("user_id", auth()->user()->id)->first();
            $settings->ride_class = json_decode($settings->ride_class);
            return response()->json(
                [
                    "status" => true,
                    "message" => "Settings fetched",
                    "data" => $settings,
                ]
            );
        }


}
