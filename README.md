# Laravel 8 Kasir

[![Laravel](https://img.shields.io/badge/Laravel-8.x-red.svg)](https://laravel.com)
[![PHP](https://img.shields.io/badge/PHP-%5E7.3-blue.svg)](https://php.net)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-4.x-purple.svg)](https://getbootstrap.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Aplikasi kasir sederhana berbasis web, dibangun menggunakan **Laravel 8**, **Bootstrap**, dan **Sufee Admin**. Cocok untuk usaha kecil dan menengah yang membutuhkan pencatatan transaksi, stok barang, serta laporan sederhana.

## 🌟 Fitur Utama

-   📊 **Dashboard** - Ringkasan penjualan dan statistik
-   🛍️ **Manajemen Produk** - Kelola barang, kategori, dan stok
-   🧾 **Point of Sale (POS)** - Interface kasir yang user-friendly
-   📋 **Manajemen Transaksi** - Riwayat dan detail transaksi
-   👥 **Manajemen User** - Kontrol akses pengguna
-   📈 **Laporan** - Laporan penjualan dan stok
-   🎨 **Responsive Design** - Tampilan yang optimal di semua perangkat

## 📋 Persyaratan Sistem

-   PHP >= 7.3
-   Composer
-   Node.js & NPM (opsional, untuk development)
-   MySQL/MariaDB
-   Web server (Apache/Nginx)

## 🇮🇩 Panduan Instalasi (Bahasa Indonesia)

### 1. **Clone repositori ini**

```bash
git clone https://github.com/reyhanasta/pointofsales.git
cd pointofsales
```

### 2. **Salin file environment**

```bash
cp .env.example .env
```

Lalu ubah konfigurasi database (`DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`) di file `.env` sesuai pengaturan lokal Anda.

### 3. **Install dependency Laravel**

```bash
composer install
```

### 4. **Generate application key**

```bash
php artisan key:generate
```

### 5. **Buat symbolic link ke folder penyimpanan**

```bash
php artisan storage:link
```

### 6. **Import database manual**

Import manual database yang sudah di sediakan, (migrasi menyusul)

### 7. **Jalankan aplikasi**

```bash
php artisan serve
```

Akses melalui `http://localhost:8000`

### 8. ✅ **Aplikasi siap digunakan!**

**Login Default:**

-   Email: `admin@kasir.com`
-   Password: `password`

---

## 📝 Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE).
