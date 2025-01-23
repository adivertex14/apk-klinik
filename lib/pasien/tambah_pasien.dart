import 'package:flutter/material.dart';
import 'package:flutter_klinik/pasien/pasien.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

enum JenisKelamin {
  lakiLaki,
  perempuan,
}

class TambahPasien extends StatefulWidget {
  const TambahPasien({super.key});

  @override
  State<TambahPasien> createState() => _TambahPasienState();
}

class _TambahPasienState extends State<TambahPasien> {
  JenisKelamin? _jenisKelamin;

  final formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _hpController = TextEditingController();
  Future<bool> _simpan() async {
    try {
      final respon = await http.post(
        // Uri.parse('http://192.168.1.4/api_klinik/create_pasien.php'),
        Uri.parse('http://192.168.75.7/api_klinik/create_pasien.php'),
        body: {
          "nama_pasien": _namaController.text,
          "jenis_kelamin": _jenisKelamin == JenisKelamin.lakiLaki
              ? "laki-laki"
              : "perempuan",
          // Update if using gender
          "tgl_lahir": _tanggalController.text,
          "no_hp": _hpController.text,
        },
      );
      if (respon.statusCode == 200) {
        print({
          "nama_pasien": _namaController.text,
          "jenis_kelamin": _jenisKelamin == JenisKelamin.lakiLaki
              ? "laki-laki"
              : "perempuan",
          "tgl_lahir": _tanggalController.text,
          "no_hp": _hpController.text,
        });

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

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _tanggalController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
      appBar: AppBar(
        title: const Text("Tambah Data Pasien"),
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
                  print(_jenisKelamin);
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
              SizedBox(
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
                      _simpan().then((value) {
                        if (value) {
                          const snackbar = SnackBar(
                            content: Text("Data berhasil disimpan"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        } else {
                          const snackbar = SnackBar(
                            content: Text("Data gagal disimpan"),
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
                    "SIMPAN",
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
