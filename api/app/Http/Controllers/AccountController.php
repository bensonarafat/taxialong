<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class AccountController extends Controller
{
    public function updateProfile(Request $request, $field){
        if($field == "firstname"){
            $firstname = ucfirst(strtolower(trim($request->firstname)));
            $data = ['firstname' => $firstname];
        }else if($field == "lastname"){
            $lastname = ucfirst(strtolower(trim($request->lastname)));
            $data = ['lastname' => $lastname];
        }else if($field == "email"){
            $email = trim(strtolower($request->email));
            if($email == request()->user()->email){
                $data = ['email' => $email ];
            }else{
                $exists = User::where("email", $email)
                                ->where('id', '!=', request()->user()->id)
                                ->exists();
                if($exists){
                    return response()->json([
                        'status'=> false,
                        'response' => 'found',
                        'message'=> "Email already",
                    ]);
                }else{
                    $data = ['email' => $email];
                }
            }

        }else if($field == "telephone"){
            $telephone = trim($request->telephone);
            if($telephone == request()->user()->telephone){
                $data = ['telephone' => $telephone];
            }else{
                $exists = User::where("telephone", $telephone)
                                ->where('id', '!=', request()->user()->id)
                                ->exists();
                if($exists){
                    return response()->json([
                        'status'=> false,
                        'response' => 'found',
                        'message'=> "Telephone already been used",
                    ]);
                }else{
                    $data = ['telephone' => $telephone];
                }
            }
        }

        User::where("id", request()->user()->id)->update($data);

        return response()->json([
           "status"=>true,
           "response"=> "OK",
           "message" => "Updated",
        ]);
    }
}
