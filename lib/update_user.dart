import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateUserWidget extends StatefulWidget {
  final String id_user;
  const UpdateUserWidget({Key? key, required this.id_user}) : super(key: key);

  @override
  State<UpdateUserWidget> createState() => _UpdateUserWidgetState();
}

class _UpdateUserWidgetState extends State<UpdateUserWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> fetchUserData() async {
    final uri = "http://localhost/flutter_blu/menu.php?userId=${widget.id_user}";

    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          setState(() {
            _nameController.text = data[0]['nama'] ?? '';
            _emailController.text = data[0]['email'] ?? '';
            _passwordController.text = data[0]['password'] ?? '';
          });
        }
      } else {
        print("Failed to load data, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> updateUser(BuildContext context, int id_user) async {
  final String name = _nameController.text;
  final String email = _emailController.text;
  final String password = _passwordController.text;

  if (name.isEmpty || email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Nama, email, dan password tidak boleh kosong')),
    );
    return;
  }

  try {
    final response = await http.post(
      Uri.parse('http://localhost/flutter_blu/update_user.php'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'id_user': widget.id_user.toString(),
        'nama': name,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update User Berhasil')),
        );
        Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Error')),
        );
      }
    } else {
      print('Response status: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan pada server')),
      );
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Terjadi kesalahan. Coba lagi.')),
    );
  }
}

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor:const Color(0xFFE5E5E5),
        appBar: AppBar(
          backgroundColor:const Color(0xFFFFFFFF),
          title: const Text('Ubah Akun'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      hintText: 'Masukkan Nama Anda...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Masukkan Email Anda...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      } else if (!value.contains('@')) {
                        return 'Masukan Format Email Yang Tepat';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Masukkan Password Anda...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      } else if (value.length < 6) {
                        return 'Password harus terdiri dari minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  Center(
                   child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Pastikan widget.id_user adalah int
                          final int userId = int.tryParse(widget.id_user.toString()) ?? 0;

                          // Update user
                          updateUser(context, userId);

                          // Tampilkan Snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Akun berhasil diubah')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF54CDE4),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Ubah',
                        style: TextStyle(
                          color: Colors.white, // Warna teks
                          fontSize: 16,        // Ukuran font
                          fontWeight: FontWeight.bold, // Ketebalan font
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
