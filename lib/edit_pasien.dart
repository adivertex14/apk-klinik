import 'package:flutter/material.dart';
import 'package:flutter_klinik/main_page.dart';
import 'package:flutter_klinik/pasien.dart';
import 'package:flutter_klinik/pencarian.dart';
import 'package:flutter_klinik/profil.dart';
import 'package:flutter_klinik/tentang_aplikasi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

enum JenisKelamin { lakiLaki, perempuan }

class EditPasien extends StatefulWidget {
  final Map listData;
  const EditPasien({super.key, required this.listData});

  @override
  State<EditPasien> createState() => _EditPasienState();
}

class _EditPasienState extends State<EditPasien> {
  int _selectedIndex = 0;
  JenisKelamin? _jenisKelamin;

  final formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _namaController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _hpController = TextEditingController();
  Future<bool> _ubah() async {
    try {
      final respon = await http.post(
        Uri.parse('http://192.168.1.4/api_klinik/edit_pasien.php'),
        body: {
          "id": _idController.text,
          "nama_pasien": _namaController.text,
          "jenis_kelamin": _jenisKelamin?.toString(), // Update if using gender
          "tgl_lahir": _tanggalController.text,
          "no_hp": _hpController.text,
        },
      );
      if (respon.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Failed to save data. Status code: ${respon.statusCode}');
      }
    } catch (error) {
      // Handle network or server errors here
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Terjadi kesalahan saat menyimpan data"),
        ),
      );
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      DateTime parsedDate = DateTime.parse(widget.listData['tgl_lahir']);
      _tanggalController.text = DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      print('Error parsing date: $e');
      _tanggalController.text = widget.listData['tgl_lahir'];
    }
  }

  void _selectDate(BuildContext context) async {
    // Default tanggal awal adalah hari ini
    DateTime initialDate = DateTime.now();

    // Cek apakah _tanggalController memiliki teks dan parse menjadi DateTime
    if (_tanggalController.text.isNotEmpty) {
      try {
        initialDate = DateFormat('dd-MM-yyyy').parse(_tanggalController.text);
      } catch (e) {
        print("Error parsing date: $e");
      }
    }

    // Pastikan initialDate tidak sebelum firstDate
    DateTime firstDate = DateTime(2000); // Tanggal minimum yang diizinkan
    if (initialDate.isBefore(firstDate)) {
      initialDate = firstDate;
    }

    // Tampilkan DatePicker
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2100),
    );

    // Jika tanggal dipilih, perbarui teks pada _tanggalController
    if (pickedDate != null) {
      print("Picked Date: ${pickedDate.toString()}"); // Debugging
      setState(() {
        _tanggalController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _idController.text = widget.listData['id'];
    _namaController.text = widget.listData['nama_pasien'];
    _jenisKelamin =
        widget.listData['jenis_kelamin'].toLowerCase() == 'laki-laki'
            ? JenisKelamin.lakiLaki
            : JenisKelamin.perempuan;

    // Hapus pengaturan ulang _tanggalController.text di sini
    _hpController.text = widget.listData['no_hp'];
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GNav(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            gap: 5,
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            backgroundColor: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.lightBlue,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Beranda',
                onPressed: () {
                  Fluttertoast.showToast(msg: "Anda Kembali ke Halaman Utama");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MainPage();
                  }));
                },
              ),
              GButton(
                icon: Icons.search,
                text: 'Pencarian',
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "Anda Beralih ke Halaman Pencarian");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Pencarian();
                  }));
                },
              ),
              GButton(
                icon: Icons.android_rounded,
                text: 'Tentang Aplikasi',
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "Anda Beralih ke Halaman Tentang Aplikasi");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const TentangAplikasi();
                  }));
                },
              ),
              GButton(
                icon: Icons.account_circle,
                text: 'Profil',
                onPressed: () {
                  Fluttertoast.showToast(msg: "Anda Beralih ke Halaman Profil");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Profil();
                  }));
                },
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Ubah Data Pasien"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  hintText: 'Nama Pasien',
                  hintStyle: const TextStyle(color: Colors.grey),
                  label: const Text("Nama Pasien"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama harus diisi";
                  } else {}
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<JenisKelamin>(
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                value: _jenisKelamin,
                onChanged: (JenisKelamin? newValue) {
                  setState(() {
                    _jenisKelamin = newValue;
                  });
                },
                items: JenisKelamin.values.map((JenisKelamin value) {
                  return DropdownMenuItem<JenisKelamin>(
                    value: value,
                    child: Text(value == JenisKelamin.lakiLaki
                        ? 'laki-laki'
                        : 'perempuan'),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Jenis kelamin harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _tanggalController,
                    decoration: InputDecoration(
                      labelText: "Tanggal Lahir",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Tanggal Lahir harus diisi";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _hpController,
                decoration: InputDecoration(
                  hintText: 'No HP',
                  hintStyle: const TextStyle(color: Colors.grey),
                  label: const Text("No HP"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "No HP harus diisi";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Container(
                height: 60,
                width: 400,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _ubah().then((value) {
                        if (value) {
                          const snackbar = SnackBar(
                            content: Text("Data berhasil diubah"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        } else {
                          const snackbar = SnackBar(
                            content: Text("Data gagal diubah"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      });
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Pasien()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  child: const Text(
                    "UBAH",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
