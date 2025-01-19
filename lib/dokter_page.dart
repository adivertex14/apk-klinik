import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_klinik/main_page.dart';
import 'package:flutter_klinik/pasien/widgets/mydrawer.dart';
import 'package:flutter_klinik/pencarian.dart';
import 'package:flutter_klinik/tentang_aplikasi.dart';
import 'package:flutter_klinik/profil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DokterPage(),
    );
  }
}

class Dokter {
  final int id;
  final String namaDokter;
  final String namaKlinik;
  final String fotoDokter;

  Dokter({
    required this.id,
    required this.namaDokter,
    required this.namaKlinik,
    required this.fotoDokter,
  });

  factory Dokter.fromJson(Map<String, dynamic> json) {
    return Dokter(
      id: int.parse(json['id']),
      namaDokter: json['nama_dokter'],
      namaKlinik: json['nama_klinik'],
      fotoDokter: json['foto_dokter'],
    );
  }
}

class DokterPage extends StatefulWidget {
  const DokterPage({super.key});

  @override
  State<DokterPage> createState() => _DokterPageState();
}

class _DokterPageState extends State<DokterPage> {
  int _selectedIndex = 0;
  late Future<List<Dokter>> dokterList;

  @override
  void initState() {
    super.initState();
    dokterList = fetchDokter();
  }

  Future<List<Dokter>> fetchDokter() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.4/api_klinik/api_dokter2.php'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Dokter.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

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
      body: FutureBuilder<List<Dokter>>(
        future: dokterList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final dokter = snapshot.data![index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 37.5,
                          backgroundImage: NetworkImage(
                              'http://192.168.1.4/' + dokter.fotoDokter),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dokter.namaDokter,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Text(
                                dokter.namaKlinik,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
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
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Tidak ada data'));
          }
        },
      ),
    );
  }
}
