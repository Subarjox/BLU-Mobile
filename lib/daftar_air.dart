import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'update_air.dart';
import 'lihat_air.dart';

class ListAirWidget extends StatefulWidget {
  final String id_user; // Mendeklarasikan id_user

  ListAirWidget({required this.id_user});

  @override
  State<ListAirWidget> createState() => _ListAirWidgetState();
}

class _ListAirWidgetState extends State<ListAirWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> airData = []; // List untuk menampung data air dari API

  // Fungsi untuk mengambil data dari API
Future<void> getAirData() async {
  String uri = "http://localhost/flutter_blu/tampil_air.php?id_user=${widget.id_user}";  // URL API untuk mengambil data air
  try {
    final response = await http.post(
      Uri.parse(uri),
      body: {'id_user': widget.id_user}, // Mengirimkan id_user untuk memfilter data
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);  // Meng-decode respons

      print('Response JSON: $responseData');  // Debugging log

      // Jika data adalah list yang berisi data air, kita langsung set ke airData
      if (responseData is List && responseData.isNotEmpty) {
        setState(() {
          airData = responseData;  // Menyimpan data ke airData
        });
      } else {
        print('Data tidak ditemukan atau format tidak sesuai');
      }
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}


  @override
  void initState() {
    super.initState();
    getAirData(); // Memanggil fungsi untuk mengambil data saat widget pertama kali dibangun
  }

  @override
  void dispose() {
    super.dispose();
  }

    void HapusAir(String a) async {
    //String uri = "http://10.0.2.2/apicrudflutter/insert.php";
    String uri = "http://localhost/flutter_blu/delete_air.php";
    http.post(Uri.parse(uri), body: {
      "id_air": a,
    });
    getAirData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF1F5F8),
        appBar: AppBar(
          backgroundColor: Color(0xFFF1F5F8),
          automaticallyImplyLeading: false,
          title: Text(
            'List Data Air',
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Color(0xFF0F1113),
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF54CDE4),
                  size: 24,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Row(
                  children: [
                    Text(
                      'List Data Air Yang Kamu Simpan',
                      style: TextStyle(
                        color: Color(0xFF54CDE4),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  itemCount: airData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                            showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.remove_red_eye),
                            title: Text('Lihat Data Air'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LihatAirWidget(
                                        id_air: airData[index]["id_air"],
                                        nama_air: airData[index]["nama_air"],
                                        deskripsi_air: airData[index]["deskripsi_air"],
                                        status: airData[index]["kualitas"],
                                        turbidity: airData[index]["turbidity_air"],
                                        ph: airData[index]["ph_air"],
                                        tds: airData[index]["tds_air"],
                                        id_user: widget.id_user)),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Ubah Data Air'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateAir(
                                        id_air: airData[index]["id_air"],
                                        nama_air: airData[index]["nama_air"],
                                        deskripsi_air: airData[index]["deskripsi_air"],
                                        status: airData[index]["kualitas"],
                                        turbidity: airData[index]["turbidity_air"],
                                        ph: airData[index]["ph_air"],
                                        tds: airData[index]["tds_air"],
                                        id_user: widget.id_user)),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Hapus Data Air'),
                            onTap: () {
                              HapusAir(airData[index]["id_air"].toString());
                              Navigator.of(context).pop(); // Tutup BottomSheet
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
                          // Navigasi ke detail jika diperlukan
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color(0x411D2429),
                                offset: Offset(0.0, 1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(8, 10, 4, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          airData[index]['nama_air'] ?? 'Nama Air',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            color: Color(0xFF0F1113),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 6, 8, 0),
                                          child: AutoSizeText(
                                            'ID Air: ' + airData[index]['id_air'].toString() ,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Color(0xFF54CDE4),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                      child: Icon(
                                        Icons.chevron_right_rounded,
                                        color: Color(0xFF54CDE4),
                                        size: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 4, 8),
                                      child: Text(
                                        'Tindak Lanjut',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Color(0xFF54CDE4),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
