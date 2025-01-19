import 'package:flutter/material.dart';
import 'package:flutter_klinik/main_page.dart';
import 'package:flutter_klinik/pasien/widgets/mydrawer.dart';
import 'package:flutter_klinik/pencarian.dart';
import 'package:flutter_klinik/profil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TentangAplikasi extends StatefulWidget {
  const TentangAplikasi({super.key});

  @override
  State<TentangAplikasi> createState() => _SettingState();
}

class _SettingState extends State<TentangAplikasi> {
  int _selectedIndex = 2;
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
              const GButton(
                icon: Icons.android_rounded,
                text: 'Tentang Aplikasi',
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
          "Tentang Aplikasi",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const MyCustomDrawer(),
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 100),
          Container(
            padding: const EdgeInsets.all(20),
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Assets/image/logo_klinik_sehati.png"),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "Aplikasi Klinik Sehati",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const Text(
            "Dibuat Oleh :",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Nama :",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Adi Supriatna",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "NIM :",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "22552011132",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Kelas :",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "TIF-K22",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Project :",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "UTS Pemrograman Mobile 2",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      )),
    );
  }
}
