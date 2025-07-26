import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getx;
import '../../routes/app_pages.dart';
import '../storage/cached_data.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio client() {
  final CachedData cachedData = CachedData();
  final Dio dio = Dio();


  final isLive = dotenv.getBool('LIVE_MODE');
  final apiUrl = dotenv.get(isLive ? 'LIVE_API_BASE_URL' : 'DEMO_API_BASE_URL');

  dio.options.baseUrl = apiUrl;
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  dio.options.sendTimeout = const Duration(seconds: 30);

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      options.headers["Accept"] = "application/json";
      options.headers["Content-Type"] = "application/json";

      final String? accessTokenResponse = await cachedData.getAuthToken();
      final String? token = accessTokenResponse;

      // debugPrint("DIO token: $token");

      if (token != null && token.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $token";

        if (JwtDecoder.isExpired(token)) {
          // debugPrint("Token expired. Logging out...");
          await cachedData.clearAllSavedDetails(userType: "");
          // // authController.logout(); // Trigger logout
          // getx.Get.offAllNamed(Routes.LOGIN);
          return handler.reject(
            DioError(requestOptions: options, error: 'Token expired'),
          );
        }

        //
        // Decode the JWT and extract the payload
        try {
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

          // Extract creation (iat) and expiry (exp) times
          int? issuedAt = decodedToken['iat'];
          int? expiry = decodedToken['exp'];

          // Convert the times to human-readable format
          DateTime? issuedAtTime = issuedAt != null
              ? DateTime.fromMillisecondsSinceEpoch(issuedAt * 1000)
              : null;
          DateTime? expiryTime = expiry != null
              ? DateTime.fromMillisecondsSinceEpoch(expiry * 1000)
              : null;

          // debugPrint('Token Issued At: $issuedAtTime');
          // debugPrint('Token Expiry At: $expiryTime');
        } catch (e) {
          debugPrint('Error decoding token: $e');
        }
        //

      }

      if (options.data is FormData) {
        final FormData formData = options.data as FormData;
        print(formData.fields);
      }

      // debugPrint('Request URI: ${options.uri}');
      // debugPrint('Request Headers: ${options.headers}');
      // debugPrint('Request Data: ${options.data}');
      return handler.next(options); // continue
    },
    onError: (DioException e, handler) {
      // Do something with response error
      debugPrint('======================');
      debugPrint('DioError: $e');
      debugPrint('Response data: ${e.response?.data}');
      debugPrint('Error message: ${e.message}');
      debugPrint('======================');
      return handler.next(e); // continue
    },
  ));

  return dio;
}
