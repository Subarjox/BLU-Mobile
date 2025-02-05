import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BerhasilAlatWidget extends StatefulWidget {
  final String id_device; // Mendeklarasikan id_user

  BerhasilAlatWidget({required this.id_device});

  @override
  State<BerhasilAlatWidget> createState() => _BerhasilAlatWidgetState();
}

class _BerhasilAlatWidgetState extends State<BerhasilAlatWidget> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 44),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Color(0x4C39D2C0),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0x4C39D2C0),
                        width: 4,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Color(0xFF39D2C0),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0x4C39D2C0),
                            width: 4,
                          ),
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),
                    ),
                  ).animate().fadeIn().move(begin: Offset(0.0, 40.0), end: Offset(0.0, 0.0)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 44),
                  child: Text(
                    'Berhasil Menghubungkan Alat',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Color(0xFF15161E),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn().scale().move(begin: Offset(0.0, 40.0), end: Offset(0.0, 0.0)),
                ),
                Divider(
                  height: 16,
                  thickness: 2,
                  color: Color(0xFFE5E7EB),
                ).animate().fadeIn().scale().move(begin: Offset(0.0, 40.0), end: Offset(0.0, 0.0)),
                Text(
                  'Dengan ID : ',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Color(0xFF606A85),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn().scale().move(begin: Offset(0.0, 40.0), end: Offset(0.0, 0.0)),
                Text(
                  widget.id_device,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Color(0xFF54CDE4),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn().scale().move(begin: Offset(0.0, 40.0), end: Offset(0.0, 0.0)),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF54CDE4),
                      minimumSize: Size(double.infinity, 44),
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                        fontFamily: 'Figtree',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).animate().fadeIn().scale().move(begin: Offset(0.0, 40.0), end: Offset(0.0, 0.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
