import 'package:cloud_firestore/cloud_firestore.dart';


class AuthService {
  //Declare variable
  late var authenticated = false;
  late var bazarSelected;
  late var userID;
  /*
  * PENDING
  * How to implement getter and setter working properly
  *
  */

  //Getter
  //bool get _authenticated => authenticated;

  //function that works as setter
  void setAuthenticated(bool value) {
    authenticated = value;
  }
}

