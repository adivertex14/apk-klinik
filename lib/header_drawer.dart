import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawer();
}

class _MyHeaderDrawer extends State<MyHeaderDrawer> {
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
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('Assets/image/adi_pp.jpg'),
                )),
          ),
          const Text(
            "Adi Supriatna",
            style: TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
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
