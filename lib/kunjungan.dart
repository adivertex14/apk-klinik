import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_klinik/widgets/bottomnavbar.dart';
import 'package:flutter_klinik/widgets/mydrawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'perjanjian_model.dart';

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
    final response = await http
        .get(Uri.parse('http://192.168.75.7/api_klinik/get_kunjungan.php'));

    if (response.statusCode == 200) {
      setState(() {
        final responseData = json.decode(response.body) as List;
        perjanjianList =
            responseData.map((data) => PerjanjianModel.fromJson(data)).toList();
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
                // child: ListTile(
                //   title: Text(perjanjian.namaPasien),
                //   subtitle: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('Poliklinik: ${perjanjian.namaKlinik}'),
                //       Text('Tanggal: ${perjanjian.tanggalKunjungan}'),
                //       Text('Jadwal: ${perjanjian.jadwalPraktik}'),
                //     ],
                //   ),
                // ),
              ),
            );
          },
        ),
      ),
    );
  }
}





// =========================================================================================
// import 'package:flutter/material.dart';
// import 'package:flutter_klinik/widgets/bottomnavbar.dart';
// import 'package:flutter_klinik/widgets/mydrawer.dart';
// // import 'package:intl/intl.dart';
// import 'perjanjian_model.dart';

// class PerjanjianPage extends StatefulWidget {
//   final int idUser;
//   final List<PerjanjianModel> perjanjianList;

//   const PerjanjianPage(
//       {super.key, required this.perjanjianList, required this.idUser});

//   @override
//   State<PerjanjianPage> createState() => _PerjanjianPageState();
// }

// class _PerjanjianPageState extends State<PerjanjianPage> {
//   // List _listdata = [];
//   // bool _isLoading = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: 0,
//         idUser: widget.idUser,
//       ),
//       appBar: AppBar(
//         title: const Text(
//           "Data Kunjungan Pasien",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       drawer: MyCustomDrawer(
//         idUser: widget.idUser,
//       ),
//       body: ListView.builder(
//           padding: EdgeInsets.all(10),
//           itemBuilder: ((context, index) {
//             return Padding(
//               padding: EdgeInsets.all(8),
//               child: Card(
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Nama Pasien",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blueAccent,
//                         ),
//                       ),
//                       const Text(
//                         "Nama Poliklinik",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blueAccent,
//                         ),
//                       ),
//                       const Text(
//                         "Tanggal Kunjungan",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blueAccent,
//                         ),
//                       ),
//                       const Text(
//                         "Jadwal Praktik",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blueAccent,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           })),
//     );
//   }
// }
