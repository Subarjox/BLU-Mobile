import 'package:flutter/material.dart';

class PetunjukWidget extends StatefulWidget {
  const PetunjukWidget({super.key});

  @override
  State<PetunjukWidget> createState() => _PetunjukWidgetState();
}

class _PetunjukWidgetState extends State<PetunjukWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF0F1113),
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Petunjuk Penggunaan',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Color(0xFF0F1113),
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      _buildSection(
                        imagePath:
                            'assets/1.png',
                        title: 'ID dan Password Alat',
                        description:
                            'Anda akan mendapat ID_Alat dan Password alat melalui karyawan blu setelah Anda memiliki device blu.',
                      ),
                      _buildDivider(),
                      _buildSection(
                        imagePath: 'assets/2.png',
                        title: 'Menghubungkan Akun Dengan Alat',
                        description:
                            'Setelah Anda mendapat ID_alat dan passwordnya, Anda bisa menautkan akun blu Anda dengan device blu, di menu > detail alat > koneksikan alat.',
                      ),
                      _buildDivider(),
                      _buildSection(
                        imagePath: 'assets/2.png',
                        title: 'Memastikan Alat Terhubung',
                        description:
                            'Setelah Anda memasukkan ID_alat dan password dengan benar, koneksi alat akan menampilkan status dan ID alat Anda.',
                      ),
                      _buildDivider(),
                      _buildSection(
                        imagePath: 'assets/3.png',
                        title: 'Mulai Deteksi Air Minum Anda',
                        description:
                            'Mulai dengan memasukkan semua sensor ke dalam air yang ingin Anda deteksi, lihat hasil deteksinya di menu > deteksi air.',
                      ),
                      _buildDivider(),
                      _buildSection(
                        imagePath: 'assets/4.png',
                        title: 'Menyimpan Air Minum Beserta Data Deteksinya',
                        description:
                            'Terdapat button simpan air di menu deteksi air, cukup masuk ke menu simpan air, masukkan nama air dan deskripsinya. Lalu simpan datanya.',
                      ),
                      _buildDivider(),
                      _buildSection(
                        imagePath: 'assets/5.png',
                        title: 'Melihat Data Air Minum Yang Sudah Disimpan',
                        description:
                            'Data yang sebelumnya tersimpan bisa dilihat di menu > daftar air, semua air yang Anda simpan ada di sana.',
                      ),
                      _buildDivider(),
                      _buildSection(
                        imagePath: 'assets/6.png',
                        title: 'Mengatur Data Air Minum Yang Sudah Disimpan',
                        description:
                            'Anda dapat memanajemen daftar air Anda, baik merubah, melihat, ataupun menghapus list air yang Anda punya.',
                      ),
                      _buildDivider(),
                      _buildSection(
                        imagePath: 'assets/7.png',
                        title: 'Mengatur Akun Anda',
                        description:
                            'Di menu ini, Anda bisa merubah akun Anda. Baik nama, email, password, dan mereset tautan akun dan device Anda.',
                      ),
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

  Widget _buildSection({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF54CDE4),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            color: Color(0xFF0F1113),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 32,
      thickness: 1,
      color: Color(0xFFE0E3E7),
    );
  }
}
