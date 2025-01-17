import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_klinik/edit_pasien.dart';
import 'package:flutter_klinik/main_page.dart';
import 'package:flutter_klinik/pencarian.dart';
import 'package:flutter_klinik/profil.dart';
import 'package:flutter_klinik/tambah_pasien.dart';
import 'package:flutter_klinik/tentang_aplikasi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Pasien extends StatefulWidget {
  const Pasien({super.key});

  @override
  State<Pasien> createState() => _PasienState();
}

class _PasienState extends State<Pasien> {
  int _selectedIndex = 0;

  String formatTanggal(String tanggal) {
    try {
      DateTime parsedDate = DateTime.parse(tanggal); // Parsing tanggal
      return DateFormat('dd-MM-yyyy').format(parsedDate); // Format ulang
    } catch (e) {
      return tanggal; // Jika parsing gagal, tampilkan data asli
    }
  }

  List _listdata = [];
  bool _isLoading = true;

  Future _getData() async {
    try {
      final respon = await http
          .get(Uri.parse('http://192.168.1.4/api_klinik/read_pasien.php'));
      if (respon.statusCode == 200) {
        // print(respon.body);
        final data = jsonDecode(respon.body);
        setState(() {
          _listdata = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getData();

    // print(_listdata);
    super.initState();
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
        title: const Text(
          "Daftar Pasien Terdaftar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Nama Pasien",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  Text(
                                    _listdata[index]['nama_pasien'],
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 140,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => EditPasien(
                                                listData: {
                                                  "id": _listdata[index]['id'],
                                                  "nama_pasien":
                                                      _listdata[index]
                                                          ['nama_pasien'],
                                                  "jenis_kelamin":
                                                      _listdata[index]
                                                          ['jenis_kelamin'],
                                                  "tgl_lahir": formatTanggal(
                                                      _listdata[index]
                                                          ['tgl_lahir']),
                                                  "no_hp": _listdata[index]
                                                      ['no_hp'],
                                                },
                                              ))));
                                },
                                child: const Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.blueAccent,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          const Text(
                            "Jenis Kelamin",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            _listdata[index]['jenis_kelamin'],
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Divider(),
                          const Text(
                            "Tanggal Lahir",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            formatTanggal(_listdata[index]['tgl_lahir']),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Divider(),
                          const Text(
                            "No Handphone",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            _listdata[index]['no_hp'],
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })),
      floatingActionButton: SizedBox(
        width: 200, // Lebar tombol
        height: 60, // Tinggi tombol
        child: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const TambahPasien())));
          },
          child: const Text(
            "Tambah Pasien",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
