import 'Data.dart';
import 'dart:convert';

DollarExchangeResponse dollarExchangeResponseFromJson(String str) => DollarExchangeResponse.fromJson(json.decode(str));
String dollarExchangeResponseToJson(DollarExchangeResponse data) => json.encode(data.toJson());
class DollarExchangeResponse {
  DollarExchangeResponse({
      bool? status, 
      List<Data>? data,}){
    _status = status;
    _data = data;
}

  DollarExchangeResponse.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  List<Data>? _data;
DollarExchangeResponse copyWith({  bool? status,
  List<Data>? data,
}) => DollarExchangeResponse(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}