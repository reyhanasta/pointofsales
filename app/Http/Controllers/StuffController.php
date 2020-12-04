<?php

namespace App\Http\Controllers;

use App\Services\StuffService;
use App\Http\Requests\Stuff\CreateStuffRequest;
use App\Http\Requests\Stuff\UpdateStuffRequest;

use Illuminate\View\View;
use Illuminate\Http\Request;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\JsonResponse;

class StuffController extends Controller
{

    protected $stuff;

    public function __construct(StuffService $stuff)
    {
        $this->stuff = $stuff;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(): View
    {
        return view('stuff.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(): View
    {
        return view('stuff.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(CreateStuffRequest $request): RedirectResponse
    {
        $this->stuff->storeData($request->all());

        return redirect('stuff')->with('success', 'Sukses Menambahkan Data');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(int $id): View
    {
        $stuff = $this->stuff->getOne($id);

        return view('stuff.show', compact('stuff'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateStuffRequest $request, int $id): JsonResponse
    {
        $this->stuff->updateData($id, $request->all());

        return response()->json(['success' => 'Sukses Mengedit Data']);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(int $id): JsonResponse
    {
        $this->stuff->deleteData($id);

        return response()->json(['success' => 'Sukses Menghapus Data']);
    }

    // Get Datatables
    public function datatables(): Object
    {
        return $this->stuff->getDatatables();
    }

    // Select Data
    public function select(Request $request): Object
    {
        return $this->stuff->selectData($request->name);
    }

    // Select Data By Code
    public function selectCode(Request $request): Object
    {
        return $this->stuff->selectByCode($request->code);
    }
}
