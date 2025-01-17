import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_klinik/main_page.dart';
import 'package:flutter_klinik/register.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.4/api_klinik/login.php"),
        body: {
          "username": userController.text,
          "password": passwordController.text,
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Selamat Anda Berhasil Masuk ke Aplikasi Klinik Sehati",
                textAlign: TextAlign.center,
              ),
            ),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal terhubung ke server")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 130),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage("Assets/image/logo_trans.png"),
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
                        style: TextStyle(fontSize: 20),
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
                          return const RegisterPage();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent[400],
                      ),
                      child: const Text(
                        "BUAT AKUN",
                        style: TextStyle(fontSize: 20),
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
