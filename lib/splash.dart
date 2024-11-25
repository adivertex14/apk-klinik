import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_klinik/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "KLINIK SEHATI",
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 250,
            // width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Assets/image/logo_klinik_sehati.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const Text(
            "Harta Sejati adalah Kesehatan\nBukan Emas dan Perak \n-Mahatma Gandhi-",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 100,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     InkWell(
          //       onTap: () => Navigator.of(context)
          //           .push(MaterialPageRoute(builder: (context) {
          //         return const Login();
          //       })),
          //       child: Container(
          //         padding: const EdgeInsets.symmetric(
          //           horizontal: 60,
          //           vertical: 20,
          //         ),
          //         decoration: const BoxDecoration(
          //           borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(20),
          //             topRight: Radius.circular(20),
          //           ),
          //           color: Colors.white,
          //         ),
          //         child: const Text(
          //           "Lanjutkan",
          //           style: TextStyle(
          //             fontSize: 20,
          //             fontWeight: FontWeight.w600,
          //             color: Colors.blue,
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
