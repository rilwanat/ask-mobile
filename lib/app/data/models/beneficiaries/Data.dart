import 'User.dart';
import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? emailAddress, 
      String? date, 
      String? amount, 
      String? status, 
      String? dateResolved, 
      String? nominationCount, 
      String? remark, 
      User? user,}){
    _id = id;
    _emailAddress = emailAddress;
    _date = date;
    _amount = amount;
    _status = status;
    _dateResolved = dateResolved;
    _nominationCount = nominationCount;
    _remark = remark;
    _user = user;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _emailAddress = json['email_address'];
    _date = json['date'];
    _amount = json['amount'];
    _status = json['status'];
    _dateResolved = json['date_resolved'];
    _nominationCount = json['nomination_count'];
    _remark = json['remark'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _id;
  String? _emailAddress;
  String? _date;
  String? _amount;
  String? _status;
  String? _dateResolved;
  String? _nominationCount;
  String? _remark;
  User? _user;
Data copyWith({  String? id,
  String? emailAddress,
  String? date,
  String? amount,
  String? status,
  String? dateResolved,
  String? nominationCount,
  String? remark,
  User? user,
}) => Data(  id: id ?? _id,
  emailAddress: emailAddress ?? _emailAddress,
  date: date ?? _date,
  amount: amount ?? _amount,
  status: status ?? _status,
  dateResolved: dateResolved ?? _dateResolved,
  nominationCount: nominationCount ?? _nominationCount,
  remark: remark ?? _remark,
  user: user ?? _user,
);
  String? get id => _id;
  String? get emailAddress => _emailAddress;
  String? get date => _date;
  String? get amount => _amount;
  String? get status => _status;
  String? get dateResolved => _dateResolved;
  String? get nominationCount => _nominationCount;
  String? get remark => _remark;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email_address'] = _emailAddress;
    map['date'] = _date;
    map['amount'] = _amount;
    map['status'] = _status;
    map['date_resolved'] = _dateResolved;
    map['nomination_count'] = _nominationCount;
    map['remark'] = _remark;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}