import 'package:flutter/material.dart';
import 'package:flutter_klinik/dokter_page.dart';
import 'package:flutter_klinik/form_daftar.dart';
import 'package:flutter_klinik/info_page.dart';

import 'package:flutter_klinik/mydrawer.dart';
import 'package:flutter_klinik/pasien.dart';

import 'package:flutter_klinik/perjanjian_page.dart';
import 'package:flutter_klinik/tentang_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      drawer: const MyCustomDrawer(),
      backgroundColor: const Color.fromARGB(255, 158, 221, 250),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // const SizedBox(height: 22),
              // Row dengan teks dan avatar
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hallo,',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Adi Supriatna",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 26,
                      backgroundImage: AssetImage("Assets/image/adi_pp.jpg"),
                    ),
                  )
                ],
              ),
              // const SizedBox(height: 2), // Jarak antara Row dan gambar
              // Gambar statis di bawah Row
              // Container(
              //   height: 150, // Sesuaikan tinggi gambar
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     image: const DecorationImage(
              //       image: AssetImage(
              //           'Assets/image/ban_umum.jpg'), // Sesuaikan path gambar
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),

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
                    InkWell(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "Anda Memilih Menu Pendaftaran");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const FormDaftar(
                            perjanjianList: [],
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
                              'Assets/image/register.png',
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Pendaftaran",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Fluttertoast.showToast(msg: "Anda Memilih Menu Dokter");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const DokterPage();
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
                          return const Pasien();
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
                          return const PerjanjianPage(
                            perjanjianList: [],
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
                          return const InfoPage();
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
                          return const TentangPage();
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



// onTap: () => Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                         return const Pendaftaran();
//                       })),
