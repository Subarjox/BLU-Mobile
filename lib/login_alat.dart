import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'berhasil_alat.dart';
import 'dart:convert';

class LoginAlatWidget extends StatefulWidget {
  final String id_user; // Mendeklarasikan id_user

  LoginAlatWidget({required this.id_user});

  @override
  State<LoginAlatWidget> createState() => _LoginAlatWidgetState();
}

class _LoginAlatWidgetState extends State<LoginAlatWidget> {
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();

  

  final FocusNode textFieldFocusNode1 = FocusNode();
  final FocusNode textFieldFocusNode2 = FocusNode();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
 
 Future<void> login_alat(BuildContext context) async {
  final String id_device = textController1.text;
  final String password = textController2.text;

  // Pastikan id_device dan password tidak kosong
  if (id_device.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('ID perangkat dan password tidak boleh kosong')),
    );
    return;
  }

  try {
    // Kirim request POST ke API PHP
    final response = await http.post(
      Uri.parse('http://localhost/flutter_blu/register_alat.php'), // Ganti dengan URL API PHP Anda
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'id_user': widget.id_user,
        'id_device': id_device,
        'password': password,
      },
    );

    // Cek status code dari response
    if (response.statusCode == 200) {
      print('Response body: ${response.body}'); // Tambahkan log di sini

      // Cek apakah response body berupa JSON yang valid
      try {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['message'] == 'ID Device berhasil ditambahkan') {
          // Login berhasil
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BerhasilAlatWidget(id_device: data['id_device'],)),
          );
        } else {
          // ID perangkat atau password salah
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Login gagal')),
          );
        }
      } catch (e) {
        // Jika gagal mendekodekan JSON
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan saat memproses data')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan pada server')),
      );
    }
  } catch (e) {
    // Menangani kesalahan lainnya, seperti masalah koneksi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Terjadi kesalahan: ${e.toString()}')),
    );
  }
  
}


  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textFieldFocusNode1.dispose();
    textFieldFocusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 458,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 25),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Icon(
                          Icons.settings_remote_rounded,
                          color: Color(0xFF54CDE4),
                          size: 55,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 45),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'Koneksikan Alat Mu Disini',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Container(
                          width: 300,
                          child: TextFormField(
                            controller: textController1,
                            focusNode: textFieldFocusNode1,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'ID Alat',
                              labelStyle: TextStyle(
                                fontFamily: 'Inter',
                                letterSpacing: 0.0,
                              ),
                              hintText: 'Masukan ID Alat Anda...',
                              hintStyle: TextStyle(
                                fontFamily: 'Inter',
                                letterSpacing: 0.0,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF54CDE4),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Color(0xFFD5D9DD),
                            ),
                            style: TextStyle(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Container(
                          width: 300,
                          child: TextFormField(
                            controller: textController2,
                            focusNode: textFieldFocusNode2,
                            autofocus: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.black,
                                letterSpacing: 0.0,
                              ),
                              hintText: 'Masukan Password Anda..',
                              hintStyle: TextStyle(
                                fontFamily: 'Inter',
                                letterSpacing: 0.0,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF54CDE4),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Color(0xFFD5D9DD),
                            ),
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.black,
                              letterSpacing: 0.0,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              login_alat(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF54CDE4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                              elevation: 0,
                            ),
                            child: Text(
                              'Hubungkan',
                              style: TextStyle(
                                fontFamily: 'Inter Tight',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      // Navigate to Register Page
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Text(
                              'Atau',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                letterSpacing: 0.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF54CDE4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          elevation: 0,
                        ),
                        child: Text(
                          'Kembali',
                          
                          style: TextStyle(
                            fontFamily: 'Inter Tight',
                            color: Colors.white,
                            letterSpacing: 0.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
