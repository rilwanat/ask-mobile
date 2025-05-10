import 'ProfileUserData.dart';
import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) => ProfileResponse.fromJson(json.decode(str));
String profileResponseToJson(ProfileResponse data) => json.encode(data.toJson());
class ProfileResponse {
  ProfileResponse({
      bool? status, 
      String? message, 
      ProfileUserData? profileUserData,}){
    _status = status;
    _message = message;
    _profileUserData = profileUserData;
}

  ProfileResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _profileUserData = json['profileUserData'] != null ? ProfileUserData.fromJson(json['profileUserData']) : null;
  }
  bool? _status;
  String? _message;
  ProfileUserData? _profileUserData;
ProfileResponse copyWith({  bool? status,
  String? message,
  ProfileUserData? profileUserData,
}) => ProfileResponse(  status: status ?? _status,
  message: message ?? _message,
  profileUserData: profileUserData ?? _profileUserData,
);
  bool? get status => _status;
  String? get message => _message;
  ProfileUserData? get profileUserData => _profileUserData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_profileUserData != null) {
      map['profileUserData'] = _profileUserData?.toJson();
    }
    return map;
  }

}