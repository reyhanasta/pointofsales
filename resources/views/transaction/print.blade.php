<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Struk Transaksi</title>

	<style>
		@page {
			margin: 0;
		}

		body {
			font-family: "Roboto", sans-serif;
			color: #000;
			font-size: 14px;
			width: 80%;
			margin: auto;
			padding: 20px;
		}

		.heading {
			text-align: center;
			margin-bottom: 10px;
		}

		.title {
			font-size: 18px;
			font-weight: bold;
			color: #111;
			margin-bottom: 5px;
		}

		p {
			margin: 2px 0;
		}

		img {
			width: 80px;
			height: auto;
			margin-bottom: 5px;
		}

		hr {
			border: none;
			border-top: 1px dashed #000;
			margin: 10px 0;
		}

		table {
			width: 100%;
			border-collapse: collapse;
		}

		td {
			vertical-align: top;
			padding: 2px 0;
		}

		.right {
			text-align: right;
		}

		.center {
			text-align: center;
		}

		.uppercase {
			text-transform: uppercase;
		}

		.footer {
			margin-top: 30px;
		}
	</style>
</head>

<body>

	<div class="heading">
		@php

		@endphp

		@if (site('pakaiLogo') && file_exists($logoPath))
		<img src="{{ $logoBase64 }}" alt="Logo" style="width: 80px;">
		@endif
		<p class="title">{{ site('nama_toko') }}</p>
		<p>{{ site('alamat_toko') }}</p>
		<p>{{ site('telepon_toko') }}</p>
	</div>

	<hr>

	<table>
		<tr>
			<td width="30%">No Faktur</td>
			<td width="2%">:</td>
			<td>{{ $transaction->idPenjualan }}</td>
		</tr>
		<tr>
			<td>Tanggal</td>
			<td>:</td>
			<td>{{ date('d/m/y h:i A', strtotime($transaction->tanggal)) }}</td>
		</tr>
		<tr>
			<td>Kasir</td>
			<td>:</td>
			<td>{{ $transaction->namaUser }}</td>
		</tr>
	</table>

	<hr>

	@php
	$total = 0;
	$disc = 0;
	@endphp

	<table>
		@foreach($transaction->detail as $stuff)
		@php
		$subtotal = $stuff->jumlah * $stuff->hargaJual - $stuff->disc;
		$disc += $stuff->disc;
		$total += $subtotal;
		@endphp
		<tr>
			<td width="5%">{{ $loop->iteration }}.</td>
			<td width="65%">
				{{ $stuff->judul }}<br>
				<span style="font-size: 12px;">{{ $stuff->jumlah }} x {{ number_format($stuff->hargaJual) }} - Disc: {{
					number_format($stuff->disc) }}</span>
			</td>
			<td class="right" width="30%">{{ number_format($subtotal) }}</td>
		</tr>
		@endforeach
	</table>

	<hr>

	<table>
		<tr>
			<td width="40%">Total</td>
			<td width="2%">:</td>
			<td class="right">{{ number_format($total) }}</td>
		</tr>
		<tr>
			<td>PPN</td>
			<td>:</td>
			<td class="right">{{ number_format($transaction->ppn) }}</td>
		</tr>
		<tr>
			<td><strong>Subtotal</strong></td>
			<td>:</td>
			<td class="right"><strong>{{ number_format($total + $transaction->ppn) }}</strong></td>
		</tr>
		<tr>
			<td>Bayar</td>
			<td>:</td>
			<td class="right">{{ number_format($bayar ?? 0) }}</td>
		</tr>
		<tr>
			<td>Kembali</td>
			<td>:</td>
			<td class="right">{{ number_format(max($bayar - ($total + $transaction->ppn), 0)) }}</td>
		</tr>
	</table>

	<hr>

	<table>
		<tr>
			<td width="50%">BKP</td>
			<td class="right">{{ number_format($total) }}</td>
		</tr>
		<tr>
			<td>DISC</td>
			<td class="right">{{ number_format($disc) }}</td>
		</tr>
		<tr>
			<td>DPP</td>
			<td class="right">{{ number_format($total + $transaction->ppn) }}</td>
		</tr>
		<tr>
			<td>PPN</td>
			<td class="right">{{ number_format($transaction->ppn) }}</td>
		</tr>
	</table>

	<div class="footer center uppercase">
		<p>Terima kasih</p>
		<p>Barang yang sudah dibeli</p>
		<p>tidak dapat ditukar atau dikembalikan</p>
	</div>

</body>

</html>