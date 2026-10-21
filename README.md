# Sistem Inventaris Alat UKM JC UIN Malang

Aplikasi mobile berbasis Flutter untuk mencatat dan mengelola inventaris alat UKM JC UIN Malang. Aplikasi ini dibuat untuk memenuhi tugas Ujian Tengah Semester (UTS) mata kuliah Pemrograman Multiplatform.

## Deskripsi

Pencatatan alat UKM yang dilakukan secara manual sering menyebabkan data hilang dan kondisi alat tidak terpantau. Aplikasi ini membantu pengurus mencatat, memantau, dan memperbarui data alat secara terstruktur langsung dari perangkat mobile. Seluruh data disimpan secara lokal sehingga aplikasi tetap dapat digunakan tanpa koneksi internet.

## Fitur Utama

- Menampilkan daftar inventaris alat (nama, kategori, jumlah, kondisi)
- Menambah data alat baru
- Mengubah data alat
- Menghapus data alat dengan dialog konfirmasi
- Pencarian / filter alat **[sesuaikan]**
- Pengaturan tema terang dan gelap yang tetap tersimpan setelah aplikasi ditutup **[sesuaikan]**

## Konsep yang Diterapkan

- **Asynchronous programming**: `Future`, `async`, dan `await` untuk proses baca/tulis data **[tambahkan `FutureBuilder` jika dipakai]**
- **Data persistence** (dua teknik):
  - **SQLite** untuk menyimpan data alat yang terstruktur
  - **Shared Preferences** untuk menyimpan preferensi pengguna **[sesuaikan, misalnya tema]**

## Teknologi dan Package

| Teknologi / Package | Kegunaan |
|---|---|
| Flutter & Dart | Framework dan bahasa pemrograman aplikasi |
| [`sqflite`](https://pub.dev/packages/sqflite) | Basis data SQLite lokal |
| [`path`](https://pub.dev/packages/path) | Pengelolaan path berkas database |
| [`shared_preferences`](https://pub.dev/packages/shared_preferences) | Penyimpanan data key-value |
| [`cupertino_icons`](https://pub.dev/packages/cupertino_icons) | Ikon bawaan |

## Struktur Folder

```
lib/            # Source code utama aplikasi
assets/         # Aset aplikasi (logo_ukm.png)
android/        # Konfigurasi platform Android
ios/            # Konfigurasi platform iOS
test/           # Berkas pengujian
pubspec.yaml    # Konfigurasi project dan dependensi
```

## Cara Menjalankan Aplikasi

**Prasyarat:** Flutter SDK sudah terpasang (`flutter doctor` tidak menunjukkan galat), serta emulator Android atau perangkat fisik yang terhubung.

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

> Catatan: aplikasi diuji pada **[smartphone]**. Package `sqflite` berjalan langsung di Android dan iOS. Untuk web atau desktop diperlukan konfigurasi tambahan.

## Pembuat

- Nama: **[Kahfiyya Nurzahra Hartono]**
- NIM: **[240605110053]**
- Program Studi Teknik Informatika, Universitas Islam Negeri Maulana Malik Ibrahim Malang
