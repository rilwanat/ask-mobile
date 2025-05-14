import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? name, 
      String? date, 
      String? type, 
      String? image,}){
    _id = id;
    _name = name;
    _date = date;
    _type = type;
    _image = image;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _date = json['date'];
    _type = json['type'];
    _image = json['image'];
  }
  String? _id;
  String? _name;
  String? _date;
  String? _type;
  String? _image;
Data copyWith({  String? id,
  String? name,
  String? date,
  String? type,
  String? image,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  date: date ?? _date,
  type: type ?? _type,
  image: image ?? _image,
);
  String? get id => _id;
  String? get name => _name;
  String? get date => _date;
  String? get type => _type;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['date'] = _date;
    map['type'] = _type;
    map['image'] = _image;
    return map;
  }

}