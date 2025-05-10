import 'dart:convert';

ProfileUserData profileUserDataFromJson(String str) => ProfileUserData.fromJson(json.decode(str));
String profileUserDataToJson(ProfileUserData data) => json.encode(data.toJson());
class ProfileUserData {
  ProfileUserData({
      String? id, 
      String? fullname, 
      String? emailAddress, 
      String? voterConsistency, 
      String? phoneNumber, 
      dynamic kycStatus, 
      String? accountNumber, 
      String? accountName, 
      String? bankName, 
      String? gender, 
      String? stateOfResidence, 
      String? profilePicture, 
      String? emailVerified, 
      String? registrationDate, 
      String? userType, 
      String? eligibility, 
      String? isCheat, 
      String? openedWelcomeMsg, 
      String? voteWeight,}){
    _id = id;
    _fullname = fullname;
    _emailAddress = emailAddress;
    _voterConsistency = voterConsistency;
    _phoneNumber = phoneNumber;
    _kycStatus = kycStatus;
    _accountNumber = accountNumber;
    _accountName = accountName;
    _bankName = bankName;
    _gender = gender;
    _stateOfResidence = stateOfResidence;
    _profilePicture = profilePicture;
    _emailVerified = emailVerified;
    _registrationDate = registrationDate;
    _userType = userType;
    _eligibility = eligibility;
    _isCheat = isCheat;
    _openedWelcomeMsg = openedWelcomeMsg;
    _voteWeight = voteWeight;
}

  ProfileUserData.fromJson(dynamic json) {
    _id = json['id'];
    _fullname = json['fullname'];
    _emailAddress = json['email_address'];
    _voterConsistency = json['voter_consistency'];
    _phoneNumber = json['phone_number'];
    _kycStatus = json['kyc_status'];
    _accountNumber = json['account_number'];
    _accountName = json['account_name'];
    _bankName = json['bank_name'];
    _gender = json['gender'];
    _stateOfResidence = json['state_of_residence'];
    _profilePicture = json['profile_picture'];
    _emailVerified = json['email_verified'];
    _registrationDate = json['registration_date'];
    _userType = json['user_type'];
    _eligibility = json['eligibility'];
    _isCheat = json['is_cheat'];
    _openedWelcomeMsg = json['opened_welcome_msg'];
    _voteWeight = json['vote_weight'];
  }
  String? _id;
  String? _fullname;
  String? _emailAddress;
  String? _voterConsistency;
  String? _phoneNumber;
  dynamic _kycStatus;
  String? _accountNumber;
  String? _accountName;
  String? _bankName;
  String? _gender;
  String? _stateOfResidence;
  String? _profilePicture;
  String? _emailVerified;
  String? _registrationDate;
  String? _userType;
  String? _eligibility;
  String? _isCheat;
  String? _openedWelcomeMsg;
  String? _voteWeight;
ProfileUserData copyWith({  String? id,
  String? fullname,
  String? emailAddress,
  String? voterConsistency,
  String? phoneNumber,
  dynamic kycStatus,
  String? accountNumber,
  String? accountName,
  String? bankName,
  String? gender,
  String? stateOfResidence,
  String? profilePicture,
  String? emailVerified,
  String? registrationDate,
  String? userType,
  String? eligibility,
  String? isCheat,
  String? openedWelcomeMsg,
  String? voteWeight,
}) => ProfileUserData(  id: id ?? _id,
  fullname: fullname ?? _fullname,
  emailAddress: emailAddress ?? _emailAddress,
  voterConsistency: voterConsistency ?? _voterConsistency,
  phoneNumber: phoneNumber ?? _phoneNumber,
  kycStatus: kycStatus ?? _kycStatus,
  accountNumber: accountNumber ?? _accountNumber,
  accountName: accountName ?? _accountName,
  bankName: bankName ?? _bankName,
  gender: gender ?? _gender,
  stateOfResidence: stateOfResidence ?? _stateOfResidence,
  profilePicture: profilePicture ?? _profilePicture,
  emailVerified: emailVerified ?? _emailVerified,
  registrationDate: registrationDate ?? _registrationDate,
  userType: userType ?? _userType,
  eligibility: eligibility ?? _eligibility,
  isCheat: isCheat ?? _isCheat,
  openedWelcomeMsg: openedWelcomeMsg ?? _openedWelcomeMsg,
  voteWeight: voteWeight ?? _voteWeight,
);
  String? get id => _id;
  String? get fullname => _fullname;
  String? get emailAddress => _emailAddress;
  String? get voterConsistency => _voterConsistency;
  String? get phoneNumber => _phoneNumber;
  dynamic get kycStatus => _kycStatus;
  String? get accountNumber => _accountNumber;
  String? get accountName => _accountName;
  String? get bankName => _bankName;
  String? get gender => _gender;
  String? get stateOfResidence => _stateOfResidence;
  String? get profilePicture => _profilePicture;
  String? get emailVerified => _emailVerified;
  String? get registrationDate => _registrationDate;
  String? get userType => _userType;
  String? get eligibility => _eligibility;
  String? get isCheat => _isCheat;
  String? get openedWelcomeMsg => _openedWelcomeMsg;
  String? get voteWeight => _voteWeight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['fullname'] = _fullname;
    map['email_address'] = _emailAddress;
    map['voter_consistency'] = _voterConsistency;
    map['phone_number'] = _phoneNumber;
    map['kyc_status'] = _kycStatus;
    map['account_number'] = _accountNumber;
    map['account_name'] = _accountName;
    map['bank_name'] = _bankName;
    map['gender'] = _gender;
    map['state_of_residence'] = _stateOfResidence;
    map['profile_picture'] = _profilePicture;
    map['email_verified'] = _emailVerified;
    map['registration_date'] = _registrationDate;
    map['user_type'] = _userType;
    map['eligibility'] = _eligibility;
    map['is_cheat'] = _isCheat;
    map['opened_welcome_msg'] = _openedWelcomeMsg;
    map['vote_weight'] = _voteWeight;
    return map;
  }

}