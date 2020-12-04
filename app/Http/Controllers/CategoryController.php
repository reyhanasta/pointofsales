<?php

namespace App\Http\Controllers;

use App\Services\CategoryService;
use App\Http\Requests\Category\CreateCategoryRequest;
use App\Http\Requests\Category\UpdateCategoryRequest;

use Illuminate\View\View;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class CategoryController extends Controller
{

    protected $category;

    public function __construct(CategoryService $category)
    {
        $this->category = $category;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(): View
    {
        return view('category.index');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(CreateCategoryRequest $request): JsonResponse
    {
        $this->category->storeData($request->all());

        return response()->json(['success' => 'Sukses Menambahkan Data']);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateCategoryRequest $request, int $id): JsonResponse
    {
        $this->category->updateData($id, $request->all());

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
        $this->category->deleteData($id);

        return response()->json(['success' => 'Sukses Menghapus Data']);
    }

    // Get Datatables
    public function datatables(): Object
    {
        return $this->category->getDatatables();
    }

    // Select Data
    public function select(Request $request): Object
    {
        return $this->category->selectData($request->name);
    }
}
