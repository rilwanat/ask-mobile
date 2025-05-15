import 'dart:convert';

RequestData requestDataFromJson(String str) => RequestData.fromJson(json.decode(str));
String requestDataToJson(RequestData data) => json.encode(data.toJson());
class RequestData {
  RequestData({
      String? id, 
      String? date, 
      String? nominationCount, 
      String? description, 
      String? remark, 
      String? emailAddress, 
      String? requestImage, 
      String? helpToken,}){
    _id = id;
    _date = date;
    _nominationCount = nominationCount;
    _description = description;
    _remark = remark;
    _emailAddress = emailAddress;
    _requestImage = requestImage;
    _helpToken = helpToken;
}

  RequestData.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _nominationCount = json['nomination_count'];
    _description = json['description'];
    _remark = json['remark'];
    _emailAddress = json['email_address'];
    _requestImage = json['request_image'];
    _helpToken = json['help_token'];
  }
  String? _id;
  String? _date;
  String? _nominationCount;
  String? _description;
  String? _remark;
  String? _emailAddress;
  String? _requestImage;
  String? _helpToken;
RequestData copyWith({  String? id,
  String? date,
  String? nominationCount,
  String? description,
  String? remark,
  String? emailAddress,
  String? requestImage,
  String? helpToken,
}) => RequestData(  id: id ?? _id,
  date: date ?? _date,
  nominationCount: nominationCount ?? _nominationCount,
  description: description ?? _description,
  remark: remark ?? _remark,
  emailAddress: emailAddress ?? _emailAddress,
  requestImage: requestImage ?? _requestImage,
  helpToken: helpToken ?? _helpToken,
);
  String? get id => _id;
  String? get date => _date;
  String? get nominationCount => _nominationCount;
  String? get description => _description;
  String? get remark => _remark;
  String? get emailAddress => _emailAddress;
  String? get requestImage => _requestImage;
  String? get helpToken => _helpToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['nomination_count'] = _nominationCount;
    map['description'] = _description;
    map['remark'] = _remark;
    map['email_address'] = _emailAddress;
    map['request_image'] = _requestImage;
    map['help_token'] = _helpToken;
    return map;
  }

}