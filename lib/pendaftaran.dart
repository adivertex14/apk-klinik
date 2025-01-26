import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';
import 'package:flutter_klinik/widgets/mydrawer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'model_data.dart';

class Pendaftaran extends StatefulWidget {
  final int idUser;
  const Pendaftaran({super.key, required this.idUser});

  @override
  _PendaftaranState createState() => _PendaftaranState();
}

class _PendaftaranState extends State<Pendaftaran> {
  List<User> users = [];
  List<Klinik> kliniks = [];
  String? selectedUser;
  String? selectedKlinik;
  String? selectedJadwal;
  DateTime? selectedDate;
  final List<String> jadwalList = [
    'Pagi (Pkl. 08.00 s.d. 11.00 WIB)',
    'Siang (Pkl. 12.00 s.d. 16.00 WIB)',
    'Sore (Pkl. 16.30 s.d. 20.00 WIB)',
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final userResponse = await http.get(Uri.parse(
        'http://192.168.75.7/api_klinik/get_user.php?id_user=${widget.idUser}'));
    final klinikResponse = await http
        .get(Uri.parse('http://192.168.75.7/api_klinik/get_poliklinik.php'));

    if (userResponse.statusCode == 200 && klinikResponse.statusCode == 200) {
      setState(() {
        users = (json.decode(userResponse.body) as List)
            .map((data) => User.fromJson(data))
            .toList();
        kliniks = (json.decode(klinikResponse.body) as List)
            .map((data) => Klinik.fromJson(data))
            .toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> saveKunjungan() async {
    if (selectedUser != null &&
        selectedKlinik != null &&
        selectedDate != null &&
        selectedJadwal != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
      final response = await http.post(
        Uri.parse('http://192.168.75.7/api_klinik/simpan_kunjungan.php'),
        body: {
          'id_pasien': selectedUser,
          'id_poliklinik': selectedKlinik,
          'tgl_kunjungan': formattedDate,
          'jadwal_praktik': selectedJadwal,
        },
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        throw Exception('Failed to save data');
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        idUser: widget.idUser,
      ),
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: const Text(
          "Pendaftaran Pelayanan Poliklinik",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      drawer: MyCustomDrawer(
        idUser: widget.idUser,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Masukkan Data Anda",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "untuk Melakukan Pendaftaran",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              value: selectedUser,
              hint: const Text('Pilih Pasien'),
              onChanged: (value) {
                setState(() {
                  selectedUser = value;
                });
              },
              items: users.map((user) {
                return DropdownMenuItem(
                  value: user.id,
                  child: Text(user.namaUser),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              value: selectedKlinik,
              hint: const Text('Pilih Poliklinik'),
              onChanged: (value) {
                setState(() {
                  selectedKlinik = value;
                });
              },
              items: kliniks.map((klinik) {
                return DropdownMenuItem(
                  value: klinik.id,
                  child: Text(klinik.namaKlinik),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: selectedDate == null
                        ? "Tanggal Kunjungan"
                        : selectedDate.toString(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              value: selectedJadwal,
              hint: const Text('Pilih Jadwal Praktik'),
              onChanged: (value) {
                setState(() {
                  selectedJadwal = value;
                });
              },
              items: jadwalList.map((jadwal) {
                return DropdownMenuItem(
                  value: jadwal,
                  child: Text(jadwal),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 60,
              width: 400,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: saveKunjungan,
                child: const Text(
                  'SIMPAN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}





// ==================================================================================================
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_klinik/model_data.dart';
// import 'package:http/http.dart' as http;

// class Pendaftaran extends StatefulWidget {
//   const Pendaftaran({super.key});

//   @override
//   _PendaftaranState createState() => _PendaftaranState();
// }

// class _PendaftaranState extends State<Pendaftaran> {
//   List<User> users = [];
//   List<Klinik> kliniks = [];
//   String? selectedUser;
//   String? selectedKlinik;
//   String? selectedGender;
//   DateTime? selectedDate;

//   final List<String> jadwalList = [
//     'Pagi \t : Pkl. 08.00 s.d. 11.00 WIB',
//     'Siang \t: Pkl. 12.00 s.d. 16.00 WIB',
//     'Sore \t : Pkl. 16.30 s.d. 20.00 WIB',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final userResponse = await http
//         .get(Uri.parse('http://192.168.75.7/api_klinik/get_user.php'));
//     final klinikResponse = await http
//         .get(Uri.parse('http://192.168.75.7/api_klinik/get_poliklinik.php'));

//     if (userResponse.statusCode == 200 && klinikResponse.statusCode == 200) {
//       setState(() {
//         users = (json.decode(userResponse.body) as List)
//             .map((data) => User.fromJson(data))
//             .toList();
//         kliniks = (json.decode(klinikResponse.body) as List)
//             .map((data) => Klinik.fromJson(data))
//             .toList();
//       });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   Future<void> saveData() async {
//     if (selectedUser != null &&
//         selectedKlinik != null &&
//         selectedDate != null &&
//         selectedGender != null) {
//       final response = await http.post(
//         Uri.parse('http://192.168.75.7/api_klinik/add_kunjungan.php'),
//         body: {
//           'id_user': selectedUser,
//           'id_klinik': selectedKlinik,
//           'tanggal_kunjungan': selectedDate.toString(),
//           'jadwal_praktik': selectedGender,
//         },
//       );

//       if (response.statusCode == 200) {
//         final result = json.decode(response.body);
//         if (result['success']) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Data berhasil disimpan!')),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Gagal menyimpan data.')),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Terjadi kesalahan pada server.')),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Semua data harus diisi!')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 160, 223, 252),
//       appBar: AppBar(
//         title: const Text(
//           "Pendaftaran Poliklinik",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Text(
//                     "Isi Data di Bawah Ini",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                   Text(
//                     "untuk Melakukan Pendaftaran Poliklinik",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 30),
//             Form(
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     DropdownButtonFormField<String>(
//                       decoration: InputDecoration(
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       value: selectedUser,
//                       hint: const Text('Pilih Pasien'),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedUser = value;
//                         });
//                       },
//                       items: users.map((user) {
//                         return DropdownMenuItem(
//                           value: user.id,
//                           child: Text(user.namaUser),
//                         );
//                       }).toList(),
//                     ),
//                     const SizedBox(height: 20),
//                     DropdownButtonFormField<String>(
//                       decoration: InputDecoration(
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       value: selectedKlinik,
//                       hint: const Text('Pilih Poliklinik'),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedKlinik = value;
//                         });
//                       },
//                       items: kliniks.map((klinik) {
//                         return DropdownMenuItem(
//                           value: klinik.id,
//                           child: Text(klinik.namaKlinik),
//                         );
//                       }).toList(),
//                     ),
//                     const SizedBox(height: 20),
//                     GestureDetector(
//                       onTap: () => _selectDate(context),
//                       child: AbsorbPointer(
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             fillColor: Colors.white,
//                             filled: true,
//                             hintText: selectedDate == null
//                                 ? "Tanggal Kunjungan"
//                                 : "${selectedDate!.toLocal()}".split(' ')[0],
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     DropdownButtonFormField<String>(
//                       value: selectedGender,
//                       hint: const Text(
//                         "Jadwal Praktik",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       decoration: InputDecoration(
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       items: jadwalList.map((gender) {
//                         return DropdownMenuItem(
//                           value: gender,
//                           child: Text(gender),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           selectedGender = value;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: saveData,
//               child: const Text('SIMPAN'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
