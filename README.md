# myportofolio_mobile

## Individual Assignment 8 - Basic Flutter

Aplikasi Flutter ini menampilkan halaman portofolio pribadi dengan informasi NPM, nama, dan kelas, serta kartu aksi untuk melihat proyek, menambah proyek, dan logout. Proyek dibuat dengan memisahkan halaman utama ke `lib/menu.dart`, memakai widget `StatelessWidget`, dan menjalankan SnackBar saat kartu aksi ditekan.

### Menjalankan proyek

Jalankan dari root proyek (pastikan Flutter SDK terpasang):

```bash
flutter pub get
flutter run
```

Untuk menjalankan di localhost Edge: `flutter run -d edge`. Untuk memeriksa kode: `flutter analyze`.

### AI Disclosure

Saya menggunakan DeepSeek V4.1 Flash sebagai alat bantu mengerjakan tugas ini. Saya meminta penjelasan konsep Flutter, bantuan menelusuri penyebab layout overflow, serta pemeriksaan terhadap checklist tugas dan saran perbaikan dokumentasi. Saya meninjau dan menerapkan perubahan yang sesuai, lalu memeriksa kode dengan `flutter analyze`. AI terkadang keliru atau memberi saran yang keluar dari konteks project, sehingga hasilnya tetap saya verifikasi ulang.

### Tugas 8

1. **Apa itu widget tree dan bagaimana hubungan parent-child bekerja?**

   Widget tree: susunan widget Flutter yang membentuk interface aplikasi. Widget parent menampung dan mengatur widget child, child dapat mewarisi batasan layout atau tema dari parent, sedangkan perubahan susunan parent dapat memengaruhi tampilan child. Contohnya, `Scaffold` menjadi parent untuk `AppBar` dan `body`.

2. **Widget apa saja yang digunakan dan apa fungsinya?**

   `MaterialApp` menyiapkan kerangka aplikasi bergaya Material; `Scaffold` menyediakan struktur halaman; `AppBar` menampilkan bilah atas; `SingleChildScrollView` memungkinkan isi digulir; `Padding` memberi jarak; `Column` dan `Row` menyusun widget vertikal dan horizontal; `Center` menempatkan isi di tengah; `Text` menampilkan tulisan; `SizedBox` dan `Padding` mengatur jarak; `GridView.count` menampilkan kartu dalam kisi; `Card` dan `Container` membentuk area informasi; `InfoCard` menampilkan NPM, nama, atau kelas; `Material` dan `InkWell` membentuk kartu aksi yang dapat ditekan; `ItemCard` menampilkan ikon dan nama aksi; `Icon` menampilkan simbol; `SnackBar` menampilkan pesan sementara; `ScaffoldMessenger` menampilkan SnackBar; `MediaQuery` membaca ukuran layar; `Theme` mengambil warna tema; dan `StatelessWidget` menjadi dasar widget yang tidak menyimpan state yang berubah.

3. **Apa fungsi `MaterialApp` dan mengapa biasanya menjadi root widget?**

   `MaterialApp` menyediakan fitur dasar aplikasi Material, seperti tema, navigasi, dan konfigurasi halaman. Widget ini sering menjadi root agar pengaturan tersebut tersedia bagi seluruh widget di bawahnya melalui widget tree.

4. **Apa perbedaan `StatelessWidget` dan `StatefulWidget`? Kapan dipakai?**

   `StatelessWidget` tidak menyimpan state yang berubah selama hidupnya, sehingga cocok untuk tampilan yang bergantung pada input tetap. `StatefulWidget` memiliki objek `State` yang dapat menyimpan data yang berubah dan membangun ulang tampilan, misalnya saat input pengguna atau proses jaringan mengubah data. Pilih `StatelessWidget` untuk UI tanpa perubahan state lokal; pilih `StatefulWidget` saat UI perlu merespons perubahan tersebut.

5. **Apa itu `BuildContext` dan bagaimana dipakai di `build`?**

   `BuildContext` adalah referensi ke lokasi sebuah widget dalam widget tree. Di `build`, context dapat dipakai untuk mengakses informasi dari ancestor, misalnya `Theme.of(context)` untuk tema dan `MediaQuery.of(context)` untuk ukuran layar. Context harus digunakan pada lokasi widget yang tepat agar data ancestor yang dibutuhkan tersedia.

6. **Apa itu hot reload dan bedanya dengan hot restart? Kapan perlu restart penuh?**

   Hot reload: menerapkan perubahan kode ke aplikasi yang sedang berjalan dan biasanya mempertahankan state saat ini. Hot restart: memulai ulang aplikasi dari `main()` sehingga state aplikasi di-reset. Hot reload tidak cukup untuk perubahan yang memerlukan inisialisasi ulang, seperti perubahan `main()` atau state awal tertentu; gunakan hot restart. Full restart <- bila perubahan konfigurasi native atau plugin tidak diterapkan oleh hot reload maupun hot restart.
