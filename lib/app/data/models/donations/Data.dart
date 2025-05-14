import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? type, 
      String? date, 
      String? price,}){
    _id = id;
    _type = type;
    _date = date;
    _price = price;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _date = json['date'];
    _price = json['price'];
  }
  String? _id;
  String? _type;
  String? _date;
  String? _price;
Data copyWith({  String? id,
  String? type,
  String? date,
  String? price,
}) => Data(  id: id ?? _id,
  type: type ?? _type,
  date: date ?? _date,
  price: price ?? _price,
);
  String? get id => _id;
  String? get type => _type;
  String? get date => _date;
  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['date'] = _date;
    map['price'] = _price;
    return map;
  }

}