import 'package:flutter/material.dart';
import 'package:flutter_klinik/login.dart';
import 'package:http/http.dart' as http;

enum JenisKelamin {
  lakiLaki,
  perempuan,
}

class DaftarAkun extends StatefulWidget {
  const DaftarAkun({super.key});

  @override
  State<DaftarAkun> createState() => _DaftarAkunState();
}

class _DaftarAkunState extends State<DaftarAkun> {
  JenisKelamin? _jenisKelamin;

  final formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _alamatController = TextEditingController();
  final _hpController = TextEditingController();

  Future<bool> _simpan() async {
    try {
      final respon = await http.post(
// Uri.parse('http://192.168.1.4/api_klinik/create_pasien.php'),
        Uri.parse('http://192.168.75.7/api_klinik/register_user.php'),

        body: {
          "username": _userController.text,
          "password": _passwordController.text,
          "nama_lengkap": _namaController.text,
          "email": _emailController.text,
          "jenis_kelamin": _jenisKelamin == JenisKelamin.lakiLaki
              ? "laki-laki"
              : "perempuan",
          "alamat": _alamatController.text,
          "no_hp": _hpController.text,
        },
      );

      if (respon.statusCode == 200) {
        print({
          "username": _userController.text,
          "password": _passwordController.text,
          "nama_lengkap": _namaController.text,
          "email": _emailController.text,
          "jenis_kelamin": _jenisKelamin == JenisKelamin.lakiLaki
              ? "laki-laki"
              : "perempuan",
          "alamat": _alamatController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.amber,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.red,
                    child: Text(
                      "Tambah \nFoto \nProfil",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Form Registrasi Pengguna",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent[400],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _userController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Masukkan Username',
                    hintStyle: const TextStyle(color: Colors.grey),
                    label: const Text("Username"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username harus diisi";
                    } else {}

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Masukkan Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    label: const Text("Password"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password harus diisi";
                    } else {}

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Masukkan Nama Lengkap',
                    hintStyle: const TextStyle(color: Colors.grey),
                    label: const Text("Nama Lengkap"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama Lengkap harus diisi";
                    } else {}

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Masukkan Email',
                    hintStyle: const TextStyle(color: Colors.grey),
                    label: const Text("Email"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email Lengkap harus diisi";
                    } else {}

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<JenisKelamin>(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
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
                TextFormField(
                  controller: _alamatController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Masukkan Alamat',
                    hintStyle: const TextStyle(color: Colors.grey),
                    label: const Text("Alamat"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Alamat Lengkap harus diisi";
                    } else {}

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _hpController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Masukkan No HP',
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
                        _simpan().then((value) {
                          if (value) {
                            const snackbar = SnackBar(
                              content: Text("Pendaftaran Berhasil"),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            const snackbar = SnackBar(
                              content: Text("Pendaftaran Gagal"),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          }
                        });

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    child: const Text(
                      "SIMPAN",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:flutter_klinik/login.dart';

// // import 'dart.io';
// // import 'package:image_picker/image_picker.dart';

// enum JenisKelamin {
//   lakiLaki,
//   perempuan,
// }

// class DaftarAkun extends StatefulWidget {
//   const DaftarAkun({super.key});

//   @override
//   State<DaftarAkun> createState() => _DaftarAkunState();
// }

// class _DaftarAkunState extends State<DaftarAkun> {
//   JenisKelamin? _jenisKelamin;

//   final formKey = GlobalKey<FormState>();
//   final _userController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _namaController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _alamatController = TextEditingController();
//   final _hpController = TextEditingController();

//   Future<bool> _simpan() async {
//     try {
//       final respon = await http.post(
//         // Uri.parse('http://192.168.1.4/api_klinik/create_pasien.php'),
//         Uri.parse('http://192.168.75.7/api_klinik/register_user.php'),
//         body: {
//           "username": _userController.text,
//           "password": _passwordController.text,
//           "nama_lengkap": _namaController.text,
//           "email": _emailController.text,
//           "jenis_kelamin": _jenisKelamin == JenisKelamin.lakiLaki
//               ? "laki-laki"
//               : "perempuan",
//           "alamat": _alamatController.text,
//           "no_hp": _hpController.text,
//         },
//       );
//       if (respon.statusCode == 200) {
//         print({
//           "username": _userController.text,
//           "password": _passwordController.text,
//           "nama_lengkap": _namaController.text,
//           "email": _emailController.text,
//           "jenis_kelamin": _jenisKelamin == JenisKelamin.lakiLaki
//               ? "laki-laki"
//               : "perempuan",
//           "alamat": _alamatController.text,
//           "no_hp": _hpController.text,
//         });

//         return true;
//       } else {
//         throw Exception(
//             'Failed to save data. Status code: ${respon.statusCode}');
//       }
//     } catch (error) {
//       // Handle network or server errors here
//       print(error);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Terjadi kesalahan saat menyimpan data"),
//         ),
//       );
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue[100],
//       body: SingleChildScrollView(
//         child: Form(
//           key: formKey,
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const CircleAvatar(
//                   radius: 70,
//                   backgroundColor: Colors.amber,
//                   child: CircleAvatar(
//                     radius: 60,
//                     backgroundColor: Colors.red,
//                     child: Text(
//                       "Tambah \nFoto \nProfil",
//                       style: TextStyle(color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Form Registrasi Pengguna",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueAccent[400],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   controller: _userController,
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     hintText: 'Masukkan Username',
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     label: const Text("Username"),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Username harus diisi";
//                     } else {}
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   obscureText: true,
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     hintText: 'Masukkan Password',
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     label: const Text("Password"),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Password harus diisi";
//                     } else {}
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _namaController,
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     hintText: 'Masukkan Nama Lengkap',
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     label: const Text("Nama Lengkap"),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Nama Lengkap harus diisi";
//                     } else {}
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     hintText: 'Masukkan Email',
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     label: const Text("Email"),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Email Lengkap harus diisi";
//                     } else {}
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 DropdownButtonFormField<JenisKelamin>(
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     labelText: 'Jenis Kelamin',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   value: _jenisKelamin,
//                   onChanged: (JenisKelamin? newValue) {
//                     print(_jenisKelamin);
//                     setState(() {
//                       _jenisKelamin = newValue;
//                     });
//                   },
//                   items: JenisKelamin.values.map((JenisKelamin value) {
//                     return DropdownMenuItem<JenisKelamin>(
//                       value: value,
//                       child: Text(value == JenisKelamin.lakiLaki
//                           ? 'laki-laki'
//                           : 'perempuan'),
//                     );
//                   }).toList(),
//                   validator: (value) {
//                     if (value == null) {
//                       return 'Jenis kelamin harus diisi';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _alamatController,
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     hintText: 'Masukkan Alamat',
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     label: const Text("Alamat"),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Alamat Lengkap harus diisi";
//                     } else {}
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _hpController,
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     hintText: 'Masukkan No HP',
//                     hintStyle: const TextStyle(color: Colors.grey),
//                     label: const Text("No HP"),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "No HP harus diisi";
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   height: 60,
//                   width: 400,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white,
//                         backgroundColor: Colors.blueAccent,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20))),
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         _simpan().then((value) {
//                           if (value) {
//                             const snackbar = SnackBar(
//                               content: Text("Pendaftaran Berhasil"),
//                             );
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(snackbar);
//                           } else {
//                             const snackbar = SnackBar(
//                               content: Text("Pendaftaran Gagal"),
//                             );
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(snackbar);
//                           }
//                         });
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const Login()),
//                           (Route<dynamic> route) => false,
//                         );
//                       }
//                     },
//                     child: const Text(
//                       "SIMPAN",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
