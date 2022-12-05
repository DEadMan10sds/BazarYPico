import 'dart:io';

import 'package:bazar_y_pico/Services/ProductCRUD.dart';
import 'package:image_picker/image_picker.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddProductsWidget extends StatefulWidget {
  const AddProductsWidget({Key? key}) : super(key: key);

  @override
  _AddProductsWidgetState createState() => _AddProductsWidgetState();
}

class _AddProductsWidgetState extends State<AddProductsWidget>
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
  TextEditingController? _unitPrice;
  TextEditingController? _stock;
  TextEditingController? _description;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  late var storageRef = 'https://firebasestorage.googleapis.com/v0/b/bazarypico.appspot.com/o/p.jpg?alt=media&token=b078c66d-dbfe-4a34-bd7f-175683bc93ab';
  late var newImage = null;
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

    final destination = 'bazaars/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');

      await ref.putFile(photo!);
      var download = await ref.getDownloadURL();
      newImage = download.toString();
      print(newImage);
    } catch (e) {
      print('error occured');
    }
  }


  @override
  void initState() {
    super.initState();
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    _name = TextEditingController();
    _unitPrice = TextEditingController();
    _stock = TextEditingController();
    _description = TextEditingController();
    newImage = storageRef;
  }

  @override
  void dispose() {
    _name?.dispose();
    _unitPrice?.dispose();
    _stock?.dispose();
    _description?.dispose();
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
          'Añadir producto',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Raleway',
                color: Colors.white,
              ),
        ),
        actions: [],
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
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: GestureDetector(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFACACAC),
                                ),
                                child: photo != null
                                    ? Image.file(
                                  photo!,
                                  width: 100,
                                  height: 500,
                                  fit: BoxFit.fitHeight,
                                )
                                    : Image.network(storageRef),
                              ),
                            ))
                      ]
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
                                  child: Text(
                                    'Datos de producto',
                                    style: FlutterFlowTheme.of(context)
                                        .title1
                                        .override(
                                          fontFamily: 'Raleway',
                                          color: const Color(0xFF2C2C2C),
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: TextFormField(
                                    controller: _name,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Nombre de producto',
                                      hintText: 'producto',
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
                                        Icons.info_outlined,
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
                                    controller: _unitPrice,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Precio',
                                      hintText: 'Precio',
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
                                        Icons.attach_money_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryColor,
                                      ),
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: TextFormField(
                                    controller: _stock,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Stock',
                                      hintText: 'Stock',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
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
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      prefixIcon: Icon(
                                        Icons.store,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryColor,
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Raleway',
                                          color: FlutterFlowTheme.of(context)
                                              .black600,
                                        ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: TextFormField(
                                    controller: _description,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Descripción',
                                      hintText: 'Tipo de bazar',
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
                                        Icons.notes,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryColor,
                                        size: 0,
                                      ),
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyText1,
                                    maxLines: 5,
                                    keyboardType: TextInputType.multiline,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      await uploadFile();
                                      var result = await ProductCRUD.addProduct(name: _name!.text, description: _description!.text, img: newImage, stock: _stock!.text, unitPrice: _unitPrice!.text);
                                      if(result.code != 200)
                                      {
                                        // ignore: use_build_context_synchronously
                                        return showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(result.message.toString()),
                                              );
                                            });
                                      }
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    },
                                    text: 'Crear producto',
                                    options: FFButtonOptions(
                                      width: 350,
                                      height: 45,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Raleway',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBtnText,
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
