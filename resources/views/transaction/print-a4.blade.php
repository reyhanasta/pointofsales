<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <title>Invoice {{ $transaction->idPenjualan }}</title>
    <style>
        /* Reset dasar & pengaturan font yang aman untuk PDF */
        body {
            font-family: 'Helvetica', Arial, sans-serif;
            font-size: 12px;
            color: #333;
            line-height: 1.4;
        }

        /* Container utama seukuran A4 */
        .invoice-container {
            width: 100%;
            margin: 0;
            padding: 0;
        }

        /* Tata letak utama menggunakan tabel agar anti-berantakan */
        .main-layout {
            width: 100%;
            border-collapse: collapse;
        }

        /* Header section */
        .shop-name {
            font-size: 24px;
            font-weight: bold;
        }

        .shop-details {
            font-size: 11px;
        }

        .invoice-details-table {
            width: 100%;
            margin-top: 15px;
            border: 1px solid #333;
            padding: 10px;
        }

        .invoice-details-table td {
            vertical-align: top;
        }

        /* Tabel Item */
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }

        .items-table th,
        .items-table td {
            border: 1px solid #333;
            padding: 8px;
            text-align: center;
        }

        .items-table thead th {
            background-color: #f2f2f2;
            font-weight: bold;
            text-transform: uppercase;
        }

        .items-table .col-barang {
            text-align: left;
            width: 45%;
        }

        .items-table .col-harga,
        .items-table .col-jumlah {
            text-align: right;
        }

        /* Footer Section */
        .footer-space {
            height: 150px;
            /* Memberi ruang kosong sebelum footer */
        }

        .footer-layout {
            width: 100%;
        }

        .footer-layout .signatures,
        .footer-layout .totals {
            vertical-align: bottom;
        }

        .signatures-table,
        .totals-table {
            width: 100%;
        }

        .signatures-table td {
            text-align: center;
            padding-top: 60px;
        }

        .totals-table td {
            padding: 6px 10px;
        }

        .totals-table .label {
            font-weight: bold;
        }

        .totals-table .value {
            border: 1px solid #333;
            text-align: right;
            width: 60%;
        }

        /* Helper classes */
        .text-right {
            text-align: right;
        }

        .text-center {
            text-align: center;
        }

        .font-bold {
            font-weight: bold;
        }
    </style>
</head>

<body>
    <div class="invoice-container">
        <table class="main-layout">

            <tr>
                {{-- <td style="width: 55%; vertical-align: top;">
                    <div class="shop-name">{{ site('nama_toko') }}</div>
                    <div class="shop-details">{{ site('alamat_toko') }}</div>
                    <div class="shop-details">Telp. {{ site('telepon_toko') }}</div>
                </td> --}}
                <td style="width: 55%; vertical-align: top;">
                    {{-- Menampilkan logo jika ada --}}
                    @if (site('pakaiLogo'))
                    <img src="{{ storage_path('app/public/logo/' . site('logo')) }}" alt=""
                        style="width: 60px; max-width: 50%; margin-bottom: 15px;">
                    @endif

                    <div class="shop-name">{{ site('nama_toko') }}</div>
                    <div class="shop-details">{{ site('alamat_toko') }}</div>
                    <div class="shop-details">Telp. {{ site('telepon_toko') }}</div>
                </td>
                <td style="width: 45%; vertical-align: top;">
                    <h2 style="text-align: right; margin: 0;">INVOICE</h2>
                    <table class="invoice-details-table">
                        <tr>
                            <td><strong>No. Invoice:</strong></td>
                            <td>{{ $transaction->idPenjualan }}</td>
                        </tr>
                        <tr>
                            <td><strong>Tanggal:</strong></td>
                            <td>
                                @php date_default_timezone_set('Asia/Jakarta'); @endphp
                                {{ date('d F Y', strtotime($transaction->tanggal)) }}
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Pembeli:</strong></td>
                            <td>_________________</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table class="items-table">
            <thead>
                <tr>
                    <th style="width: 8%;">Qty</th>
                    <th class="col-barang">Barang</th>
                    <th style="width: 20%;">Harga Satuan</th>
                    <th class="col-jumlah" style="width: 22%;">Jumlah</th>
                </tr>
            </thead>
            <tbody>
                @php $total = 0; @endphp
                @foreach($transaction->detail as $item)
                @php
                $subtotal = $item->jumlah * $item->hargaJual - $item->disc;
                $total += $subtotal;
                @endphp
                <tr>
                    <td class="text-center">{{ $item->jumlah }}</td>
                    <td class="col-barang">{{ $item->judul }}</td>
                    <td class="col-harga">{{ number_format($item->hargaJual) }}</td>
                    <td class="col-jumlah">{{ number_format($subtotal) }}</td>
                </tr>
                @endforeach
                {{-- Baris kosong untuk mengisi sisa halaman --}}
                @for ($i = count($transaction->detail); $i < 12; $i++) <tr>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    </tr>
                    @endfor
            </tbody>
        </table>

        <div class="footer-space"></div>
        <table class="footer-layout">
            <tr>
                <td class="signatures" style="width: 60%;">
                    <table class="signatures-table">
                        <tr>
                            <td>( Penerima )
                                <br><br><br><br>
                            </td>
                            <td>
                                ( Hormat Kami )
                                <br><br><br>
                                <strong>{{ $transaction->namaUser ?? 'Petugas' }}</strong>

                            </td>
                        </tr>
                    </table>
                </td>
                <td class="totals" style="width: 40%;">
                    <table class="totals-table">
                        <tr>
                            <td class="label">Total</td>
                            <td class="value">{{ number_format($total) }}</td>
                        </tr>
                        <tr>
                            <td class="label">PPN</td>
                            <td class="value">{{ number_format($transaction->ppn) }}</td>
                        </tr>
                        <tr>
                            <td class="label">GRAND TOTAL</td>
                            <td class="value font-bold">{{ number_format($total + $transaction->ppn) }}</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</body>

</html>