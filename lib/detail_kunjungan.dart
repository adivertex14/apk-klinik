import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';
import 'package:flutter_klinik/widgets/mydrawer.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:share_plus/share_plus.dart';
import 'package:social_share/social_share.dart';

class DetailKunjungan extends StatefulWidget {
  final String namaPasien;
  final String namaKlinik;
  final String tanggalKunjungan;
  final String jadwalPraktik;
  final int idUser;

  const DetailKunjungan({
    super.key,
    required this.namaPasien,
    required this.namaKlinik,
    required this.tanggalKunjungan,
    required this.jadwalPraktik,
    required this.idUser,
  });

  @override
  State<DetailKunjungan> createState() => _DetailKunjunganState();
}

class _DetailKunjunganState extends State<DetailKunjungan> {
  Future<void> generatePDF(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Data Kunjungan Pasien",
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                "Nama Pasien:",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                widget.namaPasien,
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text(
                "Nama PoliKlinik:",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                widget.namaKlinik,
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text(
                "Tanggal Kunjungan:",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                widget.tanggalKunjungan,
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text(
                "Jadwal Praktik :",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                widget.jadwalPraktik,
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );

    final output = await FilePicker.platform.getDirectoryPath();
    if (output != null) {
      final file = File(
          "$output/kunjungan_${widget.namaPasien} ke ${widget.namaKlinik} tgl ${widget.tanggalKunjungan}.pdf");
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("PDF disimpan di: $output")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Penyimpanan dibatalkan")),
      );
    }
  }

  Future<void> shareToWhatsApp() async {
    String message = "Detail Kunjungan:\n\n"
        "Nama Pasien:\n   ${widget.namaPasien}\n\n"
        "Nama Klinik:\n   ${widget.namaKlinik}\n\n"
        "Tanggal Kunjungan:\n   ${widget.tanggalKunjungan}\n\n"
        "Jadwal Praktik:\n   ${widget.jadwalPraktik}";

    SocialShare.shareWhatsapp(message).then((data) {
      debugPrint("Pesan berhasil dikirim ke WhatsApp: $data");
    }).catchError((error) {
      debugPrint("Gagal mengirim pesan ke WhatsApp: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        idUser: widget.idUser,
      ),
      appBar: AppBar(
        title: const Text("Detail Kunjungan"),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: MyCustomDrawer(
        idUser: widget.idUser,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Data Kunjungan Pasien",
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            Text(
              "Klinik Sehati",
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(height: 30),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Pasien:",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.namaPasien,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    const SizedBox(height: 10),
                    Text("Nama PoliKlinik:",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent)),
                    const SizedBox(height: 5),
                    Text(
                      widget.namaKlinik,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    const SizedBox(height: 10),
                    Text("Tanggal Kunjungan :",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent)),
                    const SizedBox(height: 5),
                    Text(
                      widget.tanggalKunjungan,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    const SizedBox(height: 10),
                    Text("Jadwal Praktik:",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent)),
                    const SizedBox(height: 5),
                    Text(
                      widget.jadwalPraktik,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
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
                onPressed: () => generatePDF(context),
                child: const Text(
                  'Download',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
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
                onPressed: shareToWhatsApp,
                child: const Text(
                  'Bagikan ke WA',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
