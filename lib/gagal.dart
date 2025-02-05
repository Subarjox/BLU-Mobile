 import 'package:flutter/material.dart';

class AksiGagalWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 16, 24, 12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Color(0x4CD23939),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0x4CD23939),
                        width: 4,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: Color(0xFFD23939),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0x4CD23939),
                            width: 4,
                          ),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                  child: Text(
                    'Aksi Gagal, Harap coba kembali',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Color(0xFF15161E),
                      fontSize: 22,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                  height: 16,
                  thickness: 2,
                  color: Color(0xFFE5E7EB),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF54CDE4),
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ].expand((e) => [e, SizedBox(height: 8)]).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
