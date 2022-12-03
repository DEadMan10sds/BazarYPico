import 'dart:ffi';

import 'package:bazar_y_pico/Services/Auth_service.dart';
import 'package:bazar_y_pico/Services/users_service.dart';
import 'package:bazar_y_pico/locator.dart';

import '../Models/User.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../main.dart';
import '../welcome/welcome_widget.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'dart:io';


class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget>
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
  TextEditingController? _name;
  TextEditingController? _phone;
  TextEditingController? _email;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  var storageRef;
  late var urlUserImage = '';
  File? photo;
  final ImagePicker _picker = ImagePicker();

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


  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
        //uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
        //uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (photo == null) return;
    final fileName = basename(photo!.path);
    //storageRef = basename(photo!.path).toString();

    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');

      await ref.putFile(photo!);
      var download = await ref.getDownloadURL();
      storageRef = download.toString();
    } catch (e) {
      print('error occured');
    }
  }

  Future<bool> setUserData() async{

    User currentUser =  await UsersCrud.getUser(userID: locator<AuthService>().userID);
    _name = TextEditingController(text: currentUser.name);
    _phone = TextEditingController(text: currentUser.phone);
    _email = TextEditingController(text: currentUser.email);
    storageRef = currentUser.img;
    return true;
  }

  @override
  void dispose() {
    _name?.dispose();
    _phone?.dispose();
    _email?.dispose();
    super.dispose();
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
        title: Text(
          'Editar perfil',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Raleway',
                color: Colors.white,
              ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: SingleChildScrollView(
              child: FutureBuilder<bool>(
                  future: setUserData(),
                  builder: (context, AsyncSnapshot<bool> snapshot)
                  {
                    if(snapshot.connectionState == ConnectionState.waiting)
                    {
                      return const Text('Cargando');
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 32,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundColor: const Color(0xffFDCF09),
                                  child: storageRef != null
                                      ? Image.network(storageRef)
                                      : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(50)),
                                    width: 100,
                                    height: 100,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(24, 2, 24, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 20),
                                        child: TextFormField(
                                          controller: _name,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Nombre completo',
                                            hintText: 'Ingresa tu nombre',
                                            hintStyle: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Raleway',
                                              color: const Color(0x9AFFFFFF),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context)
                                                    .secondaryColor,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context)
                                                    .secondaryColor,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFFF0000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFFF0000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            prefixIcon: Icon(
                                              Icons.emoji_emotions_outlined,
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryColor,
                                            ),
                                          ),
                                          style:
                                          FlutterFlowTheme.of(context).bodyText1,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 20),
                                        child: TextFormField(
                                          controller: _phone,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Teléfono',
                                            hintText: 'Ingresa tu teléfono',
                                            hintStyle: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Raleway',
                                              color: const Color(0x9AFFFFFF),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context)
                                                    .secondaryColor,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context)
                                                    .secondaryColor,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFFF0000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFFF0000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            prefixIcon: Icon(
                                              Icons.phone_in_talk_rounded,
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryColor,
                                            ),
                                          ),
                                          style:
                                          FlutterFlowTheme.of(context).bodyText1,
                                          keyboardType: TextInputType.phone,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 20),
                                        child: TextFormField(
                                          controller: _email,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Correo electrónico',
                                            hintText: 'Ingresa tu correo',
                                            hintStyle: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Raleway',
                                              color: const Color(0x9AFFFFFF),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context)
                                                    .secondaryColor,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context)
                                                    .secondaryColor,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFFF0000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFFF0000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            prefixIcon: Icon(
                                              Icons.email_outlined,
                                              color: FlutterFlowTheme.of(context)
                                                  .secondaryColor,
                                            ),
                                          ),
                                          style:
                                          FlutterFlowTheme.of(context).bodyText1,
                                          keyboardType: TextInputType.emailAddress,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 20),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            uploadFile();
                                            var response = await UsersCrud.updateUser(userID: locator<AuthService>().userID, name: _name!.text, phone: _phone!.text, email:_email!.text, img: 'img');
                                            if(response.code != 200)
                                            {
                                              // ignore: use_build_context_synchronously
                                              return showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Text(response.message.toString()),
                                                    );
                                                  });
                                            }
                                            // ignore: use_build_context_synchronously
                                            await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.fade,
                                                duration:
                                                const Duration(milliseconds: 300),
                                                reverseDuration:
                                                const Duration(milliseconds: 300),
                                                child: const NavBarPage(
                                                    initialPage: 'Bazaars'),
                                              ),
                                            );
                                          },
                                          text: 'Guardar',
                                          options: FFButtonOptions(
                                            width: 300,
                                            height: 45,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryColor,
                                            textStyle: FlutterFlowTheme.of(context)
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Raleway',
                                              color: Colors.white,
                                            ),
                                            elevation: 3,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                        'buttonOnPageLoadAnimation']!),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 20),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            var response = await UsersCrud.deleteUser(userID: locator<AuthService>().userID);
                                            if(response.code != 200)
                                            {
                                              // ignore: use_build_context_synchronously
                                              return showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Text(response.message.toString()),
                                                    );
                                                  });
                                            }
                                            // ignore: use_build_context_synchronously
                                            await Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType.fade,
                                                    duration:
                                                    const Duration(milliseconds: 300),
                                                    reverseDuration:
                                                    const Duration(milliseconds: 300),
                                                    child: const WelcomeWidget()
                                                )
                                            );
                                          },
                                          text: 'Eliminar cuenta',
                                          options: FFButtonOptions(
                                            width: 300,
                                            height: 45,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryColor,
                                            textStyle: FlutterFlowTheme.of(context)
                                                .subtitle2
                                                .override(
                                              fontFamily: 'Raleway',
                                              color: Colors.white,
                                            ),
                                            elevation: 3,
                                            borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                        'buttonOnPageLoadAnimation']!),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

}
