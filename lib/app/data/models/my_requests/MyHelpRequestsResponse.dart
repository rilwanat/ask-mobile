import 'RequestData.dart';
import 'dart:convert';

MyHelpRequestsResponse myHelpRequestsResponseFromJson(String str) => MyHelpRequestsResponse.fromJson(json.decode(str));
String myHelpRequestsResponseToJson(MyHelpRequestsResponse data) => json.encode(data.toJson());
class MyHelpRequestsResponse {
  MyHelpRequestsResponse({
      bool? status, 
      String? message, 
      RequestData? requestData,}){
    _status = status;
    _message = message;
    _requestData = requestData;
}

  MyHelpRequestsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _requestData = json['requestData'] != null ? RequestData.fromJson(json['requestData']) : null;
  }
  bool? _status;
  String? _message;
  RequestData? _requestData;
MyHelpRequestsResponse copyWith({  bool? status,
  String? message,
  RequestData? requestData,
}) => MyHelpRequestsResponse(  status: status ?? _status,
  message: message ?? _message,
  requestData: requestData ?? _requestData,
);
  bool? get status => _status;
  String? get message => _message;
  RequestData? get requestData => _requestData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_requestData != null) {
      map['requestData'] = _requestData?.toJson();
    }
    return map;
  }

}