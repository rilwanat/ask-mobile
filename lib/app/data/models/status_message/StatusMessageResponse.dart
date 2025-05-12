import 'dart:convert';

StatusMessageResponse statusMessageResponseFromJson(String str) => StatusMessageResponse.fromJson(json.decode(str));
String statusMessageResponseToJson(StatusMessageResponse data) => json.encode(data.toJson());
class StatusMessageResponse {
  StatusMessageResponse({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  StatusMessageResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
StatusMessageResponse copyWith({  bool? status,
  String? message,
}) => StatusMessageResponse(  status: status ?? _status,
  message: message ?? _message,
);
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}