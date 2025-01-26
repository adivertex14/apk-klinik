import 'package:flutter/material.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';
import 'package:flutter_klinik/widgets/mydrawer.dart';

class TentangPage extends StatefulWidget {
  final int idUser;
  const TentangPage({super.key, required this.idUser});

  @override
  State<TentangPage> createState() => _TentangPageState();
}

class _TentangPageState extends State<TentangPage> {
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
            "Tentang Klinik",
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
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 300,
              // color: Colors.amberAccent,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Assets/image/klinik3d.png"),
                ),
              ),
            ),
            const Text(
              "Klinik Sehati",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Klinik Sehati adalah pusat pelayanan kesehatan yang didedikasikan untuk memberikan layanan kesehatan berkualitas kepada masyarakat. Berlokasi strategis di lingkungan yang mudah dijangkau, Klinik Sehati menawarkan berbagai fasilitas modern dan tenaga medis profesional untuk memastikan kenyamanan dan kepuasan pasien. Dengan motto Sehat Bersama, Bahagia Selalu, Klinik Sehati berkomitmen untuk menjaga kesehatan setiap individu melalui pelayanan yang ramah, cepat, dan akurat.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Sebagai klinik yang berorientasi pada pelayanan holistik, Klinik Sehati menyediakan berbagai layanan kesehatan, seperti konsultasi umum, layanan dokter spesialis, pemeriksaan laboratorium, imunisasi, dan perawatan kesehatan ibu dan anak. Selain itu, fasilitas penunjang seperti apotek lengkap dan ruang tunggu yang nyaman menjadikan pengalaman berobat lebih menyenangkan. Klinik ini juga aktif dalam kegiatan edukasi kesehatan untuk meningkatkan kesadaran masyarakat tentang pentingnya pencegahan penyakit.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Komitmen Klinik Sehati tidak hanya terletak pada layanan medis yang unggul, tetapi juga pada pendekatan yang humanis dan penuh empati. Setiap pasien diperlakukan dengan perhatian dan rasa hormat, menciptakan lingkungan yang mendukung proses penyembuhan. Dengan terus berinovasi dan mengikuti perkembangan teknologi kesehatan, Klinik Sehati bertekad menjadi mitra terpercaya dalam menjaga kesehatan masyarakat.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
          ],
        ));
  }
}
