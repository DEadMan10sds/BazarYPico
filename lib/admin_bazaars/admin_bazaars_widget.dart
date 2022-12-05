import 'package:bazar_y_pico/Services/Auth_service.dart';
import 'package:bazar_y_pico/Services/bazaar_service.dart';
import 'package:bazar_y_pico/components/bazar_widget.dart';
import 'package:bazar_y_pico/index.dart';

import 'package:bazar_y_pico/locator.dart';
import '../Models/Bazar.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../main.dart';

class AdminBazaarsWidget extends StatefulWidget {
  const AdminBazaarsWidget({Key? key}) : super(key: key);

  @override
  _AdminBazaarsWidgetState createState() => _AdminBazaarsWidgetState();
}

class _AdminBazaarsWidgetState extends State<AdminBazaarsWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'buttonOnPageLoadAnimation': AnimationInfo(
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
  late List<Bazar> myBazaars = [];


  @override
  void initState() {
    super.initState();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  Future<bool> getMyBazaars() async {
    myBazaars = await BazarService.getMyBazaars(userID: locator<AuthService>().userID);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
              Navigator.pushReplacement(context, PageTransition(
                type: PageTransitionType.fade,
                duration:
                const Duration(milliseconds: 300),
                reverseDuration:
                const Duration(milliseconds: 300),
                child: const NavBarPage(
                    initialPage: 'Bazaars'),
              ));
            },
          ),
          title: Text(
            'Administrar bazares',
            style: FlutterFlowTheme.of(context).title2.override(
              fontFamily: 'Raleway',
              color: Colors.white,
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: FFButtonWidget(
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const AddBazaarWidget(),
                  ),
                  );
                },
                text: 'Crear nuevo bazar',
                icon: const Icon(
                  Icons.add,
                  size: 15,
                ),
                options: FFButtonOptions(
                  width: 350,
                  height: 45,
                  color: FlutterFlowTheme.of(context).secondaryColor,
                  textStyle: FlutterFlowTheme.of(context)
                      .subtitle2
                      .override(
                    fontFamily: 'Raleway',
                    color: FlutterFlowTheme.of(context).primaryBtnText,
                  ),
                  elevation: 3,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ).animateOnPageLoad(
                  animationsMap['buttonOnPageLoadAnimation']!),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child:
              FutureBuilder<bool>(
                  future: getMyBazaars(),
                  builder: (context, AsyncSnapshot<bool> snapshot)
                  {
                    if(snapshot.connectionState == ConnectionState.waiting) return const Text('Tus bazares se están cargando');
                    if(myBazaars.isNotEmpty)
                    {
                      return ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: 
                              List.generate(myBazaars.length, (index) => BazarWidget(myBazaars[index])),

                      );
                    }
                    return const Text('No tienes bazares');
                  }
              ),
            ),
          ],
        ),
    ), onWillPop: () => Future.value(false));
  }
}
