import 'package:flutter/material.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';
import 'package:flutter_klinik/widgets/mydrawer.dart';

class TentangAplikasi extends StatefulWidget {
  final int idUser;
  const TentangAplikasi({super.key, required this.idUser});

  @override
  State<TentangAplikasi> createState() => _SettingState();
}

class _SettingState extends State<TentangAplikasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2,
        idUser: widget.idUser,
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
      drawer: MyCustomDrawer(
        idUser: widget.idUser,
      ),
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
