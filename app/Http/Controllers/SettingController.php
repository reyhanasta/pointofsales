<?php

namespace App\Http\Controllers;

use App\Http\Requests\UpdateSettingRequest;
use App\Services\SiteService;

use Illuminate\Http\Request;

class SettingController extends Controller
{

	public function update(UpdateSettingRequest $request, SiteService $site)
	{
		$site->update($request->all());

		return back()->with('success', 'Sukses Mengedit Pengaturan');
	}
}
