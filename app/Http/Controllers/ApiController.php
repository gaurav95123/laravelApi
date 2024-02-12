<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Auth;


class ApiController extends Controller
{

    public function getUser()
    {
        $cost = User::get();
        $result = array('status' => true, 'message' => count($cost) . " user fatched", 'data' => $cost);
        return response()->json($result, 200);
    }

    // function to create user 

    public function createUser(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'email' => 'required',
            'phone' => 'required',
            'password' => 'required',

        ]);
        if ($validator->fails()) {
            $result = array('status' => false, 'message' => 'validation error occured', 'error_message' => $validator->errors());
            return response()->json($result, 400); //bad request
        }

        $cost = new User;
        $cost->name = $request->name;
        $cost->email = $request->email;
        $cost->phone = $request->phone;
        $cost->password = \Hash::make($request->password);
        $cost->save();

        if ($cost->id) {
            $result = array('status' => true, 'message' => 'product created', 'data' => $cost);
            $responseCode = 200; //success

        }
        // this is for exception case 
        else {
            $result = array('status' => true, 'message' => "something went wrong");
            $responseCode = 400;
        }
        return response()->json($result, $responseCode);

        //    return response()->json(['status'=>'true', 'message'=>"Hello World",'data'=>$request->all()]);
    }


    public function getUserDetail($id)
    {
        $cost = User::where('id', $id)->first();
        if (!$cost) {
            $result = array('stauts' => false, 'message' => 'user not found');
            return response()->json($result, 404);
        }
        $result = array('status' => true, 'message' => 'user found', 'data' => $cost);
        return response()->json($result, 200);
    }


    // update work
    public function updateUser(Request $request, $id)
    {
        $cost = User::find($id);
        if (!$cost) {
            return response()->josn(['status' => false, 'message' => 'user not found'], 404);
        }

        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'email' => 'required',
            'phone' => 'required',

        ]);

        if ($validator->fails()) {
            $result = array('status' => false, 'message' => 'validation error occured', 'error_message' => $validator->errors());
            return response()->json($result, 400);
        }

        $cost->name = $request->name;
        $cost->email = $request->email;
        $cost->phone = $request->phone;
        $cost->save();
        $result = array('status' => true, 'message' => 'data updated successfully', 'data ' => $cost);
        return response()->json($result, 200);
    }

    public function deleteUser(Request $request, $id)
    {
        $cost = User::find($id);
        $cost->delete();
        return response()->json(['status' => true, 'message' => 'message deleted successfully']);
    }


    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required',
            'password' => 'required'
        ]);
        if ($validator->fails()) {
            $result = array('status' => false, 'message' => 'validation error occured', 'error_message' => $validator->errors());
            return response()->json($result, 400); //bad request
        }
        $credint = $request->only('email', 'password');
        if (Auth::attempt($credint)) {
            $user = Auth::user();

            // creating a token
            $token = $user->createToken('MyApp')->accessToken;

            return response()->json(['status' => true, 'message' => "login successfull", "token" => $token], 200);
        }
        return response()->json(['status' => false, 'message' => "invalid login details"], 401);
    }


    public function unauthenticate()
    {
        return response()->json(['status' => false, "message" => "Only autorised user can access", "error" => "unauthenticate"], 401);
    }


    public function logout()
    {
        $user = Auth::user();

        $user = Auth::user();
        $user->Tokens->each(function ($token, $key) {
            $token->delete();
        });
        return response()->json(['status' => true, 'message' => 'logged out successfully.']);
    }
}
