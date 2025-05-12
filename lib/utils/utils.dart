import 'dart:math';

import 'package:ask_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:intl/intl.dart';

import '../app/modules/home/bindings/home_binding.dart';
import '../app/modules/home/views/home_view.dart';
import '../global/app_color.dart';
import '../global/screen_size.dart';
import '../global/widgets/ask_button.dart';
import '../global/widgets/fade_down_animation.dart';

class Utils {

  // HomeController homeCtrl = Get.find<HomeController>();

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
  static String formatDate(String isoDateTime) {
    try{
      DateTime dateTime = DateTime.parse(isoDateTime);
      String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
      return formattedDate;
    } catch(e) {
      return "Day Month";
    }
  }

  static String formatDateWithDay(String isoDateTime) {
    try{
      DateTime dateTime = DateTime.parse(isoDateTime);
      String formattedDate = DateFormat('EEE, d MMM, yyyy').format(dateTime);
      return formattedDate;
    } catch(e) {
      return "Day Month Year";
    }
  }

  static String formatDayWithTime(String isoDateTime) {
    try {
      DateTime dateTime = DateTime.parse(isoDateTime);

      String day = DateFormat('d').format(dateTime);
      String suffix = getDaySuffix(int.parse(day));

      String formattedDate = "${DateFormat('MMM').format(dateTime)} $day$suffix, ${DateFormat('HH:mm:ss').format(dateTime)}";

      return formattedDate;
    } catch (e) {
      return "Invalid Date";
    }
  }

// Function to get ordinal suffix (st, nd, rd, th)
  static String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return "th";
    switch (day % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }


  static void showInformationDialog({
    required bool? status,
    required String title,
    required String message,
  }) async {

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.askBackground,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(  // This is what you're missing
            borderRadius: BorderRadius.circular(16.0),  // Adjust radius as needed
            side: BorderSide(
              color: AppColors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          elevation: 8,
          content: Container(
            height: ScreenSize.height(context) * 0.5,
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: AppColors.askText,
                      fontFamily: "LatoRegular",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: FadeDownAnimation(
                    delayMilliSeconds: 400,
                    duration: 700,
                    child:
                    status == null ? const Icon(Icons.info, size: 70, color: AppColors.askBlue) :
                    status == false ? const Icon(Icons.error, size: 70, color: AppColors.red) :
                    const Icon(Icons.check, size: 70, color: AppColors.askGreen),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),
                  child: FadeDownAnimation(
                    delayMilliSeconds: 400,
                    duration: 700,
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.askText,
                        fontFamily: "LatoRegular",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AskButton(
                        enabled: true,
                        text: "Okay",
                        function: () {
                          Navigator.pop(context);



                          // if (message == "Account with phone number already exists.") {
                          //   Get.to(() => const LoginView(),
                          //       transition: Transition.fadeIn, // Built-in transition type
                          //       duration: const Duration(milliseconds: 500),
                          //       binding: AuthBinding()
                          //   );
                          // }

                          if (message == "Email verification successful.") {
                            Get.find<HomeController>().handleNavigation(0);
                            Get.find<HomeController>().homeGetUserProfileFromServer();
                          }

                          if (message == "Image and path updated successfully.") {
                            Get.find<HomeController>().handleNavigation(0);
                            Get.find<HomeController>().homeGetUserProfileFromServer();
                          }


                        },
                        backgroundColor: AppColors.askBlue,
                        textColor: AppColors.white,
                        buttonWidth: ScreenSize.width(context) * .4,
                        buttonHeight: ScreenSize.scaleHeight(context, 54),
                        borderCurve: 26,
                        border: false,
                        textSize: 14,
                      ),
                    ),


                    (message == "Image and path updated successfully.") ? Expanded(child: AskButton(
                      enabled: true,
                      text: "Boost",
                      function: () {
                        Navigator.pop(context);
//goto donate page

                      },
                      backgroundColor: AppColors.askBlue,
                      textColor: AppColors.white,
                      buttonWidth: ScreenSize.width(context) * .4,
                      buttonHeight: ScreenSize.scaleHeight(context, 54),
                      borderCurve: 26,
                      border: false,
                      textSize: 14,
                    )) : Container(),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  static String getRandomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
  }

  static int getRandomInt(int max) {
    return Random().nextInt(max);
  }
  static String generateRandomStatus() {
    return Random().nextInt(2) == 0 ? "success" : "false";
  }
  static double generateRandomAmount() {
    final random = Random();
    int wholePart =
    random.nextInt(1000); // Generate random integer part (0 to 999)
    int fractionalPart =
    random.nextInt(100); // Generate random fractional part (0 to 99)

    // Combine whole part and fractional part as a double
    return double.parse('$wholePart.$fractionalPart');
  }
}
