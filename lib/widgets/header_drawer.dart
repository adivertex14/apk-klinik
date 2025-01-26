import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHeaderDrawer extends StatefulWidget {
  final int idUser;
  const MyHeaderDrawer({super.key, required this.idUser});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawer();
}

class _MyHeaderDrawer extends State<MyHeaderDrawer> {
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
    return Container(
      color: Colors.blue[600],
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 150,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(fotoUrl),
                )),
          ),
          Text(
            namaLengkap,
            style: TextStyle(
                fontSize: 24, color: Colors.amber, fontWeight: FontWeight.bold),
          ),
          const Row(
            mainAxisSize: MainAxisSize.min, // Supaya elemen menyesuaikan isinya
            children: [
              Text(
                "Akun Terverifikasi",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(width: 8), // Memberikan jarak antara teks dan ikon
              Icon(
                Icons.check_circle,
                size: 22,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
