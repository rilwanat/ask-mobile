import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../network/dio_client.dart';

class SecureService {
  late Dio apiClient;

  SecureService() {
    apiClient = client();
  }


}
