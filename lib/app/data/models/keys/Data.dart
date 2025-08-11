import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? live, 
      String? test, 
      String? admob,}){
    _live = live;
    _test = test;
    _admob = admob;
}

  Data.fromJson(dynamic json) {
    _live = json['live'];
    _test = json['test'];
    _admob = json['admob'];
  }
  String? _live;
  String? _test;
  String? _admob;
Data copyWith({  String? live,
  String? test,
  String? admob,
}) => Data(  live: live ?? _live,
  test: test ?? _test,
  admob: admob ?? _admob,
);
  String? get live => _live;
  String? get test => _test;
  String? get admob => _admob;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['live'] = _live;
    map['test'] = _test;
    map['admob'] = _admob;
    return map;
  }

}