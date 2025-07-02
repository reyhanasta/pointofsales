-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 30, 2024 at 06:55 AM
-- Server version: 10.11.8-MariaDB-cll-lve
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u904564205_pos`
--

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `idBuku` varchar(10) NOT NULL,
  `idKategori` int(11) DEFAULT NULL,
  `idRak` int(11) DEFAULT NULL,
  `barcode` varchar(30) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `noisbn` varchar(50) DEFAULT NULL,
  `penulis` varchar(50) DEFAULT NULL,
  `penerbit` varchar(50) NOT NULL,
  `tahun` varchar(4) NOT NULL,
  `stock` int(11) UNSIGNED NOT NULL,
  `hargaPokok` int(11) NOT NULL,
  `hargaJual` int(11) NOT NULL,
  `disc` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`idBuku`, `idKategori`, `idRak`, `barcode`, `judul`, `noisbn`, `penulis`, `penerbit`, `tahun`, `stock`, `hargaPokok`, `hargaJual`, `disc`) VALUES
('BK00001', 4, 4, '9786230032998', 'Clasmild RedMax 1 Bungkus', '9786230032998', NULL, '1 Bungkus', '2024', 2, 200000, 252000, 0),
('BK00002', 3, 1, '9786230025945', 'Malboro Merah 1 Slop', '9786230025945', NULL, '1 Slop', '2024', 4, 33000, 40000, 0),
('BK00003', 2, 3, '9786230042485', 'Gudang Garam Internasional 1 Bungkus', '9786230042485', NULL, '1 Bungkus', '2024', 5, 22000, 27000, 0);

-- --------------------------------------------------------

--
-- Table structure for table `detail_pembelian`
--

CREATE TABLE `detail_pembelian` (
  `idDetailPembelian` varchar(6) NOT NULL,
  `idPembelian` varchar(20) NOT NULL,
  `idBuku` varchar(10) DEFAULT NULL,
  `judul` varchar(100) NOT NULL,
  `hargaPokok` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `detail_pembelian`
--

INSERT INTO `detail_pembelian` (`idDetailPembelian`, `idPembelian`, `idBuku`, `judul`, `hargaPokok`, `jumlah`) VALUES
('P00001', 'P0001-170305-300624', 'BK00001', 'Clasmild RedMax 1 Bungkus', 200000, 10),
('P00002', 'P0002-170305-300624', 'BK00003', 'Gudang Garam Internasional 1 Bungkus', 22000, 20),
('P00003', 'P0003-170305-300624', 'BK00002', 'Malboro Merah 1 Slop', 33000, 20);

--
-- Triggers `detail_pembelian`
--
DELIMITER $$
CREATE TRIGGER `update stock` BEFORE INSERT ON `detail_pembelian` FOR EACH ROW UPDATE buku a set a.stock = a.stock + new.jumlah where a.idBuku = new.idBuku
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan`
--

