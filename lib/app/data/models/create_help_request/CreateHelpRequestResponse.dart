import 'dart:convert';

CreateHelpRequestResponse createHelpRequestResponseFromJson(String str) => CreateHelpRequestResponse.fromJson(json.decode(str));
String createHelpRequestResponseToJson(CreateHelpRequestResponse data) => json.encode(data.toJson());
class CreateHelpRequestResponse {
  CreateHelpRequestResponse({
      bool? status, 
      String? message,
    String? id,}){
    _status = status;
    _message = message;
    _id = id;
}

  CreateHelpRequestResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _id = json['id'];
  }
  bool? _status;
  String? _message;
  String? _id;
CreateHelpRequestResponse copyWith({  bool? status,
  String? message,
  String? id,
}) => CreateHelpRequestResponse(  status: status ?? _status,
  message: message ?? _message,
  id: id ?? _id,
);
  bool? get status => _status;
  String? get message => _message;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['id'] = _id;
    return map;
  }

}