import 'package:flutter/material.dart';
import 'package:flutter_klinik/pasien/pasien.dart';
import 'package:flutter_klinik/widgets/bottomNavBar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

enum JenisKelamin { lakiLaki, perempuan }

class EditPasien extends StatefulWidget {
  final int idUser;
  final Map listData;
  const EditPasien({super.key, required this.listData, required this.idUser});

  @override
  State<EditPasien> createState() => _EditPasienState();
}

class _EditPasienState extends State<EditPasien> {
  JenisKelamin? _jenisKelamin;

  final formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _namaController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _hpController = TextEditingController();
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    _idController.text = widget.listData['id'] ?? '';
    _namaController.text = widget.listData['nama_pasien'];
    _jenisKelamin = widget.listData['jenis_kelamin'] == 'laki-laki'
        ? JenisKelamin.lakiLaki
        : JenisKelamin.perempuan;
    _tanggalController.text = widget.listData['tgl_lahir'];
    _hpController.text = widget.listData['no_hp'];

    // Debugging
    logger.i("Jenis Kelamin: $_jenisKelamin");
    logger.i("Tanggal Lahir: ${_tanggalController.text}");
  }

  Future<bool> _ubah() async {
    try {
      final dataToSend = {
        "id": _idController.text, // Tambahkan ID di sini
        "nama_pasien": _namaController.text,
        "jenis_kelamin":
            _jenisKelamin == JenisKelamin.lakiLaki ? 'laki-laki' : 'perempuan',
        "tgl_lahir": _tanggalController.text,
        "no_hp": _hpController.text,
      };

      logger.i("Data dikirim ke API: $dataToSend"); // Debugging

      final respon = await http.post(
        // Uri.parse('http://192.168.1.4/api_klinik/edit_pasien.php'),
        // Uri.parse('http://10.205.66.159/api_klinik/edit_pasien.php'),
        Uri.parse('http://192.168.1.6/api_klinik/edit_pasien.php'),
        body: dataToSend,
      );
      if (respon.statusCode == 200) {
        logger.i("Response dari API: ${respon.body}"); // Debugging
        return true;
      } else {
        throw Exception(
            'Failed to save data. Status code: ${respon.statusCode}');
      }
    } catch (error) {
      logger.i(error);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Terjadi kesalahan saat menyimpan data")),
        );
      }

      return false;
    }
  }

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
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
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        idUser: widget.idUser,
      ),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.blue,
        title: const Text(
          "Ubah Data Pasien",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
                  label: const Text("Nama Pasien"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Nama harus diisi" : null,
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
                items: JenisKelamin.values.map((value) {
                  return DropdownMenuItem<JenisKelamin>(
                    value: value,
                    child: Text(value == JenisKelamin.lakiLaki
                        ? 'Laki-laki'
                        : 'Perempuan'),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Jenis kelamin harus diisi' : null,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _tanggalController,
                    decoration: InputDecoration(
                      labelText: "Tanggal Lahir",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Tanggal Lahir harus diisi" : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _hpController,
                decoration: InputDecoration(
                  hintText: 'No HP',
                  label: const Text("No HP"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "No HP harus diisi";
                  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "No HP hanya boleh berisi angka";
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
                          if (mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                        } else {
                          const snackbar = SnackBar(
                            content: Text("Data gagal diubah"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      });
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Pasien(
                                  idUser: widget.idUser,
                                )),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  child: const Text(
                    "UBAH",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
