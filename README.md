# myportofolio_mobile

## Individual Assignment 7 - Basic Flutter

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

### Pertanyaan Reflektif

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

## Individual Assignment 8 - Navigation, Layouts, Forms, and Input Elements
Aplikasi Flutter ini melanjutkan portofolio mobile dari Tugas 7 dengan menambahkan halaman formulir Edukasi, navigasi dari kartu aksi dan drawer, serta validasi input yang berakhir pada dialog ringkasan. Formulir Project dari Tutorial 09 dilengkapi validasi format URL, dan drawer yang sama dipakai di seluruh halaman.

### Dokumentasi
Halaman utama (`lib/screens/menu.dart`) menampilkan tiga `InfoCard` berisi NPM, nama, dan kelas, serta empat kartu aksi: Lihat Proyek, Tambah Proyek, Tambah Edukasi, dan Logout. Setiap kartu menampilkan SnackBar saat ditekan, dan kartu yang memiliki tujuan membuka halaman melalui `Navigator.push()`.

Halaman formulir berada di `lib/screens/`:

- `project_form.dart` — formulir Add Project dari Tutorial 09, dengan validasi tambahan untuk Teknologi dan format URL.
- `education_form.dart` — formulir Add Education dengan lima input: Nama Institusi, Jurusan atau Gelar, Tanggal Mulai, Tanggal Selesai, dan Catatan.

Komponen yang dipakai ulang berada di `lib/widgets/`:

- `left_drawer.dart` — drawer berisi Home, Add Project, dan Add Education.
- `project_card.dart` — kartu aksi yang membuka halaman sesuai `ItemHomepage.page`, sehingga menambah kartu baru tidak perlu mengubah logika kartu.

Menjalankan proyek dari root direktori (Flutter SDK terpasang):

```bash
flutter pub get
flutter run
```

Untuk menjalankan di localhost Edge: `flutter run -d edge`. Untuk memeriksa kode dan menjalankan pengujian:

```bash
flutter analyze
flutter test
```

### AI Disclosure
Saya menggunakan DeepSeek V4.1 Flash sebagai alat bantu mengerjakan tugas ini. Saya meminta bantuan membaca ulang seluruh codebase untuk membuat checklist task Tugas 8, membantu menjelaskan kode, membuat halaman formulir Edukasi beserta validasinya, menambahkan navigasi dari kartu aksi dan drawer, serta menyusun widget test untuk alur formulir. AI juga menemukan bug lama pada header drawer, dan perbaikannya saya verifikasi lewat `flutter test`. AI sempat membuat asumsi tentang nama field model Edukasi di proyek Django saya tanpa memeriksa repositorinya, sehingga penyesuaian nama field saya lakukan sendiri.

### Pertanyaan Reflektif
1. **Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.**

   `Navigator.push()` menambahkan route baru di atas route yang sedang aktif. Route lama tetap berada di stack, sehingga tombol kembali bawaan perangkat mengantar pengguna ke halaman sebelumnya. Ini yang dipakai kartu aksi Tambah Proyek dan Tambah Edukasi di `lib/widgets/project_card.dart`, serta opsi Add Project dan Add Education di drawer, karena setelah mengisi formulir pengguna wajar kembali ke halaman asal.

   `Navigator.pushReplacement()` mengganti route yang sedang aktif dengan route baru. Route lama dibuang dari stack, sehingga tombol kembali tidak mengarah ke halaman yang diganti. Ini dipakai opsi Home di `lib/widgets/left_drawer.dart` untuk menuju `MyHomePage()`. Karena halaman formulir diganti, pengguna tidak terjebak bolak-balik antara Home dan formulir saat menekan tombol kembali.

   `Navigator.pop()` menutup route paling atas dan kembali ke route di bawahnya. Ini dipakai tombol OK pada `AlertDialog` untuk menutup dialog dan kembali ke formulir.

   Metode yang digunakan untuk membuka formulir dari kartu aksi adalah `Navigator.push()`.

2. **Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.**

   `Scaffold` menyediakan slot tetap berupa `appBar`, `drawer`, dan `body`, sehingga setiap halaman memiliki susunan yang sama tanpa perlu dibangun ulang dari nol. `AppBar` menempatkan judul dan tombol menu pada posisi yang konsisten, sedangkan `Drawer` menyediakan navigasi global. Karena halaman utama, formulir Project, dan formulir Education sama-sama memakai `Scaffold` dengan `drawer: const LeftDrawer()`, drawer yang tampil identik di ketiganya, dan menambah satu opsi cukup diubah pada satu berkas.

   Contoh penggunaan warna tema: `Theme.of(context).colorScheme.primary` dipakai pada `AppBar` halaman utama, `AppBar` kedua halaman formulir, header drawer, dan tombol Save. Warna tersebut berasal dari `seedColor: Colors.indigo` di `main.dart`, sehingga mengubah satu nilai itu langsung mengubah tampilan seluruh halaman.

3. **Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.**

   Susunan yang dipakai adalah `Form` di dalam `SingleChildScrollView`, berisi `Column` dengan `Padding` pada setiap field, lalu tombol Save di `Align` bagian bawah. `Column` dipilih karena formulir adalah alur input dari atas ke bawah, sehingga urutan field terbaca sebagai langkah yang berurutan.

   `Padding` memberi jarak antar field agar label, isi, dan pesan kesalahan tidak saling menempel, sekaligus memperbesar area sentuh tiap kolom. `SingleChildScrollView` membuat isi formulir dapat digulir ketika tingginya melebihi ruang layar, kondisi yang biasa terjadi pada layar ponsel sempit atau saat papan ketik muncul dan menyusutkan area tampilan. Tanpa widget penggulir, tombol Save dapat terdorong keluar layar dan tidak dapat ditekan.

4. **Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.**

   `GlobalKey<FormState>` memberi pegangan ke state `Form` dari luar widget tree, sehingga tombol Save dapat memanggil `_formKey.currentState!.validate()`. `validator` adalah fungsi pada tiap field yang mengembalikan pesan kesalahan atau `null` bila isian sah. `validate()` menjalankan seluruh validator sekaligus, menampilkan pesan pada field yang gagal, dan mengembalikan `false` bila ada isian yang tidak lolos. Dialog ringkasan hanya ditampilkan ketika hasilnya `true`.

   Contoh nilai yang ditolak adalah isian berisi tiga spasi `"   "` pada Nama Institusi. Setelah `trim()` nilainya kosong, sehingga muncul pesan "Nama institusi tidak boleh kosong!". Contoh lain, Tautan Proyek yang diisi `tokopedia.com` tanpa skema ditolak dengan pesan "Tautan harus diawali http:// atau https://", dan Tanggal Selesai yang lebih awal daripada Tanggal Mulai juga ditolak.

   Memilih jenis input atau papan ketik saja belum cukup karena `keyboardType` hanya mengubah tampilan papan ketik di layar. Pengguna tetap dapat menempel teks, memakai papan ketik fisik, atau mengetik karakter yang tidak disediakan layout tersebut. Nilai akhirnya tetap harus diperiksa saat disimpan, karena hanya validasi yang memeriksa isi data sebenarnya.
