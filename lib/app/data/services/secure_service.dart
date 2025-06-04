import 'dart:convert';
import 'dart:io';
import 'package:ask_mobile/app/data/models/banks/BankCodeResponse.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../models/beneficiaries/BeneficiariesResponse.dart';
import '../models/create_help_request/CreateHelpRequestResponse.dart';
import '../models/cryptos/CryptosResponse.dart';
import '../models/dnq/DnqResponse.dart';
import '../models/dollar_exchange/DollarExchangeResponse.dart';
import '../models/donations/DonationsResponse.dart';
import '../models/login/LoginResponse.dart';
import '../models/my_requests/MyHelpRequestsResponse.dart';
import '../models/nominate/NominateResponse.dart';
import '../models/paystack_subscriptions/PaystackSubscriptionsResponse.dart';
import '../models/profile/ProfileResponse.dart';
import '../models/register/RegisterResponse.dart';
import '../models/requests/HelpRequestsResponse.dart';
import '../models/resend_verification/ResendVerificationCodeResponse.dart';
import '../models/sponsors/SponsorsResponse.dart';
import '../models/status_message/StatusMessageResponse.dart';
import '../models/verify_email/VerifyEmailResponse.dart';
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
      "password": password,
      "platform": "mobile",
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

  // MY HELP REQUESTS
  Future<MyHelpRequestsResponse?> readMyHelpRequests({
    required String email,
}) async {
    MyHelpRequestsResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email
    };
    // String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-my-help-request-get.php",
        data: formDataMap,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = MyHelpRequestsResponse.fromJson(response.data);
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

  // SPONSORS
  Future<SponsorsResponse?> readSponsors() async {
    SponsorsResponse? responseData;

    // // Convert FormData to a JSON string
    // Map<String, dynamic> formDataMap = {
    //   "email": email,
    //   "password": password
    // };
    // String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-user-read-sponsors.php",
        // data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = SponsorsResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // CRYPTOS
  Future<CryptosResponse?> readCryptos() async {
    CryptosResponse? responseData;

    // // Convert FormData to a JSON string
    // Map<String, dynamic> formDataMap = {
    //   "email": email,
    //   "password": password
    // };
    // String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-user-read-cryptos.php",
        // data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = CryptosResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // DONATIONS
  Future<DonationsResponse?> readDonations() async {
    DonationsResponse? responseData;

    // // Convert FormData to a JSON string
    // Map<String, dynamic> formDataMap = {
    //   "email": email,
    //   "password": password
    // };
    // String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-user-read-donations.php",
        // data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = DonationsResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // DOLLAREXCHANGE
  Future<DollarExchangeResponse?> readDollarExchange() async {
    DollarExchangeResponse? responseData;

    // // Convert FormData to a JSON string
    // Map<String, dynamic> formDataMap = {
    //   "email": email,
    //   "password": password
    // };
    // String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/dollar-rate.php",
        // data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = DollarExchangeResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // PAYSTACKSUBSCRIPTIONS
  Future<PaystackSubscriptionsResponse?> readPaystackSubscriptions() async {
    PaystackSubscriptionsResponse? responseData;

    // // Convert FormData to a JSON string
    // Map<String, dynamic> formDataMap = {
    //   "email": email,
    //   "password": password
    // };
    // String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/paystack-subscriptions.php",
        // data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = PaystackSubscriptionsResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // PROFILE
  Future<ProfileResponse?> getUserProfile({
    required String email
  }) async {
    ProfileResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email
    };
    String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-mobile-user-profile.php",
        data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = ProfileResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // RESEND VERFICATION
  Future<ResendVerificationCodeResponse?> resendVerificationCode({
    required String email
  }) async {
    ResendVerificationCodeResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email
    };
    String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-user-resend-verification-code.php",
        data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = ResendVerificationCodeResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // VERFIY EMAIL
  Future<VerifyEmailResponse?> verifyEmail({
    required String email,
    required String verificationCode,
  }) async {
    VerifyEmailResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email,
      "verificationCode": verificationCode,
    };
    String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-user-verify-email-code.php",
        data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = VerifyEmailResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // BANKCODES
  Future<BankCodeResponse?> readBankCodes() async {
    BankCodeResponse? responseData;

    // // Convert FormData to a JSON string
    // Map<String, dynamic> formDataMap = {
    //   "email": email,
    //   "password": password
    // };
    // String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.get(
        "/response/ask-read-bank-codes.php",
        // data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = BankCodeResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // UPDATE USER KYC
  Future<StatusMessageResponse?> updateUserKyc({
    required String email,
    required String phoneNumber,
    required String accountNumber,
    required String bankName,
    required String bankCode,
    required String gender,
    required String residence,
  }) async {
    StatusMessageResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email,
      "phoneNumber": phoneNumber,
      "accountNumber": accountNumber,
      "bankName": bankName,
      "bankCode": bankCode,
      "gender": gender,
      "residence": residence,
    };
    String formDataString = json.encode(formDataMap);

    print(formDataString);


    try {
      final response = await apiClient.post(
        "/response/ask-user-update-kyc.php",
        data: formDataString,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = StatusMessageResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // UPDATE USER KYC SELFIE
  Future<StatusMessageResponse?> updateUserKycSelfie({
    required String email,
    required File selfieImage,
    required String userId,
  }) async {
    StatusMessageResponse? responseData;

    // Create FormData for multipart upload
    FormData formData = FormData.fromMap({
      "email": email,
      "image": await MultipartFile.fromFile(
          selfieImage.path
        // ,
        // filename: '$userId-selfie.jpg',
      ),
    });

    // print(formDataString);


    try {
      final response = await apiClient.post(
        "/response/ask-user-update-selfie-image.php",
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data'
          }, // Specify the content type
        ),
      );

      responseData = StatusMessageResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }


  // INCREMENT DNQ
  Future<DnqResponse?> incrementDNQ({
    required String email,
    required String price,
    required String type,
    required String reference,
  }) async {
    DnqResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email,
      "price": price,
      "type": type,
      "reference": reference
    };
    String formDataString = json.encode(formDataMap);

    print(formDataString);

  // {
  //      "status": true,
  //   "message": "message",
  //    "dnq": 1,
  //    "new_vote_weight": 1,
  //    "userData": []
  //  }

    try {
      final response = await apiClient.post(
        "/response/ask-increment-dnq.php",
        data: formDataMap,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = DnqResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }


  // CREATEREQUEST
  Future<CreateHelpRequestResponse?> createHelpRequest({
    required String email,
    required String description,
    required String fullname,
    required File image,
  }) async {
    CreateHelpRequestResponse? responseData;

    // Create FormData for multipart upload
    FormData formData = FormData.fromMap({
      "email": email,
      "description": description,
      "fullname": fullname,
      "image": await MultipartFile.fromFile(
          image.path,
        contentType: MediaType("image", "jpeg"),
      ),
    });

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-my-help-request-create.php",
        data: formData,
        options: Options(
          headers: {
            // 'Content-Type': 'multipart/form-data'
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = CreateHelpRequestResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // UPDATEREQUESTIMAGE
  Future<CreateHelpRequestResponse?> updateHelpRequestImage({
    required String email,
    required File image
  }) async {
    CreateHelpRequestResponse? responseData;

    // Create FormData for multipart upload
    FormData formData = FormData.fromMap({
      "email": email,
      "image": await MultipartFile.fromFile(
        image.path,
        contentType: MediaType("image", "jpeg"),
      ),
    });

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-my-help-request-update-image.php",
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data'
            // 'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = CreateHelpRequestResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // UPDATEREQUEST
  Future<CreateHelpRequestResponse?> updateHelpRequest({
    required String email,
    required String description,
    required String helpToken
  }) async {
    CreateHelpRequestResponse? responseData;

    // Create FormData for multipart upload
    FormData formData = FormData.fromMap({
      "email": email,
      "description": description,
      "help_token": helpToken
    });

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-my-help-request-update.php",
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data'
          }, // Specify the content type
        ),
      );

      responseData = CreateHelpRequestResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // DELETEREQUEST
  Future<CreateHelpRequestResponse?> deleteHelpRequest({
    required String email,
    required String helpToken
  }) async {
    CreateHelpRequestResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email,
      "helpToken": helpToken
    };
    String formDataString = json.encode(formDataMap);

    print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-my-help-request-delete.php",
        data: formDataMap,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = CreateHelpRequestResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }

  // HANDLENOMINATE
  Future<NominateResponse?> handleNominate({
    required String email,
    required String helpToken,
    required String fingerPrint
  }) async {
    NominateResponse? responseData;

    // // Create FormData for multipart upload
    // FormData formData = FormData.fromMap({
    //   "email": email,
    //   "description": description,
    //   "fullname": fullname
    // });
    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email,
      "helpToken": helpToken,
      "fingerPrint": fingerPrint
    };
    String formDataString = json.encode(formDataMap);

    print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-user-nominate.php",
        data: formDataMap,
        options: Options(
          headers: {
            'Content-Type': 'application/json'
          }, // Specify the content type
        ),
      );

      responseData = NominateResponse.fromJson(response.data);
      return responseData;
    } catch (e, s) {
      print(s);
      rethrow;
    }
  }


  // SEND MOBILE RESET CODE PASSWORD
  Future<LoginResponse?> sendMobileResetPassordCode({
    required String email
  }) async {
    LoginResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email
    };
    String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/mobile-forgot-password.php",
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

  // VALIDATE RESET CODE
  Future<LoginResponse?> validateMobileResetPasswordCode({
    required String email,
    required String emailCode,
  }) async {
    LoginResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email,
      "verificationCode": emailCode,
    };
    String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/mobile-forgot-password-validate-code.php",
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

  // RESET PASSWORD
  Future<LoginResponse?> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    LoginResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email,
      "newPassword": newPassword,
    };
    String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/reset-password.php",
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

  // LOGIN
  Future<LoginResponse?> loginUserGoogleDirect({
    required String email,
    // required String password
  }) async {
    LoginResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email,
      "platform": "mobile",
      // "password": password
    };
    String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-user-authenticate-google-apple.php",
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

  // LOGIN
  Future<LoginResponse?> registerUserGoogleDirect({
    required String email,
    // required String password
  }) async {
    LoginResponse? responseData;

    // Convert FormData to a JSON string
    Map<String, dynamic> formDataMap = {
      "email": email,
      // "password": password
    };
    String formDataString = json.encode(formDataMap);

    // print(formDataString);

    try {
      final response = await apiClient.post(
        "/response/ask-user-register-google-apple.php",
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

}
