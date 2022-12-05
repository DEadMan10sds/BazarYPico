import 'package:bazar_y_pico/Models/Bazar.dart';
import 'package:bazar_y_pico/Services/bazaar_service.dart';

import '../components/bazar_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class BazaarsWidget extends StatefulWidget {
  const BazaarsWidget({Key? key}) : super(key: key);

  @override
  _BazaarsWidgetState createState() => _BazaarsWidgetState();
}

class _BazaarsWidgetState extends State<BazaarsWidget> {
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Bazar> allBazars;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  Future<bool> getAllBazaars() async {
    allBazars = await BazarService.getAllBazaars();
    print( 'BAAAAAAAAAAAAAAAAAAAAAAAAA ${allBazars[0].name}');
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryColor,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x39000000),
                        offset: Offset(0, 2),
                      )
                    ],
                  ),child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24, 40, 0, 0),
                      child: Image.asset(
                          'assets/images/LOGO4.png',
                          width: 160,
                          height: 50,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Bienvenido',
                              style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Raleway',
                                color:
                                FlutterFlowTheme.of(context).secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Bazar épico para gente épica',
                            style: FlutterFlowTheme.of(context).subtitle2.override(
                              fontFamily: 'Raleway',
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                      Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 10),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: const AlignmentDirectional(0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                                child: TextFormField(
                                  controller: textController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Raleway',
                                      color: Colors.black,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.search_sharp,
                                      color: Color(0xFF0F596B),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Raleway',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                              ),
                            ),
                            /*Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                text: 'Buscar',
                                options: FFButtonOptions(
                                  width: 100,
                                  height: 40,
                                  color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                    fontFamily: 'Raleway',
                                    color: Colors.white,
                                  ),
                                  elevation: 2,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
                Expanded(
                    child: FutureBuilder<bool>(
                      future: getAllBazaars(),
                      builder: (context, AsyncSnapshot<bool> snapshot)
                      {
                        if(snapshot.connectionState == ConnectionState.waiting)
                        {
                          return const Text('cargando bazares');
                        }
                        return ListView(
                            children:
                            List.generate(allBazars.length, (index) => BazarWidget(allBazars[index]))
                        );
                      },
                    )
                )
              ]
            ),
          ),
        ),
        onWillPop: () => Future.value(false)
    );
  }
}
