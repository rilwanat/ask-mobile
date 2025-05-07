import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class Utils {
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void showTopSnackBar(
      {required String t,
        required String m,
        required Color tc,
        required int d,
        required Color bc,
        required SnackPosition sp}) {
    Get.snackbar(t, m,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        snackPosition: sp,
        colorText: tc,
        duration: Duration(seconds: d),
        backgroundColor: bc);
  }
}
