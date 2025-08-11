import 'Data.dart';
import 'dart:convert';

KeysResponse keysResponseFromJson(String str) => KeysResponse.fromJson(json.decode(str));
String keysResponseToJson(KeysResponse data) => json.encode(data.toJson());
class KeysResponse {
  KeysResponse({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  KeysResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
KeysResponse copyWith({  bool? status,
  String? message,
  Data? data,
}) => KeysResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}