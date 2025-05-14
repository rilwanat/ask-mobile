import 'dart:convert';

DnqResponse dnqResponseFromJson(String str) => DnqResponse.fromJson(json.decode(str));
String dnqResponseToJson(DnqResponse data) => json.encode(data.toJson());
class DnqResponse {
  DnqResponse({
      bool? status, 
      String? message, 
      num? dnq, 
      num? newVoteWeight,}){
    _status = status;
    _message = message;
    _dnq = dnq;
    _newVoteWeight = newVoteWeight;
}

  DnqResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _dnq = json['dnq'];
    _newVoteWeight = json['new_vote_weight'];
  }
  bool? _status;
  String? _message;
  num? _dnq;
  num? _newVoteWeight;
DnqResponse copyWith({  bool? status,
  String? message,
  num? dnq,
  num? newVoteWeight,
}) => DnqResponse(  status: status ?? _status,
  message: message ?? _message,
  dnq: dnq ?? _dnq,
  newVoteWeight: newVoteWeight ?? _newVoteWeight,
);
  bool? get status => _status;
  String? get message => _message;
  num? get dnq => _dnq;
  num? get newVoteWeight => _newVoteWeight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['dnq'] = _dnq;
    map['new_vote_weight'] = _newVoteWeight;
    return map;
  }

}