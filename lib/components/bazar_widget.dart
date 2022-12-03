import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/random_data_util.dart' as random_data;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BazarWidget extends StatefulWidget {
  const BazarWidget({Key? key}) : super(key: key);

  @override
  _BazarWidgetState createState() => _BazarWidgetState();
}

class _BazarWidgetState extends State<BazarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Hero(
            tag: 'productShoe',
            transitionOnUserGestures: true,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.asset(
                'assets/images/image.jpg',
                width: double.infinity,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Text(
                      random_data.randomName(true, false).maybeHandleOverflow(
                            maxChars: 36,
                            replacement: '…',
                          ),
                      style: FlutterFlowTheme.of(context).title3.override(
                            fontFamily: 'Raleway',
                            color: Color(0xFF32546D),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
