import 'package:bazar_y_pico/Services/Auth_service.dart';
import 'package:bazar_y_pico/Services/users_service.dart';
import 'package:bazar_y_pico/locator.dart';

import '../Models/User.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasContainerTriggered = false;
  //var _user:name = await UsersCrud.getUser(userID: locator<AuthService>().userID)
  final animationsMap = {
    'containerOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: false,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 350.ms,
          begin: const Offset(-40, 0),
          end: const Offset(0, 0),
        ),
      ],
    ),
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

  //Metodo para obtener el nombre del usuario
  Future<String> getName() => UsersCrud.getUserName(userID: locator<AuthService>().userID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: const Color(0xFF32546D),
        automaticallyImplyLeading: false,
        title: Text(
          'Mi cuenta',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Raleway',
                color: Colors.white,
              ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: FutureBuilder<String>(
                future: getName(),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  return Text(
                    'Bienvenid@ ${snapshot.hasData ? snapshot.data : ''}',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).subtitle1.override(
                      fontFamily: 'Poppins',
                      color: const Color(0xFFF3485B),
                      fontSize: 22,
                    ),
                  );
                }
              )
              /*Text(
                'Bienvenido ',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).subtitle1.override(
                      fontFamily: 'Poppins',
                      color: const Color(0xFFF3485B),
                      fontSize: 22,
                    ),
              ),*/
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 100),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          color: Color(0x230E151B),
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                          child: Text(
                            'Información de la cuenta',
                            style:
                                FlutterFlowTheme.of(context).bodyText2.override(
                                      fontFamily: 'Poppins',
                                      color: const Color(0xFFF3485B),
                                      fontSize: 16,
                                    ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              User usr = await UsersCrud.getUser(userID: locator<AuthService>().userID);

                              context.pushNamed('EditProfile', queryParams: {
                                'uid': serializeParam(usr.toJson(), ParamType.JSON),
                              }.withoutNulls);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16, 20, 0, 20),
                                    child: Text(
                                      'Editar perfil',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Raleway',
                                            color: const Color(0xFF302C60),
                                            fontSize: 16,
                                          ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 12, 0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFF302C60),
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 2,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          color: FlutterFlowTheme.of(context).lineColor,
                        ),
                        InkWell(
                          onTap: () async {
                            context.pushNamed('ChangePassword');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 20, 0, 20),
                                  child: Text(
                                    'Cambiar contraseña',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Raleway',
                                          color: const Color(0xFF302C60),
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xFF302C60),
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 2,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                          color: FlutterFlowTheme.of(context).lineColor,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (!(Theme.of(context).brightness ==
                                  Brightness.dark))
                                InkWell(
                                  onTap: () async {
                                    setDarkModeSetting(context, ThemeMode.dark);
                                    if (animationsMap[
                                            'containerOnActionTriggerAnimation'] !=
                                        null) {
                                      setState(
                                          () => hasContainerTriggered = true);
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) async =>
                                              await animationsMap[
                                                      'containerOnActionTriggerAnimation']!
                                                  .controller
                                                  .forward(from: 0.0));
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  ),
                                ),
                              if (Theme.of(context).brightness ==
                                  Brightness.dark)
                                InkWell(
                                  onTap: () async {
                                    setDarkModeSetting(
                                        context, ThemeMode.light);
                                    if (animationsMap[
                                            'containerOnActionTriggerAnimation'] !=
                                        null) {
                                      setState(
                                          () => hasContainerTriggered = true);
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) async =>
                                              await animationsMap[
                                                      'containerOnActionTriggerAnimation']!
                                                  .controller
                                                  .forward(from: 0.0));
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16, 12, 16, 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Switch to Light Mode',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Outfit',
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          Container(
                                            width: 80,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Stack(
                                              alignment:
                                                  const AlignmentDirectional(0, 0),
                                              children: [
                                                const Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -0.9, 0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                8, 2, 0, 0),
                                                    child: Icon(
                                                      Icons.wb_sunny_rounded,
                                                      color: Color(0xFF95A1AC),
                                                      size: 24,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          0.9, 0),
                                                  child: Container(
                                                    width: 36,
                                                    height: 36,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          blurRadius: 4,
                                                          color:
                                                              Color(0x430B0D0F),
                                                          offset: Offset(0, 2),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                  ).animateOnActionTrigger(
                                                      animationsMap[
                                                          'containerOnActionTriggerAnimation']!,
                                                      hasBeenTriggered:
                                                          hasContainerTriggered),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 44),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.05, 0),
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(0, 400, 0, 20),
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                text: 'Cerrar Sesion',
                                options: FFButtonOptions(
                                  width: 300,
                                  height: 45,
                                  color: const Color(0xFF32546D),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Raleway',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  elevation: 3,
                                  borderSide: const BorderSide(
                                    color: Color(0xFF32546D),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ).animateOnPageLoad(
                                  animationsMap['buttonOnPageLoadAnimation']!),
                            ),
                          ),
                        ],
                      ),
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
}
