import 'PlansData.dart';
import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      List<PlansData>? plansData,}){
    _plansData = plansData;
}

  Data.fromJson(dynamic json) {
    if (json['plans_data'] != null) {
      _plansData = [];
      json['plans_data'].forEach((v) {
        _plansData?.add(PlansData.fromJson(v));
      });
    }
  }
  List<PlansData>? _plansData;
Data copyWith({  List<PlansData>? plansData,
}) => Data(  plansData: plansData ?? _plansData,
);
  List<PlansData>? get plansData => _plansData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_plansData != null) {
      map['plans_data'] = _plansData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}