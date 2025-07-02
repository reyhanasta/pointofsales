<?php

namespace Database\Seeders;

use App\Models\User;

use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    	User::create([
    		'idUser' => '170301',
                'nama' => 'Admin',
                'alamat' => 'Ciamis',
                'telepon' => '082121397663',
                'username' => 'admin',
                'password' => 'admin', // md5('admin')
                'hakAkses' => '1'
    	]);
    }
}
