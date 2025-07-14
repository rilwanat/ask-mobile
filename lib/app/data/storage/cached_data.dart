import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/login/UserData.dart';



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


// userProfileData
  Future<UserData?> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString("profileData");
    // print("getting: " + jsonString!);
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
    // print("saving: " + jsonString);
    await prefs.setString("profileData", jsonString);
    // print("saved: " + jsonString);
  }
// userProfileData



  Future<String?> getLastNotification() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("last_notification");
  }

  Future<void> saveLastNotification(String notification) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("last_notification", notification);
  }
  Future<void> clearNotificationTracking() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('last_notification');
    // Or to remove all notification tracking:
    // final keys = prefs.getKeys().where((k) => k.startsWith('last_notification_'));
    // for (final key in keys) {
    //   await prefs.remove(key);
    // }
  }


  //
// Add these methods to your CachedData class
  Future<void> saveLastSeenNotificationTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_seen_notification', time.toIso8601String());
  }

  Future<DateTime?> getLastSeenNotificationTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timeString = prefs.getString('last_seen_notification');
    return timeString != null ? DateTime.parse(timeString) : null;
  }

  Future<void> saveSeenNotificationIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('seen_notification_ids', ids);
  }

  Future<List<String>> getSeenNotificationIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('seen_notification_ids') ?? [];
  }
//

}
