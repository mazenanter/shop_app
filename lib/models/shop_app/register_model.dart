class RegisterModel {
  bool status=true;
  String? message;
  RegisterUserData? data;
  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? RegisterUserData.fromJson(json['data']) : null;
  }
}

class RegisterUserData {
  String? name;
  String? phone;
  String? email;
  int? id;
  String? image;
  String? token;
  RegisterUserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
}
