import 'package:flutter/material.dart';
import 'package:flutter_klinik/pasien/pasien.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_klinik/main_page.dart';
import 'package:flutter_klinik/pencarian.dart';
import 'package:flutter_klinik/profil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;

  const BottomNavBar({super.key, required this.selectedIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void _onTabChange(int index) {
    switch (index) {
      case 0:
        Fluttertoast.showToast(msg: "Anda Kembali ke Halaman Utama");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
        break;
      case 1:
        Fluttertoast.showToast(msg: "Anda Beralih ke Halaman Pencarian");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Pencarian()),
        );
        break;
      case 2:
        Fluttertoast.showToast(msg: "Anda Beralih ke Halaman Daftar Pasien");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Pasien()),
        );
        break;
      case 3:
        Fluttertoast.showToast(msg: "Anda Beralih ke Halaman Profil");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Profil()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            curve: Curves.easeOutExpo,
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 8), // Ruang lebih besar
            gap: 8, // Jarak antara ikon dan teks
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            backgroundColor: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor:
                Colors.lightBlueAccent, // Latar belakang lebih terang
            tabs: const [
              GButton(
                  icon: Icons.home,
                  text: 'Beranda',
                  textStyle: TextStyle(fontSize: 14)),
              GButton(
                  icon: Icons.search,
                  text: 'Pencarian',
                  textStyle: TextStyle(fontSize: 14)),
              GButton(
                  icon: Icons.person_add_alt_rounded,
                  text: 'Pasien',
                  textStyle: TextStyle(fontSize: 14)),
              GButton(
                  icon: Icons.account_circle,
                  text: 'Profil',
                  textStyle: TextStyle(fontSize: 14)),
            ],
            selectedIndex: widget.selectedIndex,
            onTabChange: _onTabChange,
          )),
    );
  }
}
