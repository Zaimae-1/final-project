# Final Project — Flutter

Proyek Flutter untuk tugas final tim dengan **Muslim Pro** sebagai aplikasi acuan. Branch `zaim` memuat prototipe Beranda, Al-Qur'an, dan Kiblat.

## Ketentuan tugas

- Pilih aplikasi yang sudah diunduh lebih dari 500 ribu kali dan memiliki rating di atas 4 bintang.
- Buat tampilan dan alur penggunaan yang cukup mirip dengan aplikasi acuan.
- Fokus pada frontend; backend tidak diwajibkan.
- Siapkan presentasi kelompok tentang hasil cloning atau perbaikan yang dibuat.

## Menjalankan proyek

1. Pasang Flutter SDK dan jalankan `flutter doctor`.
2. Di folder proyek, jalankan `flutter pub get`.
3. Jalankan `flutter run` dan pilih perangkat Android atau browser.

Kode utama berada di `lib/main.dart`. Beranda menggunakan jadwal contoh. Halaman Al-Qur'an menampilkan empat surah yang bisa dicari dan dibaca. Halaman Kiblat menghitung perkiraan arah dari kota yang dipilih secara manual.

## Ide aplikasi

### Aplikasi acuan: Muslim Pro

Muslim Pro adalah aplikasi pendamping ibadah dari Bitsmedia. Pengguna dapat melihat jadwal salat sesuai lokasi, menerima pengingat azan, membaca atau mendengarkan Al-Qur'an, dan mencari arah kiblat. Aplikasi ini juga menyediakan alat untuk doa, zikir, serta kegiatan ibadah lainnya.

**Kesesuaian dengan syarat tugas:** Saat riset pada **13 November 2026**, [halaman Google Play berbahasa Indonesia](https://play.google.com/store/apps/details?hl=id&id=com.bitsmedia.android.muslimpro) menampilkan **100 juta+ unduhan** dan **rating 4,1/5**. Angka rating dapat berubah dan dapat berbeda menurut wilayah atau tampilan toko aplikasi; simpan tangkapan layar listing saat menyiapkan presentasi.

### Fitur aplikasi asli

| Area | Yang dapat dilakukan pengguna |
| --- | --- |
| Jadwal salat dan azan | Melihat waktu Subuh, Zuhur, Asar, Magrib, dan Isya berdasarkan lokasi; mengatur pengingat serta suara azan. |
| Al-Qur'an | Membaca teks Arab dan terjemahan, mendengarkan tilawah, serta mengikuti bacaan atau hafalan. |
| Kiblat dan kalender | Melihat arah kiblat dengan kompas dan tanggal penting dalam kalender Hijriah. |
| Pelacak ibadah | Mencatat salat lima waktu dan hari puasa, termasuk progres kebiasaan. |
| Doa dan zikir | Membuka kumpulan doa menurut situasi dan memakai penghitung tasbih digital. |
| Pencarian sekitar | Mencari masjid, tempat salat, dan restoran halal. |
| Fitur tambahan | Konten video Qalbox, komunitas Ummah, panduan haji/umrah, sedekah, serta tanya jawab AiDeen. |
| Premium | Menghapus iklan dan membuka pilihan audio, tampilan, serta konten tambahan. |

Daftar di atas merangkum [deskripsi Google Play](https://play.google.com/store/apps/details?id=com.bitsmedia.android.muslimpro) dan [situs resmi Muslim Pro](https://www.muslimpro.com/). Detail serta ketersediaan fitur dapat berubah menurut versi dan wilayah.

### Usulan cakupan clone untuk tim

Ini **usulan pengerjaan**, belum keputusan akhir tim. Karena tugas berfokus pada frontend, empat alur berikut cukup jelas untuk ditunjukkan saat presentasi:

1. **Beranda:** lokasi, tanggal Hijriah, jadwal lima waktu salat, dan salat berikutnya.
2. **Al-Qur'an:** daftar surah, halaman bacaan, terjemahan, dan kontrol audio contoh.
3. **Kiblat:** layar kompas dengan arah kiblat dan petunjuk penggunaan.
4. **Doa dan tasbih:** daftar doa, detail doa, dan penghitung zikir.

Jika waktu memungkinkan, tim dapat menambah pelacak salat, kalender Hijriah, dan pencari masjid. Untuk demo awal, data lokal atau contoh dapat dipakai; jadwal salat, arah kiblat, dan konten Al-Qur'an harus diberi label yang jelas bila belum memakai data atau perhitungan yang terverifikasi. Fitur komunitas, pembayaran, serta langganan membutuhkan rancangan lebih lanjut dan tidak masuk cakupan awal.

### Referensi riset

- [Muslim Pro di Google Play (Indonesia)](https://play.google.com/store/apps/details?hl=id&id=com.bitsmedia.android.muslimpro) — rating, unduhan, deskripsi fitur, dan tangkapan layar.
- [Situs resmi Muslim Pro](https://www.muslimpro.com/) — gambaran produk, fitur utama, dan Premium.
- [Muslim Pro di App Store Indonesia](https://apps.apple.com/id/app/muslim-pro-quran-azan-dua/id388389451) — penjelasan alur fitur dari pengembang.
