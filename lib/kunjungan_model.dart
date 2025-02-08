class PerjanjianModel {
  final String id;
  final String namaPasien;
  final String namaKlinik;
  final String tanggalKunjungan;
  final String jadwalPraktik;

  PerjanjianModel({
    required this.id,
    required this.namaPasien,
    required this.namaKlinik,
    required this.tanggalKunjungan,
    required this.jadwalPraktik,
  });

  factory PerjanjianModel.fromJson(Map<String, dynamic> json) {
    return PerjanjianModel(
      id: json['id'].toString(),
      namaPasien: json['nama_pasien'] ?? '',
      namaKlinik: json['nama_poliklinik'] ?? '',
      tanggalKunjungan: json['tgl_kunjungan'] ?? '',
      jadwalPraktik: json['jadwal_praktik'] ?? '',
    );
  }
}
