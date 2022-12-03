import 'package:bazar_y_pico/Services/Auth_service.dart';
import 'package:bazar_y_pico/Services/users_service.dart';
import 'package:bazar_y_pico/locator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

import '../Models/User.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EditProfileWidget extends StatefulWidget {
  final dynamic uid;

  const EditProfileWidget({Key? key, @required this.uid}) : super(key: key);

  @override
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
  TextEditingController? _email;
  TextEditingController? _phone;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  var storageRef;
  late var urlUserImage = '';
  File? photo;
  final ImagePicker _picker = ImagePicker();

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

  @override
  void initState() {
    super.initState();
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });*/
    _asyncMethod().then((result) => {});

    /*_name = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();*/
    //print(widget.uid);
  }

  _asyncMethod() async{
    setupAnimations(
      animationsMap.values.where((anim) =>
      anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    var currentUser = await UsersCrud.getUser(userID: locator<AuthService>().userID);
    _name = TextEditingController(text: currentUser.name);
    _phone = TextEditingController(text: currentUser.phone);
    _email = TextEditingController(text: currentUser.email);
    storageRef = currentUser.img!;
  }


  @override
  void dispose() {
    _name?.dispose();
    _email?.dispose();
    _phone?.dispose();
    super.dispose();
  }

  Future<User> getData() => UsersCrud.getUser(userID: locator<AuthService>().userID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: const Color(0xFF32546D),
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
            context.pop();
          },
        ),
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-0.55, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                      child: Text(
                        'Editar Perfil',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: const Color(0xFF32546D),
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                    child: FutureBuilder<User>(
                      future: getData(),
                      builder: (context, AsyncSnapshot<User> snapshot){
                        if(snapshot.hasData)
                          {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image.network(storageRef),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 25),
                                          child: TextFormField(
                                            //initialValue: _name?.text,//snapshot.data?.name.toString(),
                                            controller: _name,
                                            //content: Text(_name.text),
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Nombre completo',
                                              hintText: 'Ingresa tu nombre',
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
                                                Icons.emoji_emotions_outlined,
                                                color: Color(0xFFF3485B),
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
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 25),
                                          child: TextFormField(
                                            controller: _phone,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Teléfono',
                                              hintText: 'Ingresa tu teléfono',
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
                                                Icons.phone_in_talk_rounded,
                                                color: Color(0xFFF3485B),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Raleway',
                                              color: const Color(0xFFF3485B),
                                              fontSize: 18,
                                            ),
                                            keyboardType: TextInputType.phone,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 25),
                                          child: TextFormField(
                                            controller: _email,
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
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFF3485B),
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
                                              prefixIcon: const Icon(
                                                Icons.email_outlined,
                                                color: Color(0xFFF3485B),
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
                                        Align(
                                          alignment: const AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                0, 15, 0, 20),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                //context.pushNamed('')
                                                //User usr = User(snapshot.data);
                                                await uploadFile();
                                                var result = await UsersCrud.updateUser(userID: locator<AuthService>().userID, name: _name!.text, phone: _phone!.text, email: _email!.text, img: storageRef);
                                                //print(_name?.text);
                                                if(result.code != 200)
                                                {
                                                  return showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Text(result.message.toString()),
                                                        );
                                                      });
                                                }

                                                context.pushNamed('Profile');
                                              },
                                              text: 'Guardar Cambios',
                                              options: FFButtonOptions(
                                                width: 280,
                                                height: 45,
                                                color: const Color(0xFFF3485B),
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
                                                  color: Color(0x00FFFFFF),
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(50),
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                            'buttonOnPageLoadAnimation']!),
                                          ),
                                        ),
                                        Align(
                                          alignment: const AlignmentDirectional(0, 0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                0, 15, 0, 20),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                var response = await UsersCrud.deleteUser(userID: locator<AuthService>().userID);
                                                if(response != 200)
                                                {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Text(response.message.toString()),
                                                        );
                                                      });
                                                }
                                                locator<AuthService>().userID = null;
                                                context.pushNamed('Login');
                                                //print('Button pressed ...');
                                              },
                                              text: 'Eliminar perfil',
                                              options: FFButtonOptions(
                                                width: 280,
                                                height: 45,
                                                color: const Color(0xFFF3485B),
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
                                                  color: Color(0x00FFFFFF),
                                                  width: 2,
                                                ),
                                                borderRadius: BorderRadius.circular(50),
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                            'buttonOnPageLoadAnimation']!),
                                          ),
                                        ),
                                    Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 32,
                                        ),
                                        Center(
                                          child: GestureDetector(
                                          onTap: () {
                                            _showPicker(context);
                                          },
                                            child: //Image.network(''),

                                             Container(
                                               child: photo != null
                                              ? ClipRRect(
                                              borderRadius: BorderRadius.circular(2),
                                                child: Image.file(
                                                  photo!,
                                                  width: 100,
                                                  height: 500,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              )
                                                : Container(
                                                  decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius: BorderRadius.circular(50)),
                                                  width: 100,
                                                  height: 500,
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
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        else {
                          return const LoadingIndicator(
                              indicatorType: Indicator.ballPulse, /// Required, The loading type of the widget
                              colors: const [Colors.white],       /// Optional, The color collections
                              strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                              backgroundColor: Colors.black,      /// Optional, Background of the widget
                              pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
                            );
                        }
                      },
                    )
                  ),
                ],
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
                    leading: Icon(Icons.photo_library),
                    title: Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
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
