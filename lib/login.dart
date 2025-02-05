import 'package:flutter/material.dart';
import 'package:blu_final/register.dart';
import 'package:blu_final/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Untuk JSON encoding dan decoding

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    // Pastikan email dan password tidak kosong
    if (email.isEmpty || password.isEmpty) {
      return;
    }

    // Kirim request POST ke API PHP
    final response = await http.post(
      Uri.parse('http://localhost/flutter_blu/login.php'), // Ganti dengan URL API PHP Anda
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        // Login berhasil
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login berhasil')),
        );
        // Pindah ke halaman lain jika diperlukan
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuWidget(id_user: data['id_user'],)),
        );

      } else {
        // Email atau password salah
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'])),
        );
      }
    } else {
      // Jika ada masalah dengan request
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan pada server')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 200,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Mulai Hidup Sehat Dengan Minum Air Sehat',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  width: 300,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Masukkan Email Anda...',
                      filled: true,
                      fillColor: const Color(0xFFD5D9DD),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  width: 300,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Masukkan Password Anda...',
                      filled: true,
                      fillColor: const Color(0xFFD5D9DD),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      login(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF54CDE4),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Inter Tight',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                child: Text(
                  'Belum Punya Akun? Daftar Disini',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
