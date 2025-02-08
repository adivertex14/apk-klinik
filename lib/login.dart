import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_klinik/main_page.dart';
import 'package:flutter_klinik/register.dart';
// import 'package:flutter_klinik/register.dart';
// import 'package:flutter_klinik/register2.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final logger = Logger();

  Future<void> _login() async {
    try {
      final response = await http.post(
        // Uri.parse("http://192.168.1.4/api_klinik/login.php"),
        // Uri.parse("http://10.205.66.159/api_klinik/login.php"),
        Uri.parse("http://192.168.1.6/api_klinik/login.php"),
        body: {
          "username": userController.text,
          "password": passwordController.text,
        },
      );

      logger.i("Response status: ${response.statusCode}");
      logger.i("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Selamat Anda Berhasil Masuk ke Aplikasi Klinik Sehati",
                  textAlign: TextAlign.center,
                ),
              ),
            );

            final idUser = int.parse(data['data']['id']);
            print("Data ID: ${data['data']['id']}");
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => MainPage(idUser: idUser),
              ),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data['message'])),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Gagal terhubung ke server")),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              height: 345,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("Assets/image/klinik3d.png"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Selamat Datang",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent[400],
              ),
            ),
            Text(
              "Silahkan Masuk dengan Akun Anda",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent[400],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.person_4),
                      labelText: 'Username',
                      hintText: 'Masukkan Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.lock),
                      labelText: 'Password',
                      hintText: 'Masukkan Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10)),
                    height: 60,
                    width: 400,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        "MASUK",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10)),
                    height: 60,
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const DaftarAkun();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent[400],
                      ),
                      child: const Text(
                        "BUAT AKUN",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
