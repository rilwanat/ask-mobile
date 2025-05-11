import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? bankName, 
      String? bankCode,}){
    _id = id;
    _bankName = bankName;
    _bankCode = bankCode;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _bankName = json['bank_name'];
    _bankCode = json['bank_code'];
  }
  String? _id;
  String? _bankName;
  String? _bankCode;
Data copyWith({  String? id,
  String? bankName,
  String? bankCode,
}) => Data(  id: id ?? _id,
  bankName: bankName ?? _bankName,
  bankCode: bankCode ?? _bankCode,
);
  String? get id => _id;
  String? get bankName => _bankName;
  String? get bankCode => _bankCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['bank_name'] = _bankName;
    map['bank_code'] = _bankCode;
    return map;
  }

}