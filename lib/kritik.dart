import 'package:flutter/material.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';
import 'package:flutter_klinik/widgets/mydrawer.dart';

class Kritik extends StatefulWidget {
  final int idUser;
  const Kritik({super.key, required this.idUser});

  @override
  State<Kritik> createState() => _PendaftaranState();
}

class _PendaftaranState extends State<Kritik> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        idUser: widget.idUser,
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          "Kritik dan Saran",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: MyCustomDrawer(
        idUser: widget.idUser,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              // controller: namaController,
              maxLines:
                  null, // Membuat TextField mendukung teks multiline (tanpa batas baris)
              minLines: 3, // Tinggi awal TextField (3 baris)
              decoration: InputDecoration(
                hintText: 'Masukkan Kritik',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 221, 220, 220),
                  fontSize: 20,
                ),
                label: const Text(
                  "Kritik",
                  style: TextStyle(fontSize: 18),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20, // Menambah jarak di dalam TextField
                  horizontal: 16,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              // controller: namaController,
              maxLines:
                  null, // Membuat TextField mendukung teks multiline (tanpa batas baris)
              minLines: 3, // Tinggi awal TextField (3 baris)
              decoration: InputDecoration(
                hintText: 'Masukkan Saran',
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 221, 220, 220),
                  fontSize: 20,
                ),
                label: const Text(
                  "Saran",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20, // Menambah jarak di dalam TextField
                  horizontal: 16,
                ),
              ),
            ),
            const SizedBox(height: 150),
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
                  Text(
                    "KIRIM",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 8), // Jarak antara ikon dan teks
                  Icon(
                    Icons.send, // Ikon loop/magnifying glass
                    size: 20, // Ukuran ikon
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
