import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'simpan_air.dart';
import 'package:http/http.dart' as http;

class KualitasAirWidget extends StatefulWidget {
  final String id_user; // Mendeklarasikan id_user

  KualitasAirWidget({required this.id_user});

  @override
  State<KualitasAirWidget> createState() => _KualitasAirWidgetState();
}

class _KualitasAirWidgetState extends State<KualitasAirWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> dataku = {}; // Menyimpan data dalam map

  // Fungsi untuk mengambil data dari API
  Future<void> bacanama() async {
    String uri = "http://localhost/flutter_blu/deteksi.php?id_user=${widget.id_user}";

    try {
      final respon = await http.get(Uri.parse(uri)); // Melakukan HTTP GET
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);

        setState(() {
          if (data is List && data.isNotEmpty) {
            dataku = data[0]; // Ambil elemen pertama
          } else {
            print("Format data tidak sesuai atau kosong.");
          }
        });
      } else {
        print("Gagal mengambil data, status code: ${respon.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    bacanama(); // Panggil fungsi untuk memuat data saat widget pertama kali dibuat
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF57636C),
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: Text(
                    'Check Kualitas Air',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF101213),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
                  child: Text(
                    'Lihat Hasil Deteksi Alat Mu Disini',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF54CDE4),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                  child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      // TDS Card
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.flash_on,
                                color: Color(0xFF101213),
                                size: 32,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                                child: Text(
                                  '${dataku['tds'] ?? 'N/A'} PPM',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF101213),
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                  'TDS',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // PH Card
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Color(0xFF54CDE4),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bubble_chart_rounded,
                                color: Colors.white,
                                size: 44,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                                child: Text(
                                  '${dataku['ph'] ?? 'N/A'}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                'PH',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // NTU Card
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Color(0xFF54CDE4),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.coffee_rounded,
                                color: Color(0xFF101213),
                                size: 32,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                                child: Text(
                                  '${dataku['turbidity'] ?? 'N/A'} NTU',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: const Color(0xFFFFFFFFF),
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                'Turbidity',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: const Color(0xFFFFFFFFF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Aman Card
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.robot,
                                color: Color(0xFF101213),
                                size: 32,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                                child: Text(
                                  '${dataku['hasil'] ?? 'N/A'}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF101213),
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                'Analisa AI',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        bacanama(); // Memanggil ulang fungsi untuk mendapatkan data baru
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF54CDE4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                      ),
                      child: Text(
                        '🔃 Deteksi Air',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                         Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SimpanAirWidget(
                                        id_user: widget.id_user,
                                        tds: dataku["tds"],
                                        ph: dataku["ph"],
                                        turbidity: dataku["turbidity"],
                                        status: dataku["hasil"],
                                        )),
                              ); // Memanggil ulang fungsi untuk mendapatkan data baru
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF54CDE4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 48, vertical: 12),
                      ),
                      child: Text(
                        'Simpan Data Air',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
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
