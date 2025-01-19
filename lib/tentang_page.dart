import 'package:flutter/material.dart';
import 'package:flutter_klinik/main_page.dart';
import 'package:flutter_klinik/pasien/widgets/mydrawer.dart';
import 'package:flutter_klinik/pencarian.dart';
import 'package:flutter_klinik/tentang_aplikasi.dart';
import 'package:flutter_klinik/profil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TentangPage extends StatefulWidget {
  const TentangPage({super.key});

  @override
  State<TentangPage> createState() => _TentangPageState();
}

class _TentangPageState extends State<TentangPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.4),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              gap: 5,
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              backgroundColor: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.lightBlue,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Beranda',
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "Anda Kembali ke Halaman Utama");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const MainPage();
                    }));
                  },
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Pencarian',
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "Anda Beralih ke Halaman Pencarian");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Pencarian();
                    }));
                  },
                ),
                GButton(
                  icon: Icons.android_rounded,
                  text: 'Tentang Aplikasi',
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "Anda Beralih ke Halaman Tentang Aplikasi");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const TentangAplikasi();
                    }));
                  },
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: 'Profil',
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "Anda Beralih ke Halaman Profil");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Profil();
                    }));
                  },
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text(
            "Tentang Klinik",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        drawer: const MyCustomDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 300,
              // color: Colors.amberAccent,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Assets/image/klinik_depan.jpg"),
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
