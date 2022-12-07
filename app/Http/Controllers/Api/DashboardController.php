<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Payment;
use Illuminate\Http\Request;
use App\Product;
use App\Referer;
use App\Transaction;
use App\User;
use App\Wallet;

class DashboardController extends Controller
{
    public function index()
    {
        $user = auth('api')->user();
        if(!$user){
            return response()->json([
                'status'    => 'error',
                'message'   => 'please Log In'
            ], 401);
        }

        try {
            $payments_received = Transaction::where('user_id', $user->id)->sum('amount');
            $payments_made = Payment::where('user_id', $user->id)->sum('balance_after');
            $referer = Referer::where('user_id', $user->id)->sum('amount');
            $balance = Wallet::where('user_id', $user->id)->get('balance');
            $bonus = Wallet::where('user_id', $user->id)->get('bonus');

            return response()->json([
                'status' => 'success',
                'message' => 'success',
                'data'    => [
                    'payments_received' => $payments_received,
                    'payments_made' => $payments_made,
                    'balance' => $bonus,
                    'bonus'   => $bonus,
                    'refer'   => $referer
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'status'    => 'error',
                'message'   => $e
            ], 400);
        }
    }
}
