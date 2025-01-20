import 'package:flutter/material.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_klinik/widgets/mydrawer.dart';

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
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
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
                              'http://192.168.75.7/' + dokter.fotoDokter),
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
