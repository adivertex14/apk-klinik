import 'package:flutter/material.dart';

class Login2 extends StatelessWidget {
  const Login2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'Assets/image/back_klinik.png',
              fit: BoxFit.cover,
              width: double.infinity, // Memenuhi lebar layar
              height: double.infinity, // Memenuhi tinggi layar
            ),
          )
        ],
      ),
    );
  }
}
