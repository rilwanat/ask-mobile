import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/app_strings.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/LoadingScreen.dart';
import '../../../../global/widgets/app_bar.dart';
import '../../../../global/widgets/ask_button.dart';
import '../../../../global/widgets/fade_down_animation.dart';
import '../../../../global/widgets/navbar.dart';
import '../../../../utils/utils.dart';
import '../controllers/home_controller.dart';

class IaskView extends GetView<HomeController> {
  IaskView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: AppColors.askBackground,
      drawer: NavBar(),
      appBar: CustomAppBar(
        onMenuPressed: () {
          controller.scaffoldKey.currentState?.openDrawer();
        },
        onMorePressed: () {
          // controller.scaffoldKey.currentState?.openDrawer();
        },
        title: 'A.S.K',
        backgroundColor: AppColors.askBlue,
      ),
      body: Container(
        height: ScreenSize.height(context),
        width: ScreenSize.width(context),
        child: Obx(() => controller.isLoading
            ? const LoadingScreen()
            :Stack(
          children: [
            Positioned(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),
                  child: Container(
                    height: ScreenSize.height(context),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: ScreenSize.scaleHeight(context, 40),),
                            const SizedBox(height: 30),


                            Obx(() =>
                                (controller.profileData.value!.emailVerified == null
                                || controller.profileData.value!.emailVerified == ""
                                || controller.profileData.value!.emailVerified == "No"
                                ) ?
                            Container(
                              // color: AppColors.askGreen,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      AskStrings.COMPLETE_LEVEL1_VERIFICIATION,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "LatoRegular",
                                        color: AppColors.askText,
                                        height: 1.0,
                                        // letterSpacing: .2,
                                      )
                                  ),
                                  const SizedBox(height: 8,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: AppColors.askBlue,
                                        height: 2,
                                        width: 64,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                  // const SizedBox(height: 20),
                                  // const Text(
                                  //     AuthStrings.LOGIN_SUBHEADER,
                                  //     style: TextStyle(
                                  //       fontSize: 16,
                                  //       fontWeight: FontWeight.w400,
                                  //       fontFamily: "LatoRegular",
                                  //       color: AppColors.askText,
                                  //       // letterSpacing: .2,
                                  //     )
                                  // ),
                                  const SizedBox(height: 0),
                                  // Email Field
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Email: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "LatoRegular",
                                            // letterSpacing: .2,
                                            color: AppColors.askText,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        FadeDownAnimation(
                                          delayMilliSeconds: 400,
                                          duration: 700,
                                          child: TextFormField(
                                            initialValue: controller.profileData.value!.emailAddress,
                                            // controller: controller.loginEmailController,
                                            // focusNode: controller.loginEmailFocusNode,
                                            //cursorColor: AppColors.blue,
                                            decoration: InputDecoration(
                                              hintText: "Email",
                                              // filled: true,
                                              // fillColor: AppColors.white,
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors
                                                      .askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              contentPadding:
                                              const EdgeInsets.only(left: 20),
                                            ),
                                            readOnly: true,
                                            keyboardType:
                                            TextInputType.emailAddress,
                                            style: const TextStyle(
                                              //letterSpacing: 0.7,
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "LatoRegular",
                                            ),
                                            inputFormatters: const [
                                              //FilteringTextInputFormatter.digitsOnly,
                                              //LengthLimitingTextInputFormatter(13),
                                            ],
                                            validator: (value) {
                                              Pattern pattern =
                                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                              RegExp regex = RegExp('$pattern');
                                              if (!regex.hasMatch(value!)) {
                                                return 'Please enter a valid Email Address';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Verification Code Field
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Verification Code: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "LatoRegular",
                                            // letterSpacing: .2,
                                            color: AppColors.askText,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Stack(
                                          alignment: Alignment.centerRight,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey.shade300),
                                                borderRadius: BorderRadius.circular(2),
                                                color: Colors.white,
                                              ),
                                              child:
                                              FadeDownAnimation(
                                                delayMilliSeconds: 400,
                                                duration: 700,
                                                child: TextFormField(
                                                  controller: controller.emailVerificationController,
                                                  // focusNode: controller.loginEmailFocusNode,
                                                  //cursorColor: AppColors.blue,
                                                  decoration: InputDecoration(
                                                    hintText: "Enter Verification Code",
                                                    // fillColor: AppColors.white,
                                                    border: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                        color: AppColors.askBlue,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(8),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                        color: AppColors
                                                            .askBlue,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(8),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                        color: AppColors.askBlue,
                                                      ),
                                                      borderRadius:
                                                      BorderRadius.circular(8),
                                                    ),
                                                    contentPadding:
                                                    const EdgeInsets.only(left: 20),
                                                  ),
                                                  // readOnly: true,
                                                  keyboardType:
                                                  TextInputType.text,
                                                  style: const TextStyle(
                                                    // //letterSpacing: 0.7,
                                                    fontSize: 16,
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "LatoRegular",
                                                  ),
                                                  inputFormatters: const [
                                                    //FilteringTextInputFormatter.digitsOnly,
                                                    //LengthLimitingTextInputFormatter(13),
                                                  ],
                                                  validator: (value) {

                                                  },
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 8,
                                              child: TextButton(
                                                onPressed: () {
                                                  String email = controller.profileData.value!.emailAddress!;

                                                  controller.resendVerificationCode(email: email);
                                                },
                                                style: TextButton.styleFrom(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                  backgroundColor: Colors.grey.shade300,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(2),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'resend',
                                                  style:  TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "LatoRegular",
                                                    // letterSpacing: .2,
                                                    color: AppColors.askText,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),



                                      ],
                                    ),
                                  ),

                                  Container(
                                    width: ScreenSize.width(context),
                                    alignment: Alignment.bottomCenter,
                                    // color: AppColors.askBlue,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        AskButton(
                                            enabled: true,
                                            text: "Submit",
                                            function: () async {

                                              String email = controller.profileData.value!.emailAddress!;
                                              String verificationCode = controller.emailVerificationController.text;

                                              if (verificationCode.isEmpty) {
                                                Utils.showTopSnackBar(
                                                    t: "A.S.K Verification Code",
                                                    m: "Verification code cannot be empty",
                                                    tc: AppColors.white,
                                                    d: 3,
                                                    bc: AppColors.askBlue,
                                                    sp: SnackPosition.TOP);
                                              } else {
                                                await controller.verifyEmail(
                                                  email: email,
                                                  verificationCode: verificationCode,
                                                );
                                              }
                                            },
                                            backgroundColor: AppColors.askBlue,
                                            textColor: AppColors.white,
                                            buttonWidth: ScreenSize.scaleWidth(context, 340),
                                            buttonHeight: ScreenSize.scaleHeight(context, 60),
                                            borderCurve: 26,
                                            border: false,
                                            textSize: 16
                                        ),


                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ) : Container()
                            ),






                            Obx(() =>
                            (controller.profileData.value!.kycStatus != "APPROVED"
                                || controller.profileData.value!.kycStatus == ""
                                || controller.profileData.value!.kycStatus == null
                            ) ?
                            Container(
                              // color: AppColors.askGreen,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      AskStrings.COMPLETE_LEVEL2_VERIFICIATION,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "LatoRegular",
                                        color: AppColors.askText,
                                        height: 1.0,
                                        // letterSpacing: .2,
                                      )
                                  ),
                                  const SizedBox(height: 8,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        color: AppColors.askBlue,
                                        height: 2,
                                        width: 64,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                  // const SizedBox(height: 20),
                                  // const Text(
                                  //     AuthStrings.LOGIN_SUBHEADER,
                                  //     style: TextStyle(
                                  //       fontSize: 16,
                                  //       fontWeight: FontWeight.w400,
                                  //       fontFamily: "LatoRegular",
                                  //       color: AppColors.askText,
                                  //       // letterSpacing: .2,
                                  //     )
                                  // ),
                                  const SizedBox(height: 0),
                                  Container(
                                    // color: AppColors.askOrange,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.askLightRed,
                                      borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 12)),
                                      // border: Border.all(width: 1, color: AppColors.askGray),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            AskStrings.STRICTLY,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "LatoRegular",
                                              color: AppColors.black,
                                              // letterSpacing: .2,
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Email Field
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Email: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "LatoRegular",
                                            // letterSpacing: .2,
                                            color: AppColors.askText,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        FadeDownAnimation(
                                          delayMilliSeconds: 400,
                                          duration: 700,
                                          child: TextFormField(
                                            initialValue: controller.profileData.value!.emailAddress,
                                            // controller: controller.loginEmailController,
                                            // focusNode: controller.loginEmailFocusNode,
                                            //cursorColor: AppColors.blue,
                                            decoration: InputDecoration(
                                              hintText: "Email",
                                              // filled: true,
                                              // fillColor: AppColors.white,
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors
                                                      .askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              contentPadding:
                                              const EdgeInsets.only(left: 20),
                                            ),
                                            readOnly: true,
                                            keyboardType:
                                            TextInputType.emailAddress,
                                            style: const TextStyle(
                                              //letterSpacing: 0.7,
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "LatoRegular",
                                            ),
                                            inputFormatters: const [
                                              //FilteringTextInputFormatter.digitsOnly,
                                              //LengthLimitingTextInputFormatter(13),
                                            ],
                                            validator: (value) {
                                              Pattern pattern =
                                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                              RegExp regex = RegExp('$pattern');
                                              if (!regex.hasMatch(value!)) {
                                                return 'Please enter a valid Email Address';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Phone Number
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Phone Number: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "LatoRegular",
                                            // letterSpacing: .2,
                                            color: AppColors.askText,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        FadeDownAnimation(
                                          delayMilliSeconds: 400,
                                          duration: 700,
                                          child: TextFormField(
                                            // initialValue: controller.profileData.value!.emailAddress,
                                            controller: controller.kycPhoneNumberController,
                                            // focusNode: controller.loginEmailFocusNode,
                                            //cursorColor: AppColors.blue,
                                            decoration: InputDecoration(
                                              hintText: "Enter your Phone Number",
                                              // filled: true,
                                              // fillColor: AppColors.white,
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors
                                                      .askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              contentPadding:
                                              const EdgeInsets.only(left: 20),
                                            ),
                                            readOnly: true,
                                            keyboardType:
                                            TextInputType.emailAddress,
                                            style: const TextStyle(
                                              //letterSpacing: 0.7,
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "LatoRegular",
                                            ),
                                            inputFormatters: const [
                                              //FilteringTextInputFormatter.digitsOnly,
                                              //LengthLimitingTextInputFormatter(13),
                                            ],
                                            validator: (value) {
                                              // Pattern pattern =
                                              //     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                              // RegExp regex = RegExp('$pattern');
                                              // if (!regex.hasMatch(value!)) {
                                              //   return 'Please enter a valid Email Address';
                                              // } else {
                                              //   return null;
                                              // }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Account Number: (10 digits)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Account Number: (10 digits)",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "LatoRegular",
                                            // letterSpacing: .2,
                                            color: AppColors.askText,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        FadeDownAnimation(
                                          delayMilliSeconds: 400,
                                          duration: 700,
                                          child: TextFormField(
                                            // initialValue: controller.profileData.value!.emailAddress,
                                            controller: controller.kycAccountNumberController,
                                            // focusNode: controller.loginEmailFocusNode,
                                            //cursorColor: AppColors.blue,
                                            decoration: InputDecoration(
                                              hintText: "Enter your Account Number",
                                              // filled: true,
                                              // fillColor: AppColors.white,
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors
                                                      .askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              contentPadding:
                                              const EdgeInsets.only(left: 20),
                                            ),
                                            readOnly: true,
                                            keyboardType:
                                            TextInputType.emailAddress,
                                            style: const TextStyle(
                                              //letterSpacing: 0.7,
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "LatoRegular",
                                            ),
                                            inputFormatters: const [
                                              //FilteringTextInputFormatter.digitsOnly,
                                              //LengthLimitingTextInputFormatter(13),
                                            ],
                                            validator: (value) {
                                              // Pattern pattern =
                                              //     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                              // RegExp regex = RegExp('$pattern');
                                              // if (!regex.hasMatch(value!)) {
                                              //   return 'Please enter a valid Email Address';
                                              // } else {
                                              //   return null;
                                              // }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Bank Name:
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Bank Name: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "LatoRegular",
                                            // letterSpacing: .2,
                                            color: AppColors.askText,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        FadeDownAnimation(
                                          delayMilliSeconds: 400,
                                          duration: 700,
                                          child: TextFormField(
                                            // initialValue: controller.profileData.value!.emailAddress,
                                            controller: controller.kycBankNameController,
                                            // focusNode: controller.loginEmailFocusNode,
                                            //cursorColor: AppColors.blue,
                                            decoration: InputDecoration(
                                              hintText: "Select Bank",
                                              // filled: true,
                                              // fillColor: AppColors.white,
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors
                                                      .askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              contentPadding:
                                              const EdgeInsets.only(left: 20),
                                            ),
                                            readOnly: true,
                                            keyboardType:
                                            TextInputType.emailAddress,
                                            style: const TextStyle(
                                              //letterSpacing: 0.7,
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "LatoRegular",
                                            ),
                                            inputFormatters: const [
                                              //FilteringTextInputFormatter.digitsOnly,
                                              //LengthLimitingTextInputFormatter(13),
                                            ],
                                            validator: (value) {
                                              // Pattern pattern =
                                              //     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                              // RegExp regex = RegExp('$pattern');
                                              // if (!regex.hasMatch(value!)) {
                                              //   return 'Please enter a valid Email Address';
                                              // } else {
                                              //   return null;
                                              // }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Gender:
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Gender: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "LatoRegular",
                                            // letterSpacing: .2,
                                            color: AppColors.askText,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        FadeDownAnimation(
                                          delayMilliSeconds: 400,
                                          duration: 700,
                                          child: TextFormField(
                                            // initialValue: controller.profileData.value!.emailAddress,
                                            controller: controller.kycGenderController,
                                            // focusNode: controller.loginEmailFocusNode,
                                            //cursorColor: AppColors.blue,
                                            decoration: InputDecoration(
                                              hintText: "Select Gender",
                                              // filled: true,
                                              // fillColor: AppColors.white,
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors
                                                      .askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              contentPadding:
                                              const EdgeInsets.only(left: 20),
                                            ),
                                            readOnly: true,
                                            keyboardType:
                                            TextInputType.emailAddress,
                                            style: const TextStyle(
                                              //letterSpacing: 0.7,
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "LatoRegular",
                                            ),
                                            inputFormatters: const [
                                              //FilteringTextInputFormatter.digitsOnly,
                                              //LengthLimitingTextInputFormatter(13),
                                            ],
                                            validator: (value) {
                                              // Pattern pattern =
                                              //     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                              // RegExp regex = RegExp('$pattern');
                                              // if (!regex.hasMatch(value!)) {
                                              //   return 'Please enter a valid Email Address';
                                              // } else {
                                              //   return null;
                                              // }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // State of Residence:
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "State of Residence: ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "LatoRegular",
                                            // letterSpacing: .2,
                                            color: AppColors.askText,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        FadeDownAnimation(
                                          delayMilliSeconds: 400,
                                          duration: 700,
                                          child: TextFormField(
                                            // initialValue: controller.profileData.value!.emailAddress,
                                            controller: controller.kycStateOfResidenceController,
                                            // focusNode: controller.loginEmailFocusNode,
                                            //cursorColor: AppColors.blue,
                                            decoration: InputDecoration(
                                              hintText: "Select Residence",
                                              // filled: true,
                                              // fillColor: AppColors.white,
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors
                                                      .askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              contentPadding:
                                              const EdgeInsets.only(left: 20),
                                            ),
                                            readOnly: true,
                                            keyboardType:
                                            TextInputType.emailAddress,
                                            style: const TextStyle(
                                              //letterSpacing: 0.7,
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "LatoRegular",
                                            ),
                                            inputFormatters: const [
                                              //FilteringTextInputFormatter.digitsOnly,
                                              //LengthLimitingTextInputFormatter(13),
                                            ],
                                            validator: (value) {
                                              // Pattern pattern =
                                              //     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                              // RegExp regex = RegExp('$pattern');
                                              // if (!regex.hasMatch(value!)) {
                                              //   return 'Please enter a valid Email Address';
                                              // } else {
                                              //   return null;
                                              // }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 8,),
                                  Container(
                                    // color: AppColors.askOrange,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.askLightRed,
                                      borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 12)),
                                      // border: Border.all(width: 1, color: AppColors.askGray),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            AskStrings.SELFIE,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "LatoRegular",
                                              color: AppColors.black,
                                              // letterSpacing: .2,
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),


                                  Container(
                                    width: ScreenSize.width(context),
                                    alignment: Alignment.bottomCenter,
                                    // color: AppColors.askBlue,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        AskButton(
                                            enabled: true,
                                            text: "Verify KYC",
                                            function: () async {

                                              // String email = controller.profileData.value!.emailAddress!;
                                              // String verificationCode = controller.emailVerificationController.text;
                                              //
                                              // if (verificationCode.isEmpty) {
                                              //   Utils.showTopSnackBar(
                                              //       t: "A.S.K Verification Code",
                                              //       m: "Verification code cannot be empty",
                                              //       tc: AppColors.white,
                                              //       d: 3,
                                              //       bc: AppColors.askBlue,
                                              //       sp: SnackPosition.TOP);
                                              // } else {
                                              //   await controller.verifyEmail(
                                              //     email: email,
                                              //     verificationCode: verificationCode,
                                              //   );
                                              // }
                                            },
                                            backgroundColor: AppColors.askBlue,
                                            textColor: AppColors.white,
                                            buttonWidth: ScreenSize.scaleWidth(context, 340),
                                            buttonHeight: ScreenSize.scaleHeight(context, 60),
                                            borderCurve: 26,
                                            border: false,
                                            textSize: 16
                                        ),


                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ) : Container()
                            ),











                        ]),
                    ),
                  ),
                )),

            // Obx(() => controller.showContinue ? Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: Column(
            //     children: [
            //       Container(
            //         // color: AppColors.xippBlue,
            //         width: ScreenSize.width(context),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             const SizedBox(height: 10,),
            //             AskButton(
            //                 enabled: true,
            //                 text: "Login",
            //                 function: () async {
            //                   // controller.clearAuthToken();
            //
            //                   String email = controller.loginEmailController.text;
            //                   String password = controller.loginPasswordController.text;
            //
            //                   if (email.isEmpty || password.isEmpty) {
            //                     Utils.showTopSnackBar(
            //                         t: "A.S.K Login",
            //                         m: "Email, password cannot be empty",
            //                         tc: AppColors.white,
            //                         d: 3,
            //                         bc: AppColors.askBlue,
            //                         sp: SnackPosition.TOP);
            //                   } else {
            //                     await controller.loginUser(
            //                       email: email,
            //                       password: password,
            //                     );
            //                   }
            //                 },
            //                 backgroundColor: AppColors.askBlue,
            //                 textColor: AppColors.white,
            //                 buttonWidth: ScreenSize.scaleWidth(context, 340),
            //                 buttonHeight: ScreenSize.scaleHeight(context, 60),
            //                 borderCurve: 26,
            //                 border: false,
            //                 textSize: 16
            //             ),
            //             const SizedBox(
            //               height: 16,
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: <Widget>[
            //                 const Text(
            //                   "Don't have an account? ",
            //                   style: TextStyle(
            //                       fontSize: 14,
            //                       fontWeight: FontWeight.w500,
            //                       fontFamily: "LatoRegular",
            //                       color: AppColors.askBlue
            //                   ),
            //                 ),
            //                 GestureDetector(
            //                   onTap: () {
            //                     // controller.clearOnboardingFields();
            //
            //                     Get.off(() => RegisterView(),
            //                         transition: Transition.fadeIn, // Built-in transition type
            //                         duration: Duration(milliseconds: 500),
            //                         binding: AuthBinding()
            //                     );
            //                   },
            //                   child: const Text(
            //                     "Register now",
            //                     style: TextStyle(
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.w700,
            //                         fontFamily: "LatoRegular",
            //                         // letterSpacing: .2,
            //                         color: AppColors.askBlue),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             const SizedBox(
            //               height: 30,
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ) : Container() )
          ],
        ),),
      ),
    );
  }
}
