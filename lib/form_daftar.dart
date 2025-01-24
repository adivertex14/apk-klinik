// import 'package:flutter/material.dart';

// import 'package:flutter_klinik/widgets/bottomnavbar.dart';
// import 'package:flutter_klinik/widgets/mydrawer.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'perjanjian_page.dart';
// import 'perjanjian_model.dart';

// class FormDaftar extends StatefulWidget {
//   final List<PerjanjianModel> perjanjianList;

//   const FormDaftar({super.key, required this.perjanjianList});

//   @override
//   State<FormDaftar> createState() => _FormDaftarState();
// }

// class _FormDaftarState extends State<FormDaftar> {
//   var namaController = TextEditingController();
//   var usiaController = TextEditingController();
//   var noHpController = TextEditingController();
//   String? selectedPoliklinik;
//   String? selectedGender;
//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;

//   final List<String> poliklinikList = [
//     'Poliklinik Umum',
//     'Poliklinik Gigi',
//     'Poliklinik Anak',
//     'Poliklinik Paru',
//     'Poliklinik Mata',
//     'Poliklinik Dalam',
//   ];

//   final List<String> genderList = [
//     'Laki-Laki',
//     'Perempuan',
//   ];

//   @override
//   void dispose() {
//     namaController.dispose();
//     usiaController.dispose();
//     noHpController.dispose();
//     super.dispose();
//   }

//   Future<void> pickDate() async {
//     DateTime? date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//     if (date != null) {
//       setState(() {
//         selectedDate = date;
//       });
//     }
//   }

//   Future<void> pickTime() async {
//     TimeOfDay? time = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (time != null) {
//       setState(() {
//         selectedTime = time;
//       });
//     }
//   }

//   void submitData() {
//     if (namaController.text.isNotEmpty &&
//         usiaController.text.isNotEmpty &&
//         selectedGender != null &&
//         noHpController.text.isNotEmpty &&
//         selectedPoliklinik != null &&
//         selectedDate != null &&
//         selectedTime != null) {
//       final newPerjanjian = PerjanjianModel(
//         namaPasien: namaController.text,
//         usia: usiaController.text,
//         gender: selectedGender!,
//         noHandphone: noHpController.text,
//         poliklinik: selectedPoliklinik!,
//         tanggalKunjungan: selectedDate!,
//         jamKunjungan: selectedTime!.format(context),
//       );

//       // Buat salinan list yang dapat diubah
//       List<PerjanjianModel> updatedList = List.from(widget.perjanjianList);
//       updatedList.add(newPerjanjian);

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PerjanjianPage(perjanjianList: updatedList),
//         ),
//       );

//       // Membersihkan data inputan
//       namaController.clear();
//       usiaController.clear();
//       noHpController.clear();
//       setState(() {
//         selectedGender = null;
//         selectedPoliklinik = null;
//         selectedDate = null;
//         selectedTime = null;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: const BottomNavBar(selectedIndex: 0, idUser: ,),
//       appBar: AppBar(
//         title: const Text(
//           "Form Pendaftaran",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       drawer: const MyCustomDrawer(),
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: [
//           TextField(
//             controller: namaController,
//             decoration: InputDecoration(
//               hintText: 'Nama Pasien',
//               hintStyle: const TextStyle(
//                   color: Color.fromARGB(255, 221, 220, 220), fontSize: 20),
//               label: const Text(
//                 "Nama Pasien",
//                 style: TextStyle(fontSize: 18),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           DropdownButtonFormField<String>(
//             value: selectedGender,
//             hint: const Text(
//               "Jenis Kelamin",
//               style: TextStyle(fontSize: 18),
//             ),
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//             items: genderList.map((gender) {
//               return DropdownMenuItem(
//                 value: gender,
//                 child: Text(gender),
//               );
//             }).toList(),
//             onChanged: (value) {
//               setState(() {
//                 selectedGender = value;
//               });
//             },
//           ),
//           const SizedBox(height: 20),
//           TextField(
//             controller: usiaController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               hintText: 'Usia',
//               hintStyle:
//                   const TextStyle(color: Color.fromARGB(255, 221, 220, 220)),
//               label: const Text(
//                 "Usia",
//                 style: TextStyle(fontSize: 18),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextField(
//             controller: noHpController,
//             keyboardType: TextInputType.phone,
//             decoration: InputDecoration(
//               hintText: 'No Handphone',
//               hintStyle:
//                   const TextStyle(color: Color.fromARGB(255, 221, 220, 220)),
//               label: const Text(
//                 "No Handphone",
//                 style: TextStyle(fontSize: 18),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           DropdownButtonFormField<String>(
//             value: selectedPoliklinik,
//             hint: const Text(
//               "Pilih Poliklinik yang Dituju",
//               style: TextStyle(fontSize: 18),
//             ),
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//             items: poliklinikList.map((poli) {
//               return DropdownMenuItem(
//                 value: poli,
//                 child: Text(poli),
//               );
//             }).toList(),
//             onChanged: (value) {
//               setState(() {
//                 selectedPoliklinik = value;
//               });
//             },
//           ),
//           const SizedBox(height: 20),
//           ListTile(
//             title: Text(selectedDate == null
//                 ? 'Pilih Tanggal Kunjungan'
//                 : 'Tanggal: ${DateFormat('dd-MM-yyyy').format(selectedDate!)}'),
//             trailing: const Icon(Icons.calendar_today),
//             onTap: pickDate,
//           ),
//           const SizedBox(height: 20),
//           ListTile(
//             title: Text(selectedTime == null
//                 ? 'Pilih Jam Kunjungan'
//                 : 'Jam: ${selectedTime!.format(context)}'),
//             trailing: const Icon(Icons.access_time),
//             onTap: pickTime,
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               foregroundColor: Colors.white,
//               backgroundColor: Colors.red,
//             ),
//             onPressed: () {
//               showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: const Text("Konfirmasi"),
//                       content: const Text("Apakah Data Sudah Benar?"),
//                       actions: [
//                         ElevatedButton(
//                           onPressed: () {
//                             submitData();
//                             Fluttertoast.showToast(
//                                 msg: "Berhasil Menambah Data Kunjungan");
//                           },
//                           child: const Text("Ya"),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text("Tidak"),
//                         ),
//                       ],
//                     );
//                   });
//             },
//             child: const Text(
//               "SIMPAN",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
