@extends('_layouts.app')

@section('title', 'Laporan Stok Harian')

@section('content')
    
            
    <div class="card">
        <div class="card-header d-flex align-items-center justify-content-between">
            <h2 class="h6 mb-0 font-weight-bold card-title">Laporan Stok Harian</h2>
            <a href="{{ route('report.stock.print.today') }}" target="_blank" class="btn btn-sm btn-danger">Print</a>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped" width="100%">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Nama Barang</th>
                            <th>Qty</th>
                        </tr>
                    </thead>
                    <tbody>
                        @php
                            $total = 0
                        @endphp
                        @forelse ($reports as $report)
                            <tr>
                                <td>{{ $loop->iteration }}</td>
                                <td>{{ $report->judul }}</td>
                                <td>{{ $report->total }}</td>
                            </tr>

                            @php
                                $total += $report->total
                            @endphp
                        @empty
                            <tr>
                                <td colspan="3" align="center">Kosong</td>
                            </tr>
                        @endforelse
                        @if ($reports)
                            <tr>
                                <th colspan="2" class="text-right">Total Qty</th>
                                <th>{{ $total }}</th>
                            </tr>
                        @endif
                    </tbody>
                </table>
            </div>
        </div>
    </div>

@endsection