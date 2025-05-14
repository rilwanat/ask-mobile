import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? network, 
      String? address, 
      String? image,}){
    _id = id;
    _network = network;
    _address = address;
    _image = image;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _network = json['network'];
    _address = json['address'];
    _image = json['image'];
  }
  String? _id;
  String? _network;
  String? _address;
  String? _image;
Data copyWith({  String? id,
  String? network,
  String? address,
  String? image,
}) => Data(  id: id ?? _id,
  network: network ?? _network,
  address: address ?? _address,
  image: image ?? _image,
);
  String? get id => _id;
  String? get network => _network;
  String? get address => _address;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['network'] = _network;
    map['address'] = _address;
    map['image'] = _image;
    return map;
  }

}