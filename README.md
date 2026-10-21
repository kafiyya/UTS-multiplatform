# Sistem Inventaris Alat UKM JC UIN Malang

Aplikasi mobile berbasis Flutter untuk mencatat inventaris alat dan memantau peminjamannya di UKM JC UIN Malang. Aplikasi ini dibuat untuk memenuhi tugas Ujian Tengah Semester (UTS) mata kuliah Pemrograman Multiplatform.

## Deskripsi

Pencatatan inventaris dan peminjaman alat yang dilakukan secara manual membuat pengurus sulit mengetahui alat mana yang tersedia, siapa yang meminjam, dan untuk keperluan apa. Aplikasi ini membantu pengurus mengelola data alat dan status peminjamannya, serta memudahkan anggota mengajukan peminjaman. Seluruh data disimpan secara lokal sehingga aplikasi tetap dapat digunakan tanpa koneksi internet.

Aplikasi memiliki dua peran pengguna:
- **Pengurus (Admin)**: menambah alat dan menandai alat yang sudah dikembalikan.
- **Peminjam**: melihat ketersediaan alat dan mengajukan peminjaman.

## Fitur Utama

- Login berdasarkan peran (Peminjam atau Pengurus dengan kata sandi)
- Sesi login tersimpan, sehingga tidak perlu login ulang saat aplikasi dibuka kembali
- Dashboard daftar alat beserta kategori dan status (Tersedia / Dipinjam)
- Tambah alat baru (khusus Pengurus)
- Hapus data alat (khusus Pengurus)
- Pengajuan peminjaman alat dengan mengisi nama/NIM dan keperluan (Peminjam)
- Pencatatan pengembalian alat (Pengurus)
- Logout

## Konsep yang Diterapkan

- **Asynchronous programming**: `Future`, `async`, `await`, dan `FutureBuilder` untuk proses baca/tulis database dan penyimpanan preferensi
- **Data persistence** (dua teknik):
  - **SQLite** untuk menyimpan data alat dan status peminjaman
  - **Shared Preferences** untuk menyimpan sesi login (nama dan peran pengguna)

## Teknologi dan Package

| Teknologi / Package | Kegunaan |
|---|---|
| Flutter & Dart | Framework dan bahasa pemrograman aplikasi |
| [`sqflite`](https://pub.dev/packages/sqflite) | Basis data SQLite lokal |
| [`path`](https://pub.dev/packages/path) | Pengelolaan path berkas database |
| [`shared_preferences`](https://pub.dev/packages/shared_preferences) | Penyimpanan data key-value (sesi login) |
| [`cupertino_icons`](https://pub.dev/packages/cupertino_icons) | Ikon bawaan |

## Struktur Folder

```
lib/
├── main.dart                  # Entry point, pengecekan sesi login
├── helpers/
│   ├── database_helper.dart   # Pengelolaan SQLite
│   └── prefs_helper.dart      # Pengelolaan Shared Preferences
└── pages/
    ├── login_page.dart        # Halaman login
    ├── dashboard_page.dart    # Daftar alat
    ├── tambah_alat_page.dart  # Form tambah alat
    └── peminjaman_page.dart   # Detail alat, peminjaman, pengembalian
assets/
└── logo_ukm.png               # Logo UKM
```

## Cara Menjalankan Aplikasi

**Prasyarat:** Flutter SDK sudah terpasang (`flutter doctor` tidak menunjukkan galat) dan tersedia emulator Android atau perangkat fisik yang terhubung.

1. Clone repositori:
```bash
   git clone https://github.com/kafiyya/UTS-multiplatform.git
   cd UTS-multiplatform
```
2. Pasang dependensi:
```bash
   flutter pub get
```
3. Jalankan aplikasi:
```bash
   flutter run
```

## Cara Menggunakan

1. **Sebagai Peminjam**: pilih peran "Peminjam", isi nama, lalu tekan *Masuk Aplikasi*. Pilih alat yang berstatus Tersedia, isi keperluan, lalu ajukan peminjaman.
2. **Sebagai Pengurus**: pilih peran "Pengurus (Admin)", isi nama dan kata sandi **[kata sandi demo, atau hapus baris ini jika tidak ingin dicantumkan]**. Tambah alat lewat tombol (+), dan tandai alat yang sudah kembali dari halaman detail alat.

## Catatan

- Aplikasi diuji pada **Handphone Samsung A26**.
- Package `sqflite` berjalan langsung di Android dan iOS. Untuk web atau desktop diperlukan konfigurasi tambahan.
- Jika muncul galat kolom tidak ditemukan setelah skema database berubah, hapus (*uninstall*) aplikasi dari perangkat lalu jalankan ulang agar database dibuat ulang.

## Pembuat

- Nama: **Kahfiyya Nurzahra Hartono**
- NIM: **240605110053**
- Program Studi Teknik Informatika, Fakultas Sains dan Teknologi
- Universitas Islam Negeri Maulana Malik Ibrahim Malang
