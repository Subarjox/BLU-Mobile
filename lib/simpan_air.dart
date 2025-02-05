import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'berhasil_air.dart';
import 'package:http/http.dart' as http;

class SimpanAirWidget extends StatefulWidget {
  final String id_user;
  final dynamic tds;
  final dynamic ph;
  final dynamic turbidity;
  final String status;

  SimpanAirWidget({
    required this.id_user,
    required this.tds,
    required this.ph,
    required this.turbidity,
    required this.status,
  });

  @override
  State<SimpanAirWidget> createState() => _SimpanAirWidgetState();
}

class _SimpanAirWidgetState extends State<SimpanAirWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaAirController = TextEditingController();
  final TextEditingController deskripsiAirController = TextEditingController();

  Map<String, dynamic> dataku = {};

  Future<void> SimpanAir(BuildContext context) async {
    final String nama_air = namaAirController.text;
    final String deskripsi_air = deskripsiAirController.text;
    final String kualitas = widget.status;
    final String ph_air = widget.ph.toString();
    final String turbidity_air = widget.turbidity.toString();
    final String tds_air = widget.tds.toString();
    final String id_user = widget.id_user;

    if (nama_air.isEmpty || deskripsi_air.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tolong Isi Semua Data Dengan Benar')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost/flutter_blu/simpan_air.php'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'nama_air': nama_air,
          'deskripsi_air': deskripsi_air,
          'kualitas': kualitas,
          'ph_air': ph_air,
          'turbidity_air': turbidity_air,
          'tds_air': tds_air,
          'id_user': id_user,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Data Air Berhasil Disimpan')),
          );
          // Setelah berhasil, mungkin Anda ingin kembali ke halaman sebelumnya
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Error')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan pada server')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan. Coba lagi.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    bacanama();
  }

  Future<void> bacanama() async {
    String uri = "http://localhost/flutter_blu/deteksi.php?id_user=${widget.id_user}";
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          if (data is List && data.isNotEmpty) {
            dataku = data[0];
          } else {
            print("Format data tidak sesuai atau kosong.");
          }
        });
      } else {
        print("Gagal mengambil data, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: Color(0xFF57636C), size: 30),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Simpan Data Air',
                          style: TextStyle(
                            color: Color(0xFF),
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Data Air Akan Disimpan Dan Bisa Dilihat Kembali Di Daftar Air',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF54CDE4),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12),
                        GridView(
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
                            buildCard(widget.tds.toString() + 'PPM', 'TDS', Icons.flash_on, Colors.black,
                                backgroundColor: Color(0xFFF1F4F8)),
                            buildCard(widget.ph.toString(),'PH', Icons.bubble_chart_rounded, Colors.white,
                                backgroundColor: Color(0xFF54CDE4)),
                            buildCard(widget.turbidity.toString() +' NTU','NTU',Icons.coffee_rounded, Colors.white,
                                backgroundColor: Color(0xFF54CDE4)),
                            buildCard(widget.status,'Analisa AI',  FontAwesomeIcons.robot, Colors.black,
                                backgroundColor: Color(0xFFF1F4F8)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: namaAirController,
                        decoration: InputDecoration(
                          labelText: 'Nama Air',
                          hintText: 'Apa nama air ini?',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama air tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: deskripsiAirController,
                        decoration: InputDecoration(
                          labelText: 'Deskripsi Air',
                          hintText: 'Masukkan deskripsi air',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Deskripsi air tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            SimpanAir(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BerhasilAlatWidget(nama_air: namaAirController.text)), // Ganti dengan halaman yang sesuai
                              );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF54CDE4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Simpan Data Air',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(
    String title,
    String value,
    IconData icon,
    Color iconColor, {
    required Color backgroundColor,
  }) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 30),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
