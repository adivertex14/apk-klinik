import 'package:flutter/material.dart';
import 'package:flutter_klinik/main_page.dart';
import 'package:flutter_klinik/pasien/widgets/mydrawer.dart';
import 'package:flutter_klinik/tentang_aplikasi.dart';
import 'package:flutter_klinik/profil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Pencarian extends StatefulWidget {
  const Pencarian({super.key});

  @override
  State<Pencarian> createState() => _PendaftaranState();
}

class _PendaftaranState extends State<Pencarian> {
  int _selectedIndex = 1;
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
              const GButton(
                icon: Icons.search,
                text: 'Pencarian',
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
        backgroundColor: Colors.white,
        title: const Text(
          "Pencarian",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const MyCustomDrawer(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              // controller: namaController,
              decoration: InputDecoration(
                hintText: 'Masukkan Data',
                hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 221, 220, 220), fontSize: 20),
                label: const Text(
                  "Masukkan Data yang Dicari",
                  style: TextStyle(fontSize: 18),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: const Row(
                mainAxisSize:
                    MainAxisSize.min, // Pastikan ukuran mengikuti konten
                children: [
                  Icon(
                    Icons.search, // Ikon loop/magnifying glass
                    size: 20, // Ukuran ikon
                  ),
                  SizedBox(width: 8), // Jarak antara ikon dan teks
                  Text(
                    "CARI",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
