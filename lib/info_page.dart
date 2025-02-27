import 'package:flutter/material.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';
import 'package:flutter_klinik/widgets/mydrawer.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';

class InfoPage extends StatefulWidget {
  final int idUser;

  const InfoPage({super.key, required this.idUser});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        idUser: widget.idUser,
      ),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.blue,
        title: const Text(
          "Info Terbaru",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: MyCustomDrawer(
        idUser: widget.idUser,
      ),
      body: const AnimatedListView(
          duration: 100,
          extendedSpaceBetween: 30,
          spaceBetween: 10,
          children: [
            Card(
              elevation: 3,
              margin: EdgeInsets.only(bottom: 16.0),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0), // Memberikan jarak di dalam Card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Peningkatan Layanan Pasien",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "17 November 2024",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Klinik Sehati kini menyediakan layanan konsultasi online untuk mempermudah pasien yang memiliki keterbatasan waktu atau akses untuk datang langsung ke klinik.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 5),
            Card(
              elevation: 3,
              margin: EdgeInsets.only(bottom: 16.0),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0), // Memberikan jarak di dalam Card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jam Operasional Baru",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "15 November 2024",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Untuk memberikan kenyamanan dan fleksibilitas bagi pasien, Klinik Sehati kini memperpanjang jam operasional hingga pukul 22.00 WIB setiap hari, termasuk akhir pekan. Dengan jam baru ini, kami berharap dapat melayani lebih banyak pasien dengan lebih baik.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 5),
            Card(
              elevation: 3,
              margin: EdgeInsets.only(bottom: 16.0),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0), // Memberikan jarak di dalam Card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Layanan Vaksinasi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "10 November 2024",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Klinik Sehati kini menyediakan layanan vaksinasi lengkap untuk anak-anak dan dewasa. Layanan ini tersedia setiap hari dengan jadwal khusus pada akhir pekan untuk memudahkan pasien.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 5),
            Card(
              elevation: 3,
              margin: EdgeInsets.only(bottom: 16.0),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0), // Memberikan jarak di dalam Card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pemeriksaan Kesehatan Gratis",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "12 November 2024",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Dalam rangka Hari Kesehatan Nasional, Klinik Sehati memberikan layanan pemeriksaan kesehatan gratis untuk 50 pasien pertama setiap harinya hingga 20 November 2024.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 5),
            Card(
              elevation: 3,
              margin: EdgeInsets.only(bottom: 16.0),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0), // Memberikan jarak di dalam Card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pembukaan Cabang Baru",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "14 November 2024",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Kami dengan bangga mengumumkan pembukaan cabang baru Klinik Sehati di kawasan Jatinegara. Cabang ini dilengkapi fasilitas modern dan tenaga medis berpengalaman untuk melayani kebutuhan Anda.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 5),
            Card(
              elevation: 3,
              margin: EdgeInsets.only(bottom: 16.0),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0), // Memberikan jarak di dalam Card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Diskon Layanan Kesehatan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "16 November 2024",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Klinik Sehati menawarkan diskon 20% untuk layanan konsultasi dan pemeriksaan kesehatan selama bulan November. Segera manfaatkan kesempatan ini!",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 5),
            Card(
              elevation: 3,
              margin: EdgeInsets.only(bottom: 16.0),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0), // Memberikan jarak di dalam Card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Program Penyuluhan Kesehatan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "17 November 2024",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Klinik Sehati mengadakan program penyuluhan kesehatan gratis bagi masyarakat sekitar. Program ini mencakup edukasi tentang pola hidup sehat, pencegahan penyakit, dan pentingnya pemeriksaan rutin.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
          ]),
    );
  }
}
