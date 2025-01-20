import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_klinik/pasien/edit_pasien.dart';

import 'package:flutter_klinik/pasien/tambah_pasien.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Pasien extends StatefulWidget {
  const Pasien({super.key});

  @override
  State<Pasien> createState() => _PasienState();
}

class _PasienState extends State<Pasien> {
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
          // .get(Uri.parse('http://192.168.1.4/api_klinik/read_pasien.php'));
          .get(Uri.parse('http://192.168.75.7/api_klinik/read_pasien.php'));
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

  Future _hapus(String nama) async {
    try {
      final respon = await http
          // .get(Uri.parse('http://192.168.1.4/api_klinik/read_pasien.php'));
          .post(Uri.parse('http://192.168.75.7/api_klinik/hapus_pasien.php'),
              body: {
            "nama_pasien": nama,
          });
      if (respon.statusCode == 200) {
        return true;
      }
      return false;
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
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
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
                                                "nama_pasien": _listdata[index]
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
                                            )),
                                      ));
                                },
                                child: const Icon(
                                  Icons.edit,
                                  size: 30,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return AlertDialog(
                                          content: const Text(
                                              "Anda ingin menghapus data pasien?"),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  _hapus(_listdata[index]
                                                          ['nama_pasien'])
                                                      .then((value) {
                                                    if (value) {
                                                      const snackbar = SnackBar(
                                                        content: Text(
                                                            "Data Pasien berhasil dihapus"),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackbar);
                                                    } else {
                                                      const snackbar = SnackBar(
                                                        content: Text(
                                                            "Data Pasien gagal dihapus"),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackbar);
                                                    }
                                                  });
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Pasien()),
                                                    (Route<dynamic> route) =>
                                                        false,
                                                  );
                                                },
                                                child: const Text("Hapus")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Tidak")),
                                          ],
                                        );
                                      }));
                                },
                                child: const Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.red,
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
