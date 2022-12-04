import 'package:bazar_y_pico/Services/Auth_service.dart';
import 'package:bazar_y_pico/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import '../Models/Response.dart';
import '../Models/User.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Users');

class UsersCrud {

  static Future<Response> addUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    Response response = Response();
      DocumentReference documentReferencer = _Collection.doc();
      //print(password);
      var hashedPassword = Crypt.sha256(password);
      //print(hashedPassword.toString());
      Map<String, dynamic> data = <String, dynamic>{
        'name': name,
        'email': email,
        'password': hashedPassword.toString(),
        'phone': phone,
        'img': 'https://firebasestorage.googleapis.com/v0/b/bazarypico.appspot.com/o/user-128.png?alt=media&token=7e942d70-3617-4f94-9319-5f0009b9375e',
        'bazaars': []
      };

    //Validación de formato de email -> Fuente: stackOverflow, No, no manejo
    //Regex para nada
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email))
    {
      response.code = 500;
      response.message = 'Por favor introduzca un email valido';
      return response;
    }
      //Obtiene todos los elementos que cumplan con la condición dentro de where
      var existsEmail = await _Collection.where('email', isEqualTo: email).get();
      var existsPhone = await _Collection.where('phone', isEqualTo: phone).get();
      /* RECORRE el arreglo obtenido e imprime el nombre del elemento
        existsEmail.docs.forEach((element) {
          print(element['name']);
        });
      */
    print(existsEmail.docs.length);
      if(existsEmail.docs.isEmpty || existsPhone.docs.isEmpty)
      {

        var result = await documentReferencer.set(data).whenComplete( (){
          response.code = 200;
          response.message = "Registration complete";
        }).catchError((e){
          response.code = 500;
          response.message = e.toString();
        });
        return response;
      }

      response.code = 500;
      response.message = "Teléfono o correo ya registrados";
      return response;

  }

  static Future<Response> loggIn({
    required email,
    required password
    }) async {
        Response response = Response();
        var existsEmail = await _Collection.where('email', isEqualTo: email).get();
        if(existsEmail.docs.isNotEmpty)
        {
          print('Password: $password ////// UserPass: ${existsEmail.docs[0]['password']}');
          var passwordMatches = Crypt(existsEmail.docs[0]['password']).match(password);
          if(!passwordMatches)
            {
              response.code = 401;
              response.message = 'Correo o contraseña erróneos';
              return response;
            }

          response.code = 200;
          response.message = 'Login correcto';
          var authService = locator<AuthService>();
          authService.authenticated = true;
          authService.userID = existsEmail.docs[0].reference.id;

          return response;
        }

        response.code = 400;
        response.message = 'No está registrado este usuario';

        return response;
    }

    static Future<String> getUserName({
      required userID
    }) async {
      var userFound = await _Collection.doc(userID).get();

      return userFound['name'];
      //return userFound['name'];
    }

    static Future<User> getUser({
      required userID
    }) async {
      var userFound = await _Collection.doc(userID).get();
      User usr = User(name:userFound['name'],email: userFound['email'], phone: userFound['phone'], img: userFound['img'], bazaars: userFound['bazaars']);//userFound[0].data() as User;
      //print(usr.toJson());
      return usr;
    }

    static Future<Response> updateUser({
      required userID,
      required name,
      required phone,
      required email,
      required img,
    }) async {
      Response response = Response();
      //DocumentReference user = _Collection.doc(userID);
      print(email);
      String pattern =
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
          r"{0,253}[a-zA-Z0-9])?)*$";
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(email))
      {
        response.code = 500;
        response.message = 'Por favor introduzca un email valido';
        return response;
      }

      Map<String, dynamic> userDataUpdated = <String, dynamic>{
        'name': name,
        'email': email,
        'phone': phone,
        'img': img
      };

      await _Collection.doc(userID).update(userDataUpdated).whenComplete(()=>{
          response.code = 200,
          response.message = 'Datos actualizados',
        }
      ).catchError((error) => {
        response.code = 500,
        response.message = 'Error al actualizar ${error}',
      });

      return response;
    }

    static Future<Response> updatePassword({
      required userID,
      required password,
      required newPassword,
      required confirmNewPassword
    }) async {
      Response response = Response();

      if(confirmNewPassword != newPassword)
      {
        response.code = 400;
        response.message = 'La nueva contraseña no coincide';
      }

      var user = await _Collection.doc(userID).get();
      var passwordMatches = Crypt(user['password']).match(password);
      if(!passwordMatches)
      {
        response.code = 401;
        response.message = 'Credenciales incorrectas';
        return response;
      }

      var hashedPassword = Crypt.sha256(newPassword).toString();
      Map<String, dynamic> userDataUpdated = <String, dynamic>{
        'password': hashedPassword,
      };

      await  _Collection.doc(userID).update(userDataUpdated);

      response.code = 200;
      response.message = "Contraseña actualizada";

      return response;
    }

    static Future<Response> deleteUser({
      required userID,
    }) async {
      Response response = Response();

      DocumentReference documentReferencer = _Collection.doc(userID);

      await documentReferencer.delete().whenComplete(() => {
        locator<AuthService>().userID = null,
        locator<AuthService>().authenticated = false,
        locator<AuthService>().bazaars = [],
        response.code = 200,
        response.message = 'Cuenta eliminada'
      }).catchError((error)=> {
        response.code = 500,
        response.message = error,
      });


      return response;
    }

    ///TODO: Review why on logOut shows error 0<=currentIndex is not true
    static Future<Response> logOut({
      required userID
    }) async {
      Response response = Response();

      locator<AuthService>().userID = null;
      locator<AuthService>().authenticated = false;
      locator<AuthService>().bazaars = [];

      response.code = 200;
      response.message = 'Sesión terminada';

      return response;
    }
}