
import 'dart:core';
import 'dart:ffi';

import 'package:bazar_y_pico/Models/Product.dart';
import 'package:bazar_y_pico/Services/Auth_service.dart';
import 'package:bazar_y_pico/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/Response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Products');

class ProductCRUD {

  static Stream<QuerySnapshot> getProductsByBazar({
    required String bazarID
  }) {
    CollectionReference productsItemCollection = _Collection;
    return productsItemCollection.snapshots();
  }

  static Future<Response> addProduct({
    required String name,
    required String description,
    required String img,
    required String stock,
    required String unitPrice,
  }) async {
    Response response = Response();

    Map<String, dynamic> data = <String, dynamic>{
      'name': name,
      'description': description,
      'img': img,
      'bazar': locator<AuthService>().bazarSelected,
      'stock': stock,
      'unitPrice': unitPrice
    };

    var result = await _Collection.doc().set(data).whenComplete((){
      response.code = 200;
      response.message = 'Producto agregado correctamente';
    }).catchError((error){
      response.code = 500;
      response.message = error;
    });

    return response;
  }



}