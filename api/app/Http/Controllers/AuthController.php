<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\OTP;
use App\Models\User;
use Webpatser\Uuid\Uuid;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    /**
     * Create a new AuthController instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'register', 'opt', 'createAccount']]);
    }


    public function register(Request $request){
        $exists = User::where('telephone', $request->telephone)->exists();
        // account already exist
        if($exists){
            return response()->json([
                "status" => false,
                "response" => "found",
                "message" => "Account already exists",
            ] );
        }else{
            // OTP SMS API
            $opt = OTP::create([
                'otp' => mt_rand(1111, 9999),
                'telephone' => $request->telephone,
                'uuid' => Uuid::generate()->string,
                'expires' =>  Carbon::now()->addMinutes(30), // Add 5 minties
            ]);

            return response()->json([
                "status" => true,
                "response" => "Accepted",
                "message" => "OTP sent",
                "data" => $opt,
            ]);
        }
    }

    public function opt(Request $request){
        $exists =  OTP::where(['otp' => $request->otp, "uuid" => $request->uuid])->exists();
        if($exists){
            return response()->json([
                "status" => true,
                "response" => "OK",
                "message" => "UUID not found",
                "data" => $request->all(),
            ]);
        }else{
            return response()->json([
                "status" => false,
                "response" => "NotFound",
                "message" => "UUID not found"
            ]);
        }
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
                    if (!$token = auth()->attempt(["email" => $request->email, "password" => $request->telephone])) {
                        return response()->json([
                            'status'=> false,
                            'response' => 'Unauthorized',
                            'message'=> "Email is unauthorized",
                        ]);
                    }
                    return $this->respondWithToken($token);
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

    /**
     * Get a JWT via given credentials.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function login(Request $request)
    {

        $exists = User::where('telephone', $request->telephone)->exists();
        if($exists){
            $user = User::where('telephone', $request->telephone)->first();
            if (! $token = auth()->attempt(["email" => $user->email, "password" => $request->telephone])) {
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
                "response" => "NotFound",
                "message" => "Phone number not register!"
            ] );
        }

    }

    /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function me()
    {
        return response()->json(auth()->user());
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
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

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken(auth()->refresh());
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token)
    {
        return response()->json([
            'status' => true,
            'response' => 'OK',
            'access_token' => $token,
            'token_type' => 'bearer',
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
}
