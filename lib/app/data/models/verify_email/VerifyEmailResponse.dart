import 'dart:convert';

VerifyEmailResponse verifyEmailResponseFromJson(String str) => VerifyEmailResponse.fromJson(json.decode(str));
String verifyEmailResponseToJson(VerifyEmailResponse data) => json.encode(data.toJson());
class VerifyEmailResponse {
  VerifyEmailResponse({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  VerifyEmailResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
VerifyEmailResponse copyWith({  bool? status,
  String? message,
}) => VerifyEmailResponse(  status: status ?? _status,
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