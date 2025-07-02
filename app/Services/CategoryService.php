<?php 

namespace App\Services;

use App\Repositories\CategoryRepository;

use Yajra\Datatables\Datatables;

class CategoryService extends Service {

    public function __construct(CategoryRepository $category)
    {
        $this->repo = $category;
    }

    public function getDatatables(): Object
    {
        $datatables = Datatables::of($this->getData())
                        ->addIndexColumn()
                        ->addColumn('action', function ()
                        {
                            $editBtn = '<button class="btn btn-success btn-sm" data-action="edit"><i class="fa fa-edit"></i></button>';
                            $delBtn = '<button class="btn btn-danger btn-sm" data-action="remove"><i class="fa fa-trash"></i></button>';

                            if (auth()->user()->can('isAdmin')) {
                                return $editBtn.' '.$delBtn;
                            }

                            return $editBtn;
                        })
                        ->make();

        return $datatables;
    }

}

 ?>