import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/login/UserData.dart';

// import '../models/profile/ProfileResponse.dart';


class CachedData {
  CachedData();

  Future<void> clearAllSavedDetails({required String userType}) async {
    final prefs = await SharedPreferences.getInstance();

    // Check if the token exists before removal
    if (prefs.containsKey("token")) {
      print("Token found. Clearing...");
      await prefs.remove("token");
    } else {
      print("Token not found.");
    }

    // Remove other keys
    await prefs.remove("terms");
    await prefs.remove("userType");


    // Confirm the clearing of data
    print("Token after clearing: ${prefs.getString("token")}");
  }


  // Tokens
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    // print("Getting token: $token");
    if (token == null) {
      print("Token not found in SharedPreferences");
    }
    return token;
  }


  Future<void> saveAuthToken(String accessTokenToSave) async {
    final prefs = await SharedPreferences.getInstance();
    // print(" Saving token: $accessTokenToSave");
    await prefs.setString("token", accessTokenToSave);
  }
  // Tokens



  // // Terms
  // Future<void> saveTerms() async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   await _prefs.setBool('terms', true);
  // }
  //
  // Future<bool?> checkTerms() async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   await _prefs.getBool('terms') ?? false;
  // }
  // // Terms

  // Welcome seen
  // Future<void> setWelcomeSeen(bool w) async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   await _prefs.setBool('welcomeSeen', w);
  // }
  //
  // Future<bool?> getWelcomeSeen() async {
  //   final _prefs = await SharedPreferences.getInstance();
  //   await _prefs.getBool('welcomeSeen') ?? false;
  // }
  // Welcome seen

// UserType
  Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userType");
  }

  Future<void> saveUserType(String userTypeToSave) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userType", userTypeToSave);
  }
  // UserType


// patientProfileData
  Future<UserData?> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString("profileData");
    if (jsonString != null) {
      Map<String, dynamic> json = jsonDecode(jsonString);
      return UserData.fromJson(json);
    }
    return null;
  }

  Future<void> saveProfileData(
      UserData profileDataToSave) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(profileDataToSave.toJson());
    print("saving: " + jsonString);
    await prefs.setString("profileData", jsonString);
    // print("saved: " + jsonString);
  }
// patientProfileData
}