CREATE TABLE `detail_penjualan` (
  `idDetailPenjualan` varchar(6) NOT NULL,
  `idPenjualan` varchar(20) NOT NULL,
  `idBuku` varchar(10) DEFAULT NULL,
  `judul` varchar(100) NOT NULL,
  `hargaPokok` int(11) NOT NULL,
  `hargaJual` int(11) NOT NULL,
  `disc` float NOT NULL,
  `ppn` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `detail_penjualan`
--

INSERT INTO `detail_penjualan` (`idDetailPenjualan`, `idPenjualan`, `idBuku`, `judul`, `hargaPokok`, `hargaJual`, `disc`, `ppn`, `jumlah`) VALUES
('T00001', 'T0001-170302-300624', 'BK00003', 'Gudang Garam Internasional 1 Bungkus', 22000, 27000, 0, 27000, 10),
('T00002', 'T0002-170302-300624', 'BK00002', 'Malboro Merah 1 Slop', 33000, 40000, 0, 40000, 10),
('T00003', 'T0003-170302-300624', 'BK00001', 'Clasmild RedMax 1 Bungkus', 200000, 252000, 0, 126000, 5),
('T00004', 'T0004-170302-300624', 'BK00001', 'Clasmild RedMax 1 Bungkus', 200000, 252000, 0, 75600, 3),
('T00005', 'T0004-170302-300624', 'BK00003', 'Gudang Garam Internasional 1 Bungkus', 22000, 27000, 0, 13500, 5),
('T00006', 'T0004-170302-300624', 'BK00002', 'Malboro Merah 1 Slop', 33000, 40000, 0, 20000, 5);

--
-- Triggers `detail_penjualan`
--
DELIMITER $$
CREATE TRIGGER `update_stok_buku` BEFORE INSERT ON `detail_penjualan` FOR EACH ROW UPDATE buku a set a.stock = a.stock - new.jumlah where idBuku = new.idBuku
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `distributor`
--

CREATE TABLE `distributor` (
  `idDist` varchar(10) NOT NULL,
  `namaDist` varchar(50) NOT NULL,
  `alamat` varchar(250) NOT NULL,
  `telepon` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `distributor`
--

INSERT INTO `distributor` (`idDist`, `namaDist`, `alamat`, `telepon`) VALUES
('DIS0001', 'PT Gudang Garam', 'Bandung', '085854749138'),
('DIS0002', 'PT Malboro', 'Jakarta', '0265213122'),
('DIS0003', 'PT Clas Mild', 'Cilacap', '0265213123');

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `idKategori` int(11) NOT NULL,
  `nama_kategori` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`idKategori`, `nama_kategori`) VALUES
(1, 'Camel'),
(2, 'Gudang Garam'),
(3, 'Malboro'),
(4, 'Clasmild');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_pengeluaran`
--

CREATE TABLE `kategori_pengeluaran` (
  `idKategoriPengeluaran` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `kategori_pengeluaran`
--

INSERT INTO `kategori_pengeluaran` (`idKategoriPengeluaran`, `nama`) VALUES
(1, 'Gaji Karyawan'),
(2, 'Pembelian Rokok'),
(3, 'Bayar Pajak'),
(4, 'StokOpName'),
(5, 'Listrik Dan Air'),
(6, 'Pembelian Rok'),
(7, 'Pembelian Barang');

-- --------------------------------------------------------

--
-- Table structure for table `opname`
--

CREATE TABLE `opname` (
  `idOpname` int(11) NOT NULL,
  `idBuku` varchar(10) DEFAULT NULL,
  `judul` varchar(100) NOT NULL,
  `tanggal` datetime NOT NULL,
  `stokSistem` int(11) NOT NULL,
  `stokNyata` int(11) NOT NULL,
  `hargaPokok` int(11) NOT NULL,
  `keterangan` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `opname`
--

INSERT INTO `opname` (`idOpname`, `idBuku`, `judul`, `tanggal`, `stokSistem`, `stokNyata`, `hargaPokok`, `keterangan`) VALUES
(8, 'BK00002', 'Malboro Merah 1 Slop', '2024-06-30 12:42:37', 5, 4, 33000, '1 stok hilang');

-- --------------------------------------------------------

--
-- Table structure for table `pembelian`
--

CREATE TABLE `pembelian` (
  `idPembelian` varchar(20) NOT NULL,
  `idUser` varchar(10) DEFAULT NULL,
  `idDist` varchar(10) DEFAULT NULL,
  `namaUser` varchar(50) NOT NULL,
  `namaDist` varchar(50) NOT NULL,
  `total` int(11) NOT NULL,
  `tanggal` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `pembelian`
--

INSERT INTO `pembelian` (`idPembelian`, `idUser`, `idDist`, `namaUser`, `namaDist`, `total`, `tanggal`) VALUES
('P0001-170305-300624', '170305', 'DIS0003', 'Arsya Saputra', 'PT Clas Mild', 2000000, '2024-06-30 12:35:08'),
('P0002-170305-300624', '170305', 'DIS0001', 'Arsya Saputra', 'PT Gudang Garam', 440000, '2024-06-30 12:35:30'),
('P0003-170305-300624', '170305', 'DIS0002', 'Arsya Saputra', 'PT Malboro', 660000, '2024-06-30 12:35:45');

-- --------------------------------------------------------

--
-- Table structure for table `pengaturan`
--

CREATE TABLE `pengaturan` (
  `idPengaturan` int(11) NOT NULL,
  `idUser` varchar(10) DEFAULT NULL,
  `nama_toko` varchar(20) NOT NULL,
  `alamat_toko` varchar(50) NOT NULL,
  `telepon_toko` varchar(15) NOT NULL,
  `logo` varchar(50) NOT NULL,
  `pakaiLogo` tinyint(1) DEFAULT 1,
  `ppn` double NOT NULL,
  `min_stok` int(11) NOT NULL DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `pengaturan`
--

INSERT INTO `pengaturan` (`idPengaturan`, `idUser`, `nama_toko`, `alamat_toko`, `telepon_toko`, `logo`, `pakaiLogo`, `ppn`, `min_stok`) VALUES
(1, '170301', 'Toko Anugrah', 'Jl Argasari 1 No 4', '(0265) 9107713', '1719638684.png', 1, 10, 5);

-- --------------------------------------------------------

--
-- Table structure for table `pengeluaran`
--

CREATE TABLE `pengeluaran` (
  `idPengeluaran` varchar(20) NOT NULL,
  `idPembelian` varchar(20) DEFAULT NULL,
  `idOpname` int(11) DEFAULT NULL,
  `idPajak` varchar(21) DEFAULT NULL,
  `idKategoriPengeluaran` int(11) DEFAULT NULL,
  `idUser` varchar(10) DEFAULT NULL,
  `namaUser` varchar(50) DEFAULT NULL,
  `namaKategori` varchar(50) NOT NULL,
  `pengeluaran` int(11) NOT NULL,
  `keterangan` varchar(30) DEFAULT NULL,
  `tanggal` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `pengeluaran`
--

INSERT INTO `pengeluaran` (`idPengeluaran`, `idPembelian`, `idOpname`, `idPajak`, `idKategoriPengeluaran`, `idUser`, `namaUser`, `namaKategori`, `pengeluaran`, `keterangan`, `tanggal`) VALUES
('BOP001-170305-300624', 'P0001-170305-300624', NULL, NULL, 7, NULL, NULL, 'Pembelian Barang', 2000000, 'PT Clas Mild', '2024-06-30 12:35:08'),
('BOP002-170305-300624', 'P0002-170305-300624', NULL, NULL, 7, NULL, NULL, 'Pembelian Barang', 440000, 'PT Gudang Garam', '2024-06-30 12:35:30'),
('BOP003-170305-300624', 'P0003-170305-300624', NULL, NULL, 7, NULL, NULL, 'Pembelian Barang', 660000, 'PT Malboro', '2024-06-30 12:35:45'),
('BOP004-170301-300624', NULL, 8, NULL, 4, NULL, NULL, 'StokOpName', 33000, '1 stok hilang', '2024-06-30 12:42:37');

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `idPenjualan` varchar(20) NOT NULL,
  `idUser` varchar(10) DEFAULT NULL,
  `namaUser` varchar(50) NOT NULL,
  `total` int(11) NOT NULL,
  `ppn` int(11) NOT NULL,
  `tanggal` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `penjualan`
--

INSERT INTO `penjualan` (`idPenjualan`, `idUser`, `namaUser`, `total`, `ppn`, `tanggal`, `status`) VALUES
('T0001-170302-300624', '170302', 'Erna Ratnasari', 297000, 27000, '2024-06-30 12:36:11', 1),
('T0002-170302-300624', '170302', 'Erna Ratnasari', 440000, 40000, '2024-06-30 12:36:22', 1),
('T0003-170302-300624', '170302', 'Erna Ratnasari', 1386000, 126000, '2024-06-30 12:36:32', 1),
('T0004-170302-300624', '170302', 'Erna Ratnasari', 1200100, 109100, '2024-06-30 12:37:24', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ppn`
--

CREATE TABLE `ppn` (
  `idPajak` varchar(21) NOT NULL,
  `idPenjualan` varchar(20) DEFAULT NULL,
  `idUser` varchar(10) DEFAULT NULL,
  `jenis` varchar(100) NOT NULL,
  `nominal` int(11) NOT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `tanggal` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ppn`
--

INSERT INTO `ppn` (`idPajak`, `idPenjualan`, `idUser`, `jenis`, `nominal`, `keterangan`, `tanggal`) VALUES
('PPN0001-170302-300624', 'T0001-170302-300624', '170302', 'PPN Dikeluarkan', 27000, 'T0001', '2024-06-30 12:36:11'),
('PPN0002-170302-300624', 'T0002-170302-300624', '170302', 'PPN Dikeluarkan', 40000, 'T0002', '2024-06-30 12:36:22'),
('PPN0003-170302-300624', 'T0003-170302-300624', '170302', 'PPN Dikeluarkan', 126000, 'T0003', '2024-06-30 12:36:32'),
('PPN0004-170302-300624', 'T0004-170302-300624', '170302', 'PPN Dikeluarkan', 109100, 'T0004', '2024-06-30 12:37:24');

-- --------------------------------------------------------

--
-- Table structure for table `rak`
--

CREATE TABLE `rak` (
  `idRak` int(11) NOT NULL,
  `nama_rak` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `rak`
--

INSERT INTO `rak` (`idRak`, `nama_rak`) VALUES
(1, '1'),
(2, '2'),
(3, '3'),
(4, '4');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `idUser` varchar(10) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` varchar(250) NOT NULL,
  `telepon` varchar(20) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(64) NOT NULL,
  `hakAkses` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`idUser`, `nama`, `alamat`, `telepon`, `username`, `password`, `hakAkses`) VALUES
('170301', 'Aldi', 'Ciamis', '082121397663', 'aldi', '5cf15fc7e77e85f5d525727358c0ffc9', '1'),
('170302', 'Erna Ratnasari', 'Bandung', '0821213977632', 'erna', '035b3c6377652bd7d49b5d2e9a53ef40', '2'),
('170303', 'Rindiani', 'Bandung', '082727272', 'ririn', 'b84a4059d1af6c8b50bb7a28290dbd63', '2'),
('170304', 'Arya Saputra', 'Tasik', '082181412', 'arya', '5882985c8b1e2dce2763072d56a1d6e5', '3'),
('170305', 'Arsya Saputra', 'Tasik', '0821747121', 'arsya', '6582c680591052c3bed506891a0560be', '3');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`idBuku`),
  ADD KEY `fk_rakbuku` (`idRak`),
  ADD KEY `fk_kategoribuku` (`idKategori`);

--
-- Indexes for table `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  ADD PRIMARY KEY (`idDetailPembelian`),
  ADD KEY `fk_detailpasok` (`idPembelian`),
  ADD KEY `fk_detailpasokbuku` (`idBuku`);

--
-- Indexes for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD PRIMARY KEY (`idDetailPenjualan`),
  ADD KEY `fk_transaksipenjualan` (`idPenjualan`),
  ADD KEY `fk_transaksibuku` (`idBuku`);

--
-- Indexes for table `distributor`
--
ALTER TABLE `distributor`
  ADD PRIMARY KEY (`idDist`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`idKategori`);

--
-- Indexes for table `kategori_pengeluaran`
--
ALTER TABLE `kategori_pengeluaran`
  ADD PRIMARY KEY (`idKategoriPengeluaran`);

--
-- Indexes for table `opname`
--
ALTER TABLE `opname`
  ADD PRIMARY KEY (`idOpname`),
  ADD KEY `fk_opname_buku` (`idBuku`);

--
-- Indexes for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD PRIMARY KEY (`idPembelian`),
  ADD KEY `fk_pasok_user` (`idUser`),
  ADD KEY `fk_pasok_dist` (`idDist`);

--
-- Indexes for table `pengaturan`
--
ALTER TABLE `pengaturan`
  ADD PRIMARY KEY (`idPengaturan`),
  ADD KEY `fk_pengaturan_user` (`idUser`);

--
-- Indexes for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD PRIMARY KEY (`idPengeluaran`),
  ADD KEY `fk_pengeluaran_user` (`idUser`),
  ADD KEY `fk_kategori_pengeluaran` (`idKategoriPengeluaran`),
  ADD KEY `fk_pasok_pengeluaran` (`idPembelian`),
  ADD KEY `fk_pengeluaran_opname` (`idOpname`),
  ADD KEY `fk_pengeluaran_ppn` (`idPajak`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`idPenjualan`),
  ADD KEY `fk_penjualan_kasir` (`idUser`);

--
-- Indexes for table `ppn`
--
ALTER TABLE `ppn`
  ADD PRIMARY KEY (`idPajak`),
  ADD KEY `idUser` (`idUser`),
  ADD KEY `idPenjualan` (`idPenjualan`);

--
-- Indexes for table `rak`
--
ALTER TABLE `rak`
  ADD PRIMARY KEY (`idRak`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`idUser`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `idKategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `kategori_pengeluaran`
--
ALTER TABLE `kategori_pengeluaran`
  MODIFY `idKategoriPengeluaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `opname`
--
ALTER TABLE `opname`
  MODIFY `idOpname` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `pengaturan`
--
ALTER TABLE `pengaturan`
  MODIFY `idPengaturan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rak`
--
ALTER TABLE `rak`
  MODIFY `idRak` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `buku`
--
ALTER TABLE `buku`
  ADD CONSTRAINT `fk_kategoribuku` FOREIGN KEY (`idKategori`) REFERENCES `kategori` (`idKategori`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_rakbuku` FOREIGN KEY (`idRak`) REFERENCES `rak` (`idRak`) ON DELETE SET NULL;

--
-- Constraints for table `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  ADD CONSTRAINT `fk_detailpasok` FOREIGN KEY (`idPembelian`) REFERENCES `pembelian` (`idPembelian`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_detailpasokbuku` FOREIGN KEY (`idBuku`) REFERENCES `buku` (`idBuku`) ON DELETE SET NULL;

--
-- Constraints for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD CONSTRAINT `fk_transaksibuku` FOREIGN KEY (`idBuku`) REFERENCES `buku` (`idBuku`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_transaksipenjualan` FOREIGN KEY (`idPenjualan`) REFERENCES `penjualan` (`idPenjualan`) ON DELETE CASCADE;

--
-- Constraints for table `opname`
--
ALTER TABLE `opname`
  ADD CONSTRAINT `fk_opname_buku` FOREIGN KEY (`idBuku`) REFERENCES `buku` (`idBuku`) ON DELETE SET NULL;

--
-- Constraints for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD CONSTRAINT `fk_pasok_dist` FOREIGN KEY (`idDist`) REFERENCES `distributor` (`idDist`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_pasok_user` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE SET NULL;

--
-- Constraints for table `pengaturan`
--
ALTER TABLE `pengaturan`
  ADD CONSTRAINT `fk_pengaturan_user` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE SET NULL;

--
-- Constraints for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD CONSTRAINT `fk_kategori_pengeluaran` FOREIGN KEY (`idKategoriPengeluaran`) REFERENCES `kategori_pengeluaran` (`idKategoriPengeluaran`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_pasok_pengeluaran` FOREIGN KEY (`idPembelian`) REFERENCES `pembelian` (`idPembelian`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pengeluaran_opname` FOREIGN KEY (`idOpname`) REFERENCES `opname` (`idOpname`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pengeluaran_ppn` FOREIGN KEY (`idPajak`) REFERENCES `ppn` (`idPajak`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pengeluaran_user` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE SET NULL;

--
-- Constraints for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `fk_penjualan_kasir` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE SET NULL;

--
-- Constraints for table `ppn`
--
ALTER TABLE `ppn`
  ADD CONSTRAINT `ppn_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE SET NULL,
  ADD CONSTRAINT `ppn_ibfk_2` FOREIGN KEY (`idPenjualan`) REFERENCES `penjualan` (`idPenjualan`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
