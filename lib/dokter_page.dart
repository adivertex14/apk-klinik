import 'package:flutter/material.dart';
import 'package:flutter_klinik/main_page.dart';
import 'package:flutter_klinik/mydrawer.dart';
import 'package:flutter_klinik/pencarian.dart';
import 'package:flutter_klinik/tentang_aplikasi.dart';
import 'package:flutter_klinik/profil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DokterPage extends StatefulWidget {
  const DokterPage({super.key});

  @override
  State<DokterPage> createState() => _DokterPageState();
}

class _DokterPageState extends State<DokterPage> {
  int _selectedIndex = 0;
  final List<DataDokter> namaDokter = [
    DataDokter(
        nama: 'dr. Rizky Caranggono.MARS',
        poli: 'Poliklinik Umum',
        foto: 'Assets/image/dr_umum_rizky.jpg'),
    DataDokter(
        nama: 'dr. Meylin Purnamasari',
        poli: 'Poliklinik Umum',
        foto: 'Assets/image/dr_umum_meylin.jpg'),
    DataDokter(
        nama: 'dr. Sri Devi',
        poli: 'Poliklinik Umum',
        foto: 'Assets/image/dr_umum_sri.jpg'),
    DataDokter(
        nama: 'drg. Edwina Maharani',
        poli: 'Poliklinik Gigi',
        foto: 'Assets/image/dr_gigi_edwina.png'),
    DataDokter(
        nama: 'drg. Valentine Rosadi',
        poli: 'Poliklinik Gigi',
        foto: 'Assets/image/dr_gigi_valentine.png'),
    DataDokter(
        nama: 'drg. Welliam',
        poli: 'Poliklinik Gigi',
        foto: 'Assets/image/dr_gigi_weliam.png'),
    DataDokter(
        nama: 'dr. Andreas, Sp.PD',
        poli: 'Poliklinik Penyakit Dalam',
        foto: 'Assets/image/dr_dalam_andreas.png'),
    DataDokter(
        nama: 'dr. Mulfi Azmi, Sp.PD',
        poli: 'Poliklinik Penyakit Dalam',
        foto: 'Assets/image/dr_dalam_mulfi.png'),
    DataDokter(
        nama: 'dr. Nanda Putri R, Sp.PD',
        poli: 'Poliklinik Penyakit Dalam',
        foto: 'Assets/image/dr_dalam_nanda.png'),
    DataDokter(
        nama: 'dr. A. Azis S, Sp.A., M.Kes.,',
        poli: 'Poliklinik Anak',
        foto: 'Assets/image/dr_anak_azis.png'),
    DataDokter(
        nama: 'dr. Olga Vicetria P, Sp.A',
        poli: 'Poliklinik Anak',
        foto: 'Assets/image/dr_anak_olga.png'),
    DataDokter(
        nama: 'dr. Yulia Ismail, Sp.A., M.Kes.',
        poli: 'Poliklinik Anak',
        foto: 'Assets/image/dr_anak_yulia.png'),
    DataDokter(
        nama: 'dr. Deasy Wirasiti, Sp.P',
        poli: 'Poliklinik Paru',
        foto: 'Assets/image/dr_paru_deasy.png'),
    DataDokter(
        nama: 'dr. Evy Yuniawati, Sp.P',
        poli: 'Poliklinik Paru',
        foto: 'Assets/image/dr_paru_evi.jpg'),
    DataDokter(
        nama: 'dr. Andriafi Syah, Sp.M',
        poli: 'Poliklinik Mata',
        foto: 'Assets/image/dr_mata_andriafi.png'),
    DataDokter(
        nama: 'dr. Dissy Pramudita, Sp.M',
        poli: 'Poliklinik Mata',
        foto: 'Assets/image/dr_mata_dissy.png'),
    DataDokter(
        nama: 'dr. Maulina Zulkarnain, Sp.M',
        poli: 'Poliklinik Mata',
        foto: 'Assets/image/dr_mata_maulina.png'),
  ];
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
                  Fluttertoast.showToast(msg: "Anda Kembali ke Halaman Utama");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const TentangAplikasi();
                  }));
                },
              ),
              GButton(
                icon: Icons.account_circle,
                text: 'Profil',
                onPressed: () {
                  Fluttertoast.showToast(msg: "Anda Beralih ke Halaman Profil");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
        backgroundColor: Colors.blue,
        title: const Text(
          "Daftar Nama Dokter",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const MyCustomDrawer(),
      body: ListView(
        children: namaDokter.map((hasilMapDokter) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(hasilMapDokter.foto),
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hasilMapDokter.nama,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.blueAccent,
                              ),
                            ),
                            Text(hasilMapDokter.poli),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.info_rounded,
                            size: 35,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DataDokter {
  final String nama;
  final String poli;
  final String foto;

  DataDokter({
    required this.nama,
    required this.poli,
    required this.foto,
  });
}
