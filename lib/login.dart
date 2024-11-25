import 'package:flutter/material.dart';
// import 'package:flutter_klinik/hal_awal.dart';
import 'package:flutter_klinik/main_page.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final snackbar = const SnackBar(
    content: Text(
      "Selamat, Anda Berhasil Masuk ke Aplikasi Klinik Sehati",
      textAlign: TextAlign.center,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: 500,
              // color: Colors.amberAccent,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Assets/image/logo_trans.png"),
                ),
              ),
            ),
            const Text(
              "Selamat Datang",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Fluttertoast.showToast(msg: "Selamat, Anda Berhasil Masuk");
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const MainPage();
                }));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: const Text(
                "Masuk",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
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