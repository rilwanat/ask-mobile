import 'dart:convert';

ResendVerificationCodeResponse resendVerificationCodeResponseFromJson(String str) => ResendVerificationCodeResponse.fromJson(json.decode(str));
String resendVerificationCodeResponseToJson(ResendVerificationCodeResponse data) => json.encode(data.toJson());
class ResendVerificationCodeResponse {
  ResendVerificationCodeResponse({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  ResendVerificationCodeResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
ResendVerificationCodeResponse copyWith({  bool? status,
  String? message,
}) => ResendVerificationCodeResponse(  status: status ?? _status,
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