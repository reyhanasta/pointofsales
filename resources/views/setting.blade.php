@extends('_layouts.app')

@section('title', 'Pengaturan Aplikasi')

@section('content')
	
	<div class="row">
		<div class="col-sm-5 mx-auto">

			@if (session('success'))
				<div class="alert alert-success alert-dismissible">
					{{ session('success') }}
					<button class="close" data-dismiss="alert">&times;</button>
				</div>
			@endif
			
			<div class="card">
			<form action="{{ route('setting.update') }}" method="post">
				@method('PUT')
				@csrf
				<div class="card-header">
					<h2 class="h6 mb-0 font-weight-bold card-title">Pengaturan Aplikasi</h2>
				</div>
				<div class="card-body">
					<div class="form-group">
						<label>Nama</label>
						<input type="text" class="form-control @error('name') is-invalid @enderror" name="name" placeholder="Nama" value="{{ site('name') }}" autofocus>

						@error('name')
							<span class="invalid-feedback">{{ $message }}</span>
						@enderror
					</div>
					<div class="form-group">
						<label>Alamat</label>
						<textarea rows="3" class="form-control @error('address') is-invalid @enderror" name="address" placeholder="Alamat">{{ site('address') }}</textarea>

						@error('address')
							<span class="invalid-feedback">{{ $message }}</span>
						@enderror
					</div>
				</div>
				<div class="card-footer">
					<button class="btn btn-primary" type="submit">Simpan</button>
				</div>
			</div>
		</div>
	</div>

@endsection