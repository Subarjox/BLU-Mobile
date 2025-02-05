import 'package:flutter/material.dart';
import 'package:blu_final/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: 'Halaman Registrasi',
       debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          body: LoginPage()),
    );
  }
}
