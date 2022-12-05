
import 'package:bazar_y_pico/Models/Bazar.dart';
import 'package:bazar_y_pico/Services/Auth_service.dart';
import 'package:bazar_y_pico/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/Response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Bazar');

class BazarService {
  static Future<List<Bazar>> getAllBazaars()
  async {
    QuerySnapshot bazars = await _Collection.orderBy('name').get();
    //final allData = bazaarsCollection.docs.map((doc) => doc.data()).toList();
    //print(bazars);
    List<Bazar> result =  bazars.docs.map<Bazar>((doc) {
      //print(doc['name']);
      return Bazar(id: doc.reference.id, name: doc['name'], img: doc['img'], owner: doc['owner']);
    }).toList();
    print(result);
    return result;
  }

  static Future<List<Bazar>> getMyBazaars({
    required userID
  }) async {
    var myBazaars = await _Collection.where('owner', isEqualTo: userID).orderBy('name').get();
    print(myBazaars);
    List<Bazar> result =  myBazaars.docs.map<Bazar>((doc) {
      //print(doc.reference.id);
      return Bazar(id: doc.reference.id, name: doc['name'], img: doc['img'], owner: doc['owner']);
    }).toList();
    //print(result);
    return result;
  }

  static Future<Bazar> getOne({
    required String bazarID
  }) async {
    var  bazarFound = await _Collection.doc(bazarID).get();

    Bazar bzr = Bazar(name: bazarFound['name'], img: bazarFound['img']);

    return bzr;
  }

  static Future<Response> addBazar({
    required String name,
    required String img
  }) async {
    Response response = Response();

    Map<String, dynamic> data = <String, dynamic>{
      'name': name,
      'img': img,
      'owner': locator<AuthService>().userID,
    };

    var result = await _Collection.doc().set(data).whenComplete((){
      response.code = 200;
      response.message = 'Bazar agregado correctamente';
    }).catchError((error){
      response.code = 500;
      response.message = error;
    });

    return response;

  }

}