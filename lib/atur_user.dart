import 'package:blu_final/update_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'dart:convert';

class atur_user extends StatefulWidget {
  final String id_user; // Mendeklarasikan id_user

  atur_user({required this.id_user});

  @override
  State<atur_user> createState() => _atur_userState();
}

class _atur_userState extends State<atur_user>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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

Future<String> hapus_alat(String idUser) async {
  String uri = "http://localhost/flutter_blu/hapus_alat.php";

  try {
    final response = await http.post(
      Uri.parse(uri),
      body: {"id_user": idUser},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['error'] != null) {
        return "Error: ${data['error']}"; // Mengembalikan pesan error
      } else {
        return "Success: ${data['message']}"; // Mengembalikan pesan sukses
      }
    } else {
      return "HTTP Error: ${response.statusCode}";
    }
  } catch (e) {
    return "Exception: $e"; // Mengembalikan pesan exception
  }
}


  @override
  Widget build(BuildContext context) {
    bacanama();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF57636C),
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF54CDE4),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF44A3B8),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.person_outlined,
                  color: Color(0xFFF9F9F9),
                  size: 70,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                dataku['nama'] ?? 'Nama tidak ditemukan',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF14181B),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                dataku['email'] ?? 'Email tidak ditemukan',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF57636C),
                ),
              ),
              const Divider(
                height: 44,
                thickness: 1,
                indent: 24,
                endIndent: 24,
                color: Color(0xFFE0E3E7),
              ),
              const SizedBox(height: 12),
              //hapus alat
             _buildProfileOption(
                icon: Icons.delete,
                text: 'Hapus Koneksi Alat',
                onPressed: () async {
                  // Memanggil fungsi hapus_alat dan menangkap pesan respons
                  final String message = await hapus_alat(widget.id_user.toString());

                  // Menampilkan snackbar berdasarkan pesan
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message), // Menampilkan pesan dari API
                      duration: const Duration(seconds: 3), // Durasi snackbar
                    ),
                  );
                  // Kembali ke halaman sebelumnya setelah snackbar
                  Navigator.of(context).pop();
                },
              ),

              _buildProfileOption(
                icon: Icons.settings_outlined,
                text: 'Pengaturan Akun',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateUserWidget(id_user: widget.id_user,),
                    ),
                  );
                },

              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyApp()), // Ganti dengan halaman yang sesuai
                              );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF54CDE4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(38),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 14, horizontal: 32),
                ),
                child: const Text(
                  'Log Out',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildProfileOption({
  required IconData icon,
  required String text,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE0E3E7),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF54CDE4),
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 16,
                  color: Color(0xFF14181B),
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
