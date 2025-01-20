import 'package:flutter/material.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';
import 'package:flutter_klinik/widgets/mydrawer.dart';

class Pencarian extends StatefulWidget {
  const Pencarian({super.key});

  @override
  State<Pencarian> createState() => _PendaftaranState();
}

class _PendaftaranState extends State<Pencarian> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
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
