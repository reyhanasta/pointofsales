<?php

namespace App\Http\Controllers;

use App\Services\StuffService;
use App\Services\TransactionService;
use App\Services\UserService;

use Illuminate\View\View;

class HomeController extends Controller
{

	public function index(StuffService $stuff, TransactionService $transaction, UserService $user): View
	{
		$totalStuff = $stuff->countData();
		$totalTransaction = $transaction->countData();
		$totalUser = $user->countData();
		$transactionToday = $transaction->countToday();

		return view('home', compact('totalStuff', 'totalTransaction', 'transactionToday', 'totalUser'));
	}

}
