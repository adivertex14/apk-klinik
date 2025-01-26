class User {
  final String id;
  final String namaUser;

  User({required this.id, required this.namaUser});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      namaUser: json['nama_pasien'],
    );
  }
}

class Klinik {
  final String id;
  final String namaKlinik;

  Klinik({required this.id, required this.namaKlinik});

  factory Klinik.fromJson(Map<String, dynamic> json) {
    return Klinik(
      id: json['id'],
      namaKlinik: json['nama_poliklinik'],
    );
  }
}
