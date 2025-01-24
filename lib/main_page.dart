import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_klinik/dokter_page.dart';
// import 'package:flutter_klinik/form_daftar.dart';
import 'package:flutter_klinik/info_page.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';

import 'package:flutter_klinik/widgets/mydrawer.dart';
import 'package:flutter_klinik/pasien/pasien.dart';

import 'package:flutter_klinik/perjanjian_page.dart';
import 'package:flutter_klinik/tentang_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  final int idUser;
  const MainPage({super.key, required this.idUser});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> imgList = [
    'Assets/image/ban_umum.jpg',
    'Assets/image/ban_anak.jpg',
    'Assets/image/ban_gigi.jpg',
    'Assets/image/ban_dalam.jpg',
  ];

  String namaLengkap = "";
  String fotoUrl = "";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.75.7/api_klinik/read_user.php'),
        body: {
          'id': widget.idUser.toString(),
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          namaLengkap = data['nama_lengkap'] ?? "Pengguna";
          fotoUrl = data['foto'] ?? "";
        });
      } else {
        print("Gagal mendapatkan data pengguna: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        idUser: widget.idUser,
      ),
      appBar: AppBar(
        title: const Text(
          "Beranda",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: MyCustomDrawer(idUser: widget.idUser),
      backgroundColor: const Color.fromARGB(255, 158, 221, 250),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // const SizedBox(height: 22),
              // Row dengan teks dan avatar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hallo,',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        namaLengkap,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: fotoUrl.isNotEmpty
                        ? CircleAvatar(
                            radius: 26,
                            backgroundImage: NetworkImage(fotoUrl),
                          )
                        : const CircleAvatar(
                            radius: 26,
                            backgroundImage: AssetImage("Assets/image/pp.png"),
                          ),
                  ),
                ],
              ),

              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.1,
                  enlargeCenterPage: true,
                ),
                items: imgList.map((item) {
                  return Container(
                    margin: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      child: Image.asset(
                        item,
                        fit: BoxFit.fitWidth,
                        width: 600.0,
                        // height: 100,
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 1),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     Fluttertoast.showToast(
                    //         msg: "Anda Memilih Menu Pendaftaran");
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) {
                    //       return const FormDaftar(
                    //         perjanjianList: [],
                    //       );
                    //     }));
                    //   },
                    //   child: Card(
                    //     elevation: 2,
                    //     shadowColor: Colors.green,
                    //     color: Colors.white,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     child: Column(
                    //       children: [
                    //         const Padding(padding: EdgeInsets.all(10)),
                    //         Image.asset(
                    //           'Assets/image/register.png',
                    //           width: 100,
                    //           fit: BoxFit.cover,
                    //         ),
                    //         const SizedBox(height: 10),
                    //         const Text(
                    //           "Pendaftaran",
                    //           style:
                    //               TextStyle(fontSize: 24, color: Colors.blue),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        Fluttertoast.showToast(msg: "Anda Memilih Menu Dokter");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DokterPage(
                            idUser: widget.idUser,
                          );
                        }));
                      },
                      child: Card(
                        elevation: 2,
                        shadowColor: Colors.green,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.all(10)),
                            Image.asset(
                              'Assets/image/doctor.png',
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Dokter",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Fluttertoast.showToast(msg: "Anda Memilih Menu Pasien");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Pasien(
                            idUser: widget.idUser,
                          );
                        }));
                      },
                      child: Card(
                        elevation: 2,
                        shadowColor: Colors.green,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.all(10)),
                            Image.asset(
                              'Assets/image/pasien.png',
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Pasien",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "Anda Memilih Menu Data Kunjungan Pasien");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PerjanjianPage(
                            idUser: widget.idUser,
                            perjanjianList: const [],
                          );
                        }));
                      },
                      child: Card(
                        elevation: 2,
                        shadowColor: Colors.green,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.all(10)),
                            Image.asset(
                              'Assets/image/perjanjian.png',
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Data Kunjungan",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "Anda Memilih Menu Info Terbaru");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return InfoPage(idUser: widget.idUser);
                        }));
                      },
                      child: Card(
                        elevation: 2,
                        shadowColor: Colors.green,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.all(10)),
                            Image.asset(
                              'Assets/image/info.png',
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Info Terbaru",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "Anda Memilih Menu Tentang Klinik");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return TentangPage(
                            idUser: widget.idUser,
                          );
                        }));
                      },
                      child: Card(
                        elevation: 2,
                        shadowColor: Colors.green,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.all(10)),
                            Image.asset(
                              'Assets/image/klinik.png',
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Tentang Klinik",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
