import 'package:bazar_y_pico/Services/users_service.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>
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
  TextEditingController? email;
  TextEditingController? password;

  late bool passwordVisibility;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setupAnimations(
      animationsMap.values.where((anim) =>
      anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    email = TextEditingController();
    password = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    email?.dispose();
    password?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                              decoration: const BoxDecoration(
                                color: Color(0xFF32546D),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 40),
                                child: Image.asset(
                                  'assets/images/LOGO.png',
                                  width: 100,
                                  height: MediaQuery.of(context).size.height * 1,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsetsDirectional.fromSTEB(24, 35, 24, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 30),
                                      child: Text(
                                        'Iniciar Sesion',
                                        style: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                          fontFamily: 'Raleway',
                                          color: const Color(0xFFF3485B),
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 25),
                                      child: SizedBox(
                                        width: 360,
                                        child: TextFormField(
                                          controller: email,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Correo electrónico',
                                            hintText: 'Ingresa tu correo',
                                            hintStyle: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: const Color(0x9AFFFFFF),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFF3485B),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFF3485B),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFFF0000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFFF0000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            prefixIcon: const Icon(
                                              Icons.email_outlined,
                                              color: Color(0xFFF3485B),
                                              size: 23,
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                            fontFamily: 'Raleway',
                                            color: const Color(0xFFF3485B),
                                            fontSize: 18,
                                          ),
                                          keyboardType: TextInputType.emailAddress,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 40),
                                      child: TextFormField(
                                        controller: password,
                                        obscureText: !passwordVisibility,
                                        decoration: InputDecoration(
                                          labelText: 'Contraseña',
                                          hintText: 'Ingresa tu contraseña',
                                          hintStyle: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: const Color(0x9AFFFFFF),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFF3485B),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFF3485B),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFFF0000),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFFF0000),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          prefixIcon: const Icon(
                                            Icons.lock_outline,
                                            color: Color(0xFFF3485B),
                                            size: 19,
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () => setState(
                                                  () => passwordVisibility =
                                              !passwordVisibility,
                                            ),
                                            focusNode:
                                            FocusNode(skipTraversal: true),
                                            child: Icon(
                                              passwordVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons.visibility_off_outlined,
                                              color: const Color(0x80FFFFFF),
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                          fontFamily: 'Raleway',
                                          color: const Color(0xFFF3485B),
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),

                                    Align(
                                      alignment: const AlignmentDirectional(-0.05, 0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 20),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            var response = await UsersCrud.loggIn(email: email!.text, password: password!.text);
                                            print(response);
                                            if(response.code != 200)
                                            {
                                              return showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Text(response.message.toString()),
                                                    );
                                                  });
                                            }
                                            // ignore: use_build_context_synchronously
                                            context.pushNamed(
                                              'Bazaars',
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey: const TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                  PageTransitionType.fade,
                                                ),
                                              },
                                            );
                                          },
                                          text: 'Iniciar Sesión',
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
                                        ).animateOnPageLoad(animationsMap[
                                        'buttonOnPageLoadAnimation1']!),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 5),
                                        child: Text(
                                          '¿Aún no tienes cuenta?',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            color: const Color(0xFF32546D),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(-0.05, 0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 20),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            context.pushNamed(
                                              'Register',
                                              extra: <String, dynamic>{
                                                kTransitionInfoKey: const TransitionInfo(
                                                  hasTransition: true,
                                                  transitionType:
                                                  PageTransitionType.fade,
                                                ),
                                              },
                                            );
                                          },
                                          text: 'Registrarme ',
                                          options: FFButtonOptions(
                                            width: 280,
                                            height: 45,
                                            color: const Color(0xFF32546D),
                                            textStyle: FlutterFlowTheme.of(context)
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Raleway',
                                              color:
                                              FlutterFlowTheme.of(context)
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
                                        ).animateOnPageLoad(animationsMap[
                                        'buttonOnPageLoadAnimation2']!),
                                      ),
                                    ),
                                  ],
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
            ),
          ),
      ),
    );
  }
}
