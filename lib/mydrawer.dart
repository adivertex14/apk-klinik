import 'package:flutter/material.dart';
import 'package:flutter_klinik/header_drawer.dart';
import 'package:flutter_klinik/kritik.dart';
import 'package:flutter_klinik/login.dart';
import 'package:flutter_klinik/main_page.dart';
import 'package:flutter_klinik/tentang_aplikasi.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const snackbar = SnackBar(
      content: Text(
        "Anda Telah Keluar dari Aplikasi Klinik Sehati",
        textAlign: TextAlign.center,
      ),
    );
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const MyHeaderDrawer(),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Beranda"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const MainPage();
                }));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.mail),
              title: const Text("Kritik dan Saran"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Kritik();
                }));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.android_rounded),
              title: const Text("Tentang Aplikasi"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const TentangAplikasi();
                }));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Konfirmasi"),
                        content: const Text("Apakah Anda Yakin Ingin Keluar ?"),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const Login();
                                }));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              },
                              child: const Text("Ya")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Tidak"))
                        ],
                      );
                    });
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return const Login();
                // }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
