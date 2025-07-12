import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DefaultController extends GetxController {
  //TODO: Implement DefaultController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void handleDeepLink(String requestId) {
    // Your deep link handling logic here
    debugPrint('Processing deep link request: $requestId');
    // Example: scrollToNewRequestViaHelptoken(requestId);
  }
}
