import 'Data.dart';
import 'dart:convert';

PaystackSubscriptionsResponse paystackSubscriptionsResponseFromJson(String str) => PaystackSubscriptionsResponse.fromJson(json.decode(str));
String paystackSubscriptionsResponseToJson(PaystackSubscriptionsResponse data) => json.encode(data.toJson());
class PaystackSubscriptionsResponse {
  PaystackSubscriptionsResponse({
      bool? status, 
      Data? data,}){
    _status = status;
    _data = data;
}

  PaystackSubscriptionsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  Data? _data;
PaystackSubscriptionsResponse copyWith({  bool? status,
  Data? data,
}) => PaystackSubscriptionsResponse(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}