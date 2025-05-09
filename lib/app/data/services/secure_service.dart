import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../models/beneficiaries/BeneficiariesResponse.dart';
import '../models/login/LoginResponse.dart';
import '../models/register/RegisterResponse.dart';
import '../models/requests/HelpRequestsResponse.dart';
import '../network/dio_client.dart';

class SecureService {
  late Dio apiClient;

  SecureService() {
    apiClient = client();
  }

  // REGISTER
  Future<RegisterResponse?> registerUser({
    required String email,
    required String password
  }) async {
    RegisterResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email,
      "password": password
    };
    String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-user-register.php",
        data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = RegisterResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }


  // LOGIN
  Future<LoginResponse?> loginUser({
    required String email,
    required String password
  }) async {
    LoginResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email,
      "password": password
    };
    String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-user-authenticate.php",
        data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = LoginResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // REQUESTS
  Future<HelpRequestsResponse?> readRequests() async {
    HelpRequestsResponse? responseData;

    // // Convert FormData to a JSON string
    // Map<String, dynamic> formDataMap = {
    //   "email": email,
    //   "password": password
    // };
    // String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-user-read-help-requests.php",
        // data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = HelpRequestsResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // BENEFICIARIES
  Future<BeneficiariesResponse?> readBeneficiaries() async {
    BeneficiariesResponse? responseData;

    // // Convert FormData to a JSON string
    // Map<String, dynamic> formDataMap = {
    //   "email": email,
    //   "password": password
    // };
    // String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-user-read-beneficiaries.php",
        // data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = BeneficiariesResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }


}
