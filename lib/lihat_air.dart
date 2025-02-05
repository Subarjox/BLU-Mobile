import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LihatAirWidget extends StatefulWidget {
  final String id_user;
  final dynamic id_air;
  final dynamic tds;
  final dynamic ph;
  final dynamic turbidity;
  final String status;
  final String nama_air;
  final String deskripsi_air;

  LihatAirWidget({
    required this.id_user,
    required this.id_air,
    required this.tds,
    required this.ph,
    required this.turbidity,
    required this.status,
    required this.nama_air,
    required this.deskripsi_air,
  });

  @override
  State<LihatAirWidget> createState() => _LihatAirWidgetState();
}

class _LihatAirWidgetState extends State<LihatAirWidget> {
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
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF57636C),
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: Text(
                    'Data Air',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF101213),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
                  child: Text(
                    'Lihat Air Yang Kamu Simpan',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF54CDE4),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                  child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      _buildDataCard(
                        icon: Icons.flash_on,
                        label: widget.tds.toString(),
                        description: 'TDS',
                        backgroundColor: Color(0xFFF1F4F8),
                        textColor: Color(0xFF101213),
                      ),
                      _buildDataCard(
                        icon: Icons.bubble_chart_rounded,
                        label: widget.ph.toString(),
                        description: 'PH',
                        backgroundColor: Color(0xFF54CDE4),
                        textColor: Colors.white,
                      ),
                      _buildDataCard(
                        icon: Icons.coffee_rounded,
                        label: widget.turbidity.toString(),
                        description: 'Turbidity',
                        backgroundColor: Color(0xFF54CDE4),
                        textColor: Color(0xFF101213),
                      ),
                      _buildDataCard(
                        icon: FontAwesomeIcons.robot,
                        label: widget.status,
                        description: 'Analisa AI',
                        backgroundColor: Color(0xFFF1F4F8),
                        textColor: Color(0xFF101213),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 40, 0, 20),
                  child: Text(
                    widget.nama_air,
                    style: TextStyle(
                      fontFamily: 'Inter Tight',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: Text(
                    widget.deskripsi_air,
                    textAlign: TextAlign.justify,
                    maxLines: 10,
                    style: TextStyle(
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataCard({
    required IconData icon,
    required String label,
    required String description,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 160,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: textColor,
              size: 32,
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
