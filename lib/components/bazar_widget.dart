import 'package:bazar_y_pico/Services/Auth_service.dart';
import 'package:bazar_y_pico/index.dart';

import '../Models/Bazar.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../locator.dart';

/*class BazarWidget extends StatefulWidget {

  @override
  _BazarWidgetState createState() => _BazarWidgetState();
}*/

class BazarWidget extends StatelessWidget {
  BazarWidget(this._bazar);

  final Bazar _bazar;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        locator<AuthService>().bazarSelected = _bazar.id;
            await Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => const ProductsWidget(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
        child:
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                offset: Offset(4, 2), // Shadow position
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Hero(
                tag: 'productShoe',
                transitionOnUserGestures: true,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.network(
                    _bazar.img.toString(),
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5)
                    )
                ),
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),

                        child: Text(
                          _bazar.name.toString(),
                          style: FlutterFlowTheme.of(context).title3.override(
                            fontFamily: 'Raleway',
                            color: const Color(0xFF32546D),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
