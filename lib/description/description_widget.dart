import 'package:cloud_firestore/cloud_firestore.dart';

import '../Services/Auth_service.dart';
import '../Services/ProductCRUD.dart';
import '../flutter_flow/flutter_flow_count_controller.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../locator.dart';

class DescriptionWidget extends StatefulWidget {
  const DescriptionWidget({Key? key}) : super(key: key);

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int? countControllerValue;
  final Stream<DocumentSnapshot<Object?>> productsList = ProductCRUD.getProduct(prductID: locator<AuthService>().productSelected);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: productsList,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot)
      {
        if(snapshot.connectionState == ConnectionState.waiting) return const Text('Cargando...');
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 48,
              icon: const Icon(
                Icons.chevron_left_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Detalles de producto',
              style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Raleway',
                color: Colors.white,
              ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDBE2E7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: FlutterFlowExpandedImageView(
                                        image: Image.network(
                                          snapshot.data!['img'].toString(),
                                          fit: BoxFit.contain,
                                        ),
                                        allowRotation: false,
                                        tag: (snapshot.data!['name'] + 'image').toString(),
                                        useHeroAnimation: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: (snapshot.data!['name'] + 'hero').toString(),
                                  transitionOnUserGestures: true,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child: Image.network(
                                      snapshot.data!['img'].toString(),
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 20, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot.data!['name'].toString(),
                              style: FlutterFlowTheme.of(context).title2.override(
                                fontFamily: 'Raleway',
                                color: const Color(0xFF2C2C2C),
                              ),
                            ),
                            Text(
                              '\$${snapshot.data!['unitPrice'].toString()}',
                              style: FlutterFlowTheme.of(context).title2.override(
                                fontFamily: 'Raleway',
                                color: const Color(0xFFF3485B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '[Categoría]',
                              style:
                              FlutterFlowTheme.of(context).bodyText2.override(
                                fontFamily: 'Raleway',
                                color: const Color(0xFF2C2C2C),
                              ),
                            ),
                          ],
                        ),
                      ),*/
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'DESCRIPCIÓN',
                              style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                snapshot.data!['description'].toString(),
                                style:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                  fontFamily: 'Raleway',
                                  color: const Color(0xFF2C2C2C),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Cantidad',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                            Container(
                              width: 130,
                              height: 40,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(8),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  width: 1,
                                ),
                              ),
                              child: FlutterFlowCountController(
                                decrementIconBuilder: (enabled) => Icon(
                                  Icons.remove_rounded,
                                  color: enabled
                                      ? FlutterFlowTheme.of(context).primaryText
                                      : const Color(0xFF565656),
                                  size: 20,
                                ),
                                incrementIconBuilder: (enabled) => Icon(
                                  Icons.add_rounded,
                                  color: enabled
                                      ? FlutterFlowTheme.of(context).secondaryColor
                                      : const Color(0xFF565656),
                                  size: 20,
                                ),
                                countBuilder: (count) => Text(
                                  count.toString(),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                                count: countControllerValue ??= 0,
                                updateCount: (count) =>
                                    setState(() => countControllerValue = count),
                                stepSize: 1,
                              ),
                            ),
                          ],
                        ),
                      ),*/
                      Text('${snapshot.data!['owner'].toString()}=${locator<AuthService>().userID.toString()}'),
                      if(snapshot.data!['owner'].toString() == locator<AuthService>().userID.toString())
                        FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: 'Añadir al carrito',
                          options: FFButtonOptions(
                            width: 350,
                            height: 45,
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                              fontFamily: 'Raleway',
                              color: Colors.white,
                            ),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
