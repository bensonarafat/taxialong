<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\OTP;
use App\Models\User;
use Webpatser\Uuid\Uuid;
use App\Trait\RideSettings;
use Illuminate\Http\Request;
use App\Trait\TaxiAlongWallet;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;

class AuthController extends Controller
{

    use TaxiAlongWallet, RideSettings;

    public function oAuth(Request $request){
        $exists = User::where("email", $request->email)->exists();
        if($exists){
            $user = User::where('email', $request->email)->first();
            if (! $token = auth()->attempt(["email" => $user->email, "password" => $user->telephone])) {
                return response()->json([
                    'status'=> false,
                    'response' => 'Unauthorized',
                    'message'=> "Email is unauthorized",
                ]);
            }
            return $this->respondWithToken($token);
        }else{
            return response()->json([
                "status" => false,
                "response" => "Notfound",
                "message" => "Account do not exists please register email first",
            ]);
        }
    }


    public function otpLogin(Request $request){
        if($request->handler == 'new' ) return $this->otpRegister($request);
        $exists =  OTP::where(['otp' => $request->otp, "uuid" => $request->uuid])->exists();
        if($exists){
            return $this->loginUser($request->telephone);
        }else{
            return response()->json([
                "status" => false,
                "response" => "NotFound",
                "message" => "OTP not found"
            ]);
        }
    }

    public function otpRegister(Request $request){
        if($request->handler == 'old' ) return $this->otpLogin($request);
        $exists =  OTP::where(['otp' => $request->otp, "uuid" => $request->uuid])->exists();
        if($exists){
            return response()->json([
                "status" => true,
                "response" => "OTP",
                "message" => "OTP verified",
                "data" => $request->all(),
            ]);
        }else{
            return response()->json([
                "status" => false,
                "response" => "NotFound",
                "message" => "OTP not found"
            ]);
        }
    }


    private function loginUser($telephone){
        $user = User::where("telephone", $telephone)->first();
        if (!$token = auth()->attempt(["email" => $user->email, "password" => $user->telephone])) {
            return response()->json([
                'status'=> false,
                'response' => 'Unauthorized',
                'message'=> "User is unauthorized",
            ]);
        }
        $this->createSettings();
        $this->createWallet();
        return $this->respondWithToken($token);
    }

    public function createAccount(Request $request){
        if(OTP::where("uuid", $request->uuid)->exists()){
            if(empty($request->firstname)){
                return $this->responseNocontent("First name is required");
            }else if(empty($request->lastname)){
                return $this->responseNocontent("Last name is required");
            }else if(empty($request->email)){
                return $this->responseNocontent("Email address is required");
            }else if(empty($request->telephone)){
                return $this->responseNocontent("Oops, there was an error");
            }else{
                //check if email already exist
                $exists = User::where("email", $request->email)->exists();
                if($exists){
                    return response()->json([
                        "status" => false,
                        "response" => "Found",
                        "message" => "Email already exists"
                    ]);
                }else{
                    User::create([
                        "firstname" => $request->firstname,
                        "lastname" => $request->lastname,
                        "email" => $request->email,
                        "telephone"=> $request->telephone,
                        "password" => Hash::make($request->telephone),
                    ]);
                    $res = $this->loginUser($request->telephone);
                    return $res;
                }
            }
        }else{
            return response()->json([
                "status" => false,
                "response" => "Unauthorized",
                "message" => "Oops, there was an error"
            ]);
        }
    }

    public function telephone(Request $request){
        $exists = User::where('telephone', $request->telephone)->exists(); // check if exist, so the user wont create an account again
        return $this->sendToken($request->telephone, $exists);
    }

    public function me()
    {
        $user = User::whereId(auth()->user()->id)->with(["settings", "driver"])->withCount(["documents"])->first();
        $user->settings->ride_class = json_decode($user->settings->ride_class);
        return response()->json($user);
    }


    public function logout()
    {
        auth()->logout();

        return response()->json(
            [
                'status' => true,
                "response" => "OK",
                'message' => 'Successfully logged out'
            ]);
    }


    public function refresh()
    {
        return $this->respondWithToken(auth()->refresh());
    }


    protected function respondWithToken($token)
    {
        return response()->json([
            'status' => true,
            'response' => 'OK',
            'access_token' => $token,
            'token_type' => 'bearer',
            'message'=> "Login",
            'expires_in' => auth()->factory()->getTTL() * 60
        ]);
    }

    public function responseNocontent($message){
        return response()->json([
            "status" => false,
            "response" => 'NoContent',
            'messag'=> $message,
        ]);
    }

    private function sendToken($telephone, $exists){
        //delete otp for user phone number
        OTP::where("telephone", $telephone)->delete();
        $pin = 1234; //mt_rand(1111, 9999);

        // $response = Http::post('https://api.ng.termii.com/api/sms/otp/send', [
        //     "api_key" => "TLZIkb6uWLscKCseoQYrVhciWejur54gpqtF5FuAM8F8zzF1ey5lY8kssnwceR",
        //     "message_type" => "NUMERIC",
        //     "to" => $telephone,
        //     "from" => 'N-Alert',
        //     "channel" => "dnd",
        //     "pin_time_to_live" => 15,
        //     "pin_length" => 4,
        //     "pin_placeholder" => "< $pin >",
        //     "message_text" => "TaxiAlong confirmation code is < $pin >. Valid for 15 minutes, one-tome use only.",
        //     "pin_type" => "NUMERIC"
        // ]);

        // if(!$response->successful()) return response()->json(["status" => false, "response" => "NoContent", "mesage" => "Error, sending OTP"]);
        // $data = $response->json();
        // if($data["smsStatus"] != 'Message Sent') return response()->json(["status" => false, "response" => "NoContent", "mesage" => "Error, sending OTP"]);

        $opt = OTP::create([
            'otp' => $pin,
            'telephone' => $telephone,
            'uuid' => Uuid::generate()->string,
            'expires' =>  Carbon::now()->addMinutes(15), //  15 minties
            'pin_id' => $pin
        ]);
        return response()->json([
            "status" => true,
            "response" => "Accepted",
            "message" => "OTP sent",
            "handler" => $exists ? "old" : "new", // exists
            "data" => $opt,
        ]);
    }
}
