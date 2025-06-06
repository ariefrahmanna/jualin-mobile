import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/themes/colors.dart';

class TermConditionsView extends GetView {
  const TermConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        centerTitle: true,
        backgroundColor: AppColors.neutral10,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Syarat dan Ketentuan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Dengan menggunakan aplikasi ini, Anda setuju dengan syarat dan ketentuan berikut:',
                      style: TextStyle(fontSize: 15, height: 1.6),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Akun Pengguna',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Pengguna wajib memberikan data yang akurat dan terkini saat mendaftar.\n'
                      '• Pengguna bertanggung jawab atas keamanan akun dan kata sandi mereka.\n'
                      '• Aktivitas yang dilakukan melalui akun pengguna sepenuhnya menjadi tanggung jawab pemilik akun.',
                      style: TextStyle(fontSize: 15, height: 1.6),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Ketentuan Barang',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Hanya barang bekas legal dan layak jual yang diperbolehkan untuk diperdagangkan.\n'
                      '• Barang yang melanggar hukum, mengandung unsur SARA, pornografi, atau membahayakan dilarang keras.\n'
                      '• Penjual wajib memberikan deskripsi yang jujur dan sesuai kondisi barang.',
                      style: TextStyle(fontSize: 15, height: 1.6),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Transaksi',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Transaksi dilakukan langsung antara penjual dan pembeli, aplikasi hanya berperan sebagai platform perantara.\n'
                      '• Pembayaran dan pengiriman diatur dan disepakati oleh penjual dan pembeli.\n'
                      '• Aplikasi tidak bertanggung jawab atas kerugian akibat penipuan atau ketidaksesuaian barang.',
                      style: TextStyle(fontSize: 15, height: 1.6),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Pembatalan dan Pengembalian',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Kebijakan pembatalan atau pengembalian barang menjadi tanggung jawab masing-masing pihak (penjual dan pembeli).\n'
                      '• Aplikasi tidak menyediakan fasilitas pengembalian dana kecuali ditentukan lain.',
                      style: TextStyle(fontSize: 15, height: 1.6),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Privasi',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Data pribadi pengguna akan dijaga dan tidak disebarluaskan tanpa izin, kecuali diwajibkan oleh hukum.\n'
                      '• Informasi lebih lanjut tersedia di Kebijakan Privasi aplikasi.',
                      style: TextStyle(fontSize: 15, height: 1.6),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Tanggung Jawab dan Ganti Rugi',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Pengguna setuju untuk tidak menyalahgunakan aplikasi untuk kegiatan ilegal.\n'
                      '• Aplikasi tidak bertanggung jawab atas segala bentuk kerugian yang ditimbulkan akibat penggunaan layanan ini.',
                      style: TextStyle(fontSize: 15, height: 1.6),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Hak Kekayaan Intelektual',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Seluruh konten dalam aplikasi (logo, nama, desain, dll.) merupakan hak milik aplikasi, kecuali konten yang diunggah oleh pengguna.\n'
                      '• Pengguna tidak diperbolehkan menyalin, menyebarluaskan, atau memodifikasi konten tanpa izin.',
                      style: TextStyle(fontSize: 15, height: 1.6),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Perubahan Ketentuan',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Aplikasi berhak untuk mengubah ketentuan ini sewaktu-waktu tanpa pemberitahuan terlebih dahulu.\n'
                      '• Perubahan akan berlaku sejak dipublikasikan di aplikasi.',
                      style: TextStyle(fontSize: 15, height: 1.6),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Hukum yang Berlaku',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Syarat dan Ketentuan ini diatur oleh hukum Republik Indonesia.\n'
                      '• Sengketa yang timbul akan diselesaikan melalui musyawarah atau jalur hukum yang berlaku.',
                      style: TextStyle(fontSize: 15, height: 1.6),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back(); // kembali ke halaman sebelumnya
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Saya Setuju',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.neutral10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
