
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

  static Stream<QuerySnapshot<Object?>> getProductsByBazar({
    required String bazarID
  }) {
    CollectionReference productsItemCollection = _Collection;
    var result = productsItemCollection.where('bazar', isEqualTo: bazarID).snapshots();
    return result;
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
      'unitPrice': unitPrice,
      'owner': locator<AuthService>().userID,
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

  static Stream<DocumentSnapshot<Object?>> getProduct({
    required prductID
  }) {
    CollectionReference productsItemCollection = _Collection;
    var product = productsItemCollection.doc(prductID).snapshots();
    return product;
  }

  static Future<Product> getProductToEdit({
    required productID
  }) async {
    var response = await _Collection.doc(productID).get();
    return Product(name: response['name'], description: response['description'], img: response['img'], stock: response['stock'], unitPrice: response['unitPrice'] );
  }

  static Future<Response> updateProduct({
    required String productID,
    required String name,
    required String description,
    required String img,
    required String stock,
    required String unitPrice,
  }) async {
    Response response = Response();

    Map<String, dynamic> data = <String, dynamic> {
      'name': name,
      'description': description,
      'img': img,
      'stock': stock,
      'unitPrice': unitPrice,
    };

    await _Collection.doc(productID).update(data).whenComplete((){
      response.code = 200;
      response.message = 'Producto actualizado correctamente';
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> delete({
    required productID
  }) async {
    Response response = Response();
    print(productID);

    await _Collection.doc(productID).delete().whenComplete(() {
      response.code = 200;
      response.message = 'Producto eliminado';
    }).catchError((e){
      response.code = 500;
      response.message = e;
    });

    return response;
  }

}