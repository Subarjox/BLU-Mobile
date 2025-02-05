import 'package:flutter/material.dart';
import 'login_alat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import untuk jsonDecode

class KoneksiDeviceWidget extends StatefulWidget {
  final String id_user; // Mendeklarasikan id_user

  KoneksiDeviceWidget({required this.id_user});

  @override
  State<KoneksiDeviceWidget> createState() => _KoneksiDeviceWidgetState();
}

class _KoneksiDeviceWidgetState extends State<KoneksiDeviceWidget> {
  Map<String, dynamic> dataku = {}; // Menyimpan data dalam map

  // Fungsi untuk mengambil data dari API
Future<void> bacanama() async {
  String uri = "http://localhost/flutter_blu/status_alat.php?userId=${widget.id_user}";

  try {
    final respon = await http.get(Uri.parse(uri)); // Melakukan HTTP GET
    if (respon.statusCode == 200) {
      final data = jsonDecode(respon.body);  // Mengubah respons menjadi Map

      // Periksa apakah data ada dan id_device ditemukan
      if (data != null) {
        setState(() {
          if (data.containsKey('id_device') && data['id_device'] == null) {
            // Jika id_device null, beri status 'Belum Terhubung'
            dataku = {'status': 'Belum Terhubung'};
          } else if (data.containsKey('id_device') && data['id_device'] != null) {
            // Jika id_device ada, simpan id_device dan status
            dataku = {'id_device': data['id_device'], 'status': data['status']};
          } else {
            // Jika id_device tidak ada dalam data
            print("Data tidak valid: id_device tidak ditemukan");
            dataku = {'status': 'Data tidak valid'};
          }
        });
      } else {
        print("Data kosong atau tidak valid");
      }
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
    bacanama(); // Panggil fungsi bacanama saat widget pertama kali dibangun
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                    child: Text(
                      'Koneksi Alat',
                      style: TextStyle(
                        color: Color(0xFF101213),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
                    child: Text(
                      'Lihat Detail Alatmu Disini',
                      style: TextStyle(
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
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(), // Prevents scroll issue
                      children: [
                        Container(
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
                                  Icons.settings_remote_rounded,
                                  color: Colors.white,
                                  size: 44,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                                  child: Text(
                                    'ESP - ${dataku['id_device'] ?? 'Tidak Ditemukan'}', // Check status
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  'ID alat', // Show ID if available
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
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
                                  Icons.contactless_outlined,
                                  color: Color(0xFF101213),
                                  size: 32,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                                  child: Text(
                                    '${dataku['status'] ?? 'Tidak Ditemukan'}', // Show status if available
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF101213),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Status alat',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 70),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginAlatWidget(id_user: widget.id_user), // Ganti dengan halaman yang sesuai
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF54CDE4),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Koneksikan Alat',
                          style: TextStyle(
                            fontFamily: 'Inter Tight',
                            fontSize: 16,
                            color: Colors.white,
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
      ),
    );
  }
}
