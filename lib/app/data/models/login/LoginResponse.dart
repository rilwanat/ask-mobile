import 'UserData.dart';
import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());
class LoginResponse {
  LoginResponse({
      bool? status, 
      String? message, 
      String? token, 
      UserData? userData,}){
    _status = status;
    _message = message;
    _token = token;
    _userData = userData;
}

  LoginResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _token = json['token'];
    _userData = json['userData'] != null ? UserData.fromJson(json['userData']) : null;
  }
  bool? _status;
  String? _message;
  String? _token;
  UserData? _userData;
LoginResponse copyWith({  bool? status,
  String? message,
  String? token,
  UserData? userData,
}) => LoginResponse(  status: status ?? _status,
  message: message ?? _message,
  token: token ?? _token,
  userData: userData ?? _userData,
);
  bool? get status => _status;
  String? get message => _message;
  String? get token => _token;
  UserData? get userData => _userData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['token'] = _token;
    if (_userData != null) {
      map['userData'] = _userData?.toJson();
    }
    return map;
  }

}