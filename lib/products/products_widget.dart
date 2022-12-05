import 'package:bazar_y_pico/Services/Auth_service.dart';
import 'package:bazar_y_pico/Services/ProductCRUD.dart';
import 'package:bazar_y_pico/Services/bazaar_service.dart';
import 'package:bazar_y_pico/add_products/add_products_widget.dart';
import 'package:bazar_y_pico/flutter_flow/flutter_flow_animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../Models/Bazar.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../locator.dart';
import '../components/product_widget.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({Key? key}) : super(key: key);

  @override
  _ProductsWidgetState createState() => _ProductsWidgetState();
}


class _ProductsWidgetState extends State<ProductsWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'buttonOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 250.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 250.ms,
          duration: 600.ms,
          begin: const Offset(0, 64),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 250.ms,
          duration: 600.ms,
          begin: 1,
          end: 1,
        ),
      ],
    ),
    'buttonOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 250.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 250.ms,
          duration: 600.ms,
          begin: const Offset(0, 64),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 250.ms,
          duration: 600.ms,
          begin: 1,
          end: 1,
        ),
      ],
    ),
  };

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Bazar _bazarData;
  final Stream<QuerySnapshot> productsList = ProductCRUD.getProductsByBazar(bazarID: locator<AuthService>().bazarSelected);

  Future<bool> getBazarData() async {

    _bazarData = await BazarService.getOne(bazarID: locator<AuthService>().bazarSelected);

    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: FutureBuilder<bool>(
              future: getBazarData(),
              builder: (context, AsyncSnapshot<bool> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) return const Text("Cargando bazar");
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      children: [
                        ClipRect(
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: 2,
                              sigmaY: 2,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tertiaryColor,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(
                                    _bazarData.img.toString(),
                                  ).image,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF1E2429), Color(0x001E2429)],
                              stops: [0, 1],
                              begin: AlignmentDirectional(0, 1),
                              end: AlignmentDirectional(0, -1),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _bazarData.name.toString(),
                                            style: FlutterFlowTheme.of(context)
                                                .title1
                                                .override(
                                              fontFamily: 'Raleway',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if(_bazarData.owner == locator<AuthService>().userID) Align(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB( 0, 10, 0, 20),
                        child: FFButtonWidget(
                          onPressed:  () async {
                            await Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    duration:
                                    const Duration(milliseconds: 300),
                                    reverseDuration:
                                    const Duration(milliseconds: 300),
                                    child: const AddProductsWidget()
                                )
                            );
                          },
                          text: 'Añadir producto',
                          options: FFButtonOptions(
                            width: 280,
                            height: 45,
                            color: const Color(0xFFF3485B),
                            textStyle: FlutterFlowTheme.of(context)
                                .subtitle2
                                .override(
                              fontFamily: 'Raleway',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            elevation: 3,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ).animateOnPageLoad(animationsMap['buttonOnPageLoadAnimation1']!),
                      ),
                    ),
                      StreamBuilder(
                          stream: productsList,
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting) return const Text('Cargando productos...');
                            return ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: //List.generate(100, (index) => const Text('data')),

                              snapshot.data!.docs.map((product) {
                                //return const Text('data');
                                return ProductWidgetState(product['name'], product['img'], product.reference.id, product['unitPrice'], product['stock'], product['owner']);
                              }).toList(),

                            );
                          }
                      ),
                    /*ListView(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: List.generate(6, (index) => const Text('data')),
                    ),*/
                  ],
                );
              }
            )
          ),
        ),
      ),
    );
  }
}
