import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));
String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());
class RegisterResponse {
  RegisterResponse({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  RegisterResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
RegisterResponse copyWith({  bool? status,
  String? message,
}) => RegisterResponse(  status: status ?? _status,
  message: message ?? _message,
);
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}