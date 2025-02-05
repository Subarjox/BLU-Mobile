import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'koneksi_alat.dart';
import 'deteksi_air.dart';
import 'daftar_air.dart';
import 'petunjuk.dart';
import 'atur_user.dart';
import 'dart:convert';

class MenuWidget extends StatefulWidget {
  final String id_user; // Mendeklarasikan id_user

  MenuWidget({required this.id_user}); // Konstruktor menerima id_user

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  Map<String, dynamic> dataku = {}; // Menyimpan data dalam map

  Future<void> bacanama() async {
    String uri = "http://localhost/flutter_blu/menu.php?userId=${widget.id_user}"; // Menambahkan id_user ke URL

    try {
      final respon = await http.get(Uri.parse(uri)); // Melakukan HTTP GET
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          if (data.isNotEmpty) {
            dataku = data[0]; // Ambil data pengguna pertama
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
    bacanama();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 24,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: dataku.isNotEmpty
                      ? Text(
                          'Halo, ${dataku['nama']}', // Menampilkan nama pengguna
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF15161E),
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : CircularProgressIndicator(), // Menampilkan loading jika data belum diterima
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
                  child: Text(
                    'Ayo Mulai Minum Air Sehat Bersama Kami', // Additional message
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0xFF54CDE4),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 20), // Space between greeting and cards
                // Centering the card list
                Center(
                  child: Column(
                    children: [
                      // Card 1
                      InkWell(
                        onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        KoneksiDeviceWidget(id_user: widget.id_user)), // Ganti dengan halaman yang sesuai
                              );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of the screen width
                          height: 150, // Adjust height as needed
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFE5E7EB),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF1F4F8),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xFFE5E7EB),
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.settings_remote_rounded,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Detail Alat ',
                                      style: TextStyle(
                                        color: Color(0xFF15161E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Lihat Detail Alatmu Disini',
                                      style: TextStyle(
                                        color: Color(0xFF54CDE4),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFF54CDE4),
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Card 2
                      InkWell(
                        onTap: () {
                           Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PetunjukWidget()), // Ganti dengan halaman yang sesuai
                              );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of the screen width
                          height: 150, // Adjust height as needed
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFE5E7EB),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF1F4F8),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xFFE5E7EB),
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.menu_book,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Petunjuk Penggunaan',
                                      style: TextStyle(
                                        color: Color(0xFF15161E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Masih Bingung? Lihat Petunjuk Penggunaan Disini',
                                      style: TextStyle(
                                        color: Color(0xFF54CDE4),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFF54CDE4),
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                                            InkWell(
                        onTap: () {
                           Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        KualitasAirWidget(id_user: widget.id_user,)), // Ganti dengan halaman yang sesuai
                              );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of the screen width
                          height: 150, // Adjust height as needed
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFE5E7EB),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF1F4F8),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xFFE5E7EB),
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.remove_red_eye_sharp,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Hasil Deteksi',
                                      style: TextStyle(
                                        color: Color(0xFF15161E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Lihat Hasil Deteksi Alatmu Disini',
                                      style: TextStyle(
                                        color: Color(0xFF54CDE4),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFF54CDE4),
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                                            InkWell(
                        onTap: () {
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ListAirWidget(id_user: widget.id_user,)), // Ganti dengan halaman yang sesuai
                              );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of the screen width
                          height: 150, // Adjust height as needed
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFE5E7EB),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF1F4F8),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xFFE5E7EB),
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.format_list_numbered_rtl,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Daftar Air',
                                      style: TextStyle(
                                        color: Color(0xFF15161E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Lihat Daftar Air Yang Tersimpan',
                                      style: TextStyle(
                                        color: Color(0xFF54CDE4),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFF54CDE4),
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                                            InkWell(
                        onTap: () {
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        atur_user(id_user: widget.id_user,)), // Ganti dengan halaman yang sesuai
                              );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of the screen width
                          height: 150, // Adjust height as needed
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFE5E7EB),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF1F4F8),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xFFE5E7EB),
                                          width: 2,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Pengaturan Pengguna',
                                      style: TextStyle(
                                        color: Color(0xFF15161E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Lihat Pengaturan Pengguna',
                                      style: TextStyle(
                                        color: Color(0xFF54CDE4),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFF54CDE4),
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Add more cards here as needed
                    ],
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
