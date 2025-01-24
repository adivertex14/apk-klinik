import 'package:flutter/material.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';
import 'package:flutter_klinik/widgets/mydrawer.dart';
import 'package:intl/intl.dart';
import 'perjanjian_model.dart';

class PerjanjianPage extends StatefulWidget {
  final int idUser;
  final List<PerjanjianModel> perjanjianList;

  const PerjanjianPage(
      {super.key, required this.perjanjianList, required this.idUser});

  @override
  State<PerjanjianPage> createState() => _PerjanjianPageState();
}

class _PerjanjianPageState extends State<PerjanjianPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        idUser: widget.idUser,
      ),
      appBar: AppBar(
        title: const Text(
          "Data Kunjungan Pasien",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: MyCustomDrawer(
        idUser: widget.idUser,
      ),
      body: ListView.builder(
        itemCount: widget.perjanjianList.length,
        itemBuilder: (context, index) {
          final perjanjian = widget.perjanjianList[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama: ${perjanjian.namaPasien}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  'Usia: ${perjanjian.usia}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  'Jenis Kelamin: ${perjanjian.gender}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  'No HP: ${perjanjian.noHandphone}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  'Poliklinik: ${perjanjian.poliklinik}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  'Tanggal: ${DateFormat('dd-MM-yyyy').format(perjanjian.tanggalKunjungan)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  'Jam: ${perjanjian.jamKunjungan}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 5),
              ],
            ),
          );
        },
      ),
    );
  }
}
