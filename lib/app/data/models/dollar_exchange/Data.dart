import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? rate,}){
    _id = id;
    _rate = rate;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _rate = json['rate'];
  }
  String? _id;
  String? _rate;
Data copyWith({  String? id,
  String? rate,
}) => Data(  id: id ?? _id,
  rate: rate ?? _rate,
);
  String? get id => _id;
  String? get rate => _rate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['rate'] = _rate;
    return map;
  }

}