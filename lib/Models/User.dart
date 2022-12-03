class User{
  String? uid;
  String? name;
  String? phone;
  String? email;
  String? password;
  String? bazaars;
  String? img;

  User({this.uid, this.name, this.phone, this.email, this.password, this.bazaars, this.img});

  User.fromJson(Map<String, dynamic> json): name = json['name'], phone = json['phone'], email = json['email'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'uid': uid
  };

}