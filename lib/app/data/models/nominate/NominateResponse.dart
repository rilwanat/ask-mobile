import 'dart:convert';

NominateResponse nominateResponseFromJson(String str) => NominateResponse.fromJson(json.decode(str));
String nominateResponseToJson(NominateResponse data) => json.encode(data.toJson());
class NominateResponse {
  NominateResponse({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  NominateResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
NominateResponse copyWith({  bool? status,
  String? message,
}) => NominateResponse(  status: status ?? _status,
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