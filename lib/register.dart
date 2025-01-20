import 'package:flutter/material.dart';
import 'package:flutter_klinik/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> registerUser(String username, String password) async {
    final url = Uri.parse('http://192.168.75.7/api_klinik/register.php');
    try {
      final response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Selamat Anda Telah Berhasil Mendaftar",
                textAlign: TextAlign.center,
              ),
            ),
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const Login();
          }));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message'] ?? 'Pendaftaran gagal!'),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Terjadi kesalahan saat menghubungkan ke server."),
        ),
      );
    }
  }

  final snackbar = const SnackBar(
    content: Text(
      "Selamat Anda Telah Berhasil Mendaftar",
      textAlign: TextAlign.center,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              height: 300,
              // color: Colors.amberAccent,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage("Assets/image/logo_trans.png"),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Hallo...",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent[400],
              ),
            ),
            Text(
              "Daftarkan Akun Pengguna Anda di Sini",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent[400],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: const TextStyle(fontSize: 20),
                      hintText: 'Masukkan Username',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(width: 5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(fontSize: 20),
                      hintText: 'Masukkan Password',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(width: 5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10)),
                    height: 60,
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () {
                        final username = _usernameController.text;
                        final password = _passwordController.text;

                        if (username.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Anda Belum Mengisi Data!"),
                            ),
                          );
                        } else {
                          registerUser(username, password);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent[400],
                      ),
                      child: const Text(
                        "BUAT AKUN",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10)),
                    height: 60,
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Login();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red[400],
                      ),
                      child: const Text(
                        "SUDAH MENDAFTAR",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}






// ElevatedButton(
//               onPressed: () {
//                 Fluttertoast.showToast(msg: "Selamat, Anda Berhasil Masuk");
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return const MainPage();
//                 }));
//               },
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.red,
//               ),
//               child: const Text(
//                 "Masuk",
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//             )