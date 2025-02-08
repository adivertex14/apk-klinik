import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';
import 'package:flutter_klinik/widgets/mydrawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'kunjungan_model.dart';

class DataKunjungan extends StatefulWidget {
  final int idUser;
  final List<PerjanjianModel> perjanjianList;

  const DataKunjungan(
      {super.key, required this.idUser, required this.perjanjianList});

  @override
  _DataKunjunganState createState() => _DataKunjunganState();
}

class _DataKunjunganState extends State<DataKunjungan> {
  List<PerjanjianModel> perjanjianList = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 3), (x) => refreshNum);

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    fetchPerjanjian();
    _scrollController = ScrollController();
  }

  Future<void> fetchPerjanjian() async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.6/api_klinik/get_kunjungan.php?id_user=${widget.idUser}'));

    print("Response JSON: ${response.body}"); // Debugging

    if (response.statusCode == 200) {
      setState(() {
        final responseData = json.decode(response.body);
        if (responseData is List) {
          // Pastikan ini list
          perjanjianList = responseData
              .map((data) => PerjanjianModel.fromJson(data))
              .toList();
        } else {
          print("Error: Data yang diterima bukan list");
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    setState(() {
      refreshNum = Random().nextInt(100);
    });
    return completer.future.then<void>((_) {
      final scaffoldContext = _scaffoldKey.currentState?.context;
      if (scaffoldContext != null) {
        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
          SnackBar(
            content: const Text('Refresh complete'),
            action: SnackBarAction(
              label: 'RETRY',
              onPressed: () {
                _refreshIndicatorKey.currentState?.show();
              },
            ),
          ),
        );
      }
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
        title: const Text(
          "Data Kunjungan Pasien",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      drawer: MyCustomDrawer(
        idUser: widget.idUser,
      ),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: ListView.builder(
          padding: kMaterialListPadding,
          itemCount: perjanjianList.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            final perjanjian = perjanjianList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama Pasien",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Text(
                        perjanjian.namaPasien,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Divider(),
                      Text(
                        "Nama Poliklinik",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Text(
                        perjanjian.namaKlinik,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Divider(),
                      Text(
                        "Tanggal Kunjungan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Text(
                        perjanjian.tanggalKunjungan,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Divider(),
                      Text(
                        "Jadwal Praktik",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Text(
                        perjanjian.jadwalPraktik,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
