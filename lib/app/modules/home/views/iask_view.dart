import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../global/app_color.dart';
import '../../../../global/app_strings.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/loading_screen.dart';
import '../../../../global/widgets/app_bar.dart';
import '../../../../global/widgets/ask_button.dart';
import '../../../../global/widgets/fade_down_animation.dart';
import '../../../../global/widgets/navbar.dart';
import '../../../../utils/utils.dart';
import '../controllers/home_controller.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../../global/widgets/BannerAdExample.dart';

class IaskView extends GetView<HomeController> {
  IaskView({super.key});

  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      // key: _scaffoldKey,
      backgroundColor: AppColors.askBackground,
      drawer: NavBar(),
      appBar: CustomAppBar(
        onMenuPressed: () {
          controller.scaffoldKey.currentState?.openDrawer();
          // _scaffoldKey.currentState?.openDrawer();
        },
        onMorePressed: () {
        },
        title: 'A.S.K',
        backgroundColor: AppColors.askBlue,
      ),
      body: Container(
        height: ScreenSize.height(context),
        width: ScreenSize.width(context),
        child: Obx(() => controller.isLoading
            ? const LoadingScreen()
            : Stack(
          children: [
            Positioned(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),
                  child: Container(
                    height: ScreenSize.height(context),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                // color: AppColors.askBlue,
                                height: AdSize.banner.height.toDouble(), // 50.0 for standard banner
                                child: BannerAdExample(),
                              ),
                            ),
                            //

                            SizedBox(height: 10,),

                            SizedBox(height: 8,),


                            Obx(() =>
                            (
                                (
                                    controller.profileData.value!.emailVerified == null
                                || controller.profileData.value!.emailVerified == ""
                                || controller.profileData.value!.emailVerified == "No"
                                )
                                && controller.profileData.value!.isCheat != "Yes"
                            )
                                ?
                            //KYC EMAIL
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
                                      ),
                                    textAlign: TextAlign.center,
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
                                                    borderRadius: BorderRadius.circular(8),
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
                            )
                                :

                            //KYC ACCOUNT
                            Obx(() =>
                            (
                                (
                                    controller.profileData.value!.kycStatus != "APPROVED"
                                || controller.profileData.value!.kycStatus == ""
                                || controller.profileData.value!.kycStatus == null
                            )
                                    && controller.profileData.value!.isCheat != "Yes"
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
                                    ),
                                    textAlign: TextAlign.center,
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
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
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
                                            maxLength: 10,
                                            decoration: InputDecoration(
                                              hintText: "Enter your Phone Number: (10 digits)",
                                              // filled: true,
                                              // fillColor: AppColors.white,
                                              counterText: "",
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
                                              prefixIcon: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 0, left: 8),
                                                child: Container(
                                                  width: 100,
                                                  height: 40,
                                                  // color: AppColors.orange,
                                                  child: Center(
                                                    child: IgnorePointer(
                                                      ignoring: true,
                                                      child: CountryCodePicker(
                                                        enabled: false,
                                                        onChanged: null,//controller.onCountryChanged,
                                                        builder: (countryCode) {
                                                          return Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                              horizontal: 8.0,
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Image.asset(
                                                                  countryCode!
                                                                      .flagUri!,
                                                                  package:
                                                                  'country_code_picker',
                                                                  width: 22.0,
                                                                ),
                                                                const SizedBox(
                                                                    width: 6.0),
                                                                Text(
                                                                  controller
                                                                      .countryCode,
                                                                  style:
                                                                  const TextStyle(
                                                                    fontSize:
                                                                    13.5,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                    fontFamily:
                                                                    "LatoRegular",
                                                                    // letterSpacing: .2,
                                                                    color: AppColors
                                                                        .askText,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 4),
                                                                const Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_outlined,
                                                                  color: AppColors
                                                                      .askText,
                                                                  size: 14,
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        initialSelection: 'NG',
                                                        showCountryOnly: true,
                                                        showOnlyCountryWhenClosed:
                                                        true,
                                                        // alignLeft: true,
                                                        showFlag: true,
                                                        showDropDownButton: false,
                                                        hideMainText: true,
                                                        flagWidth: 40.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // readOnly: true,
                                            keyboardType:
                                            TextInputType.number,
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
                                            maxLength: 10,
                                            decoration: InputDecoration(
                                              hintText: "Enter your Account Number",
                                              // filled: true,
                                              // fillColor: AppColors.white,
                                              counterText: "",
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
                                            TextInputType.number,
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
                                          child: SizedBox(
                                              width: ScreenSize.width(context),
                                              child: TextFormField(
                                                // initialValue: controller.profileData.value!.emailAddress,
                                                controller: controller.kycBankNameController,
                                                // focusNode: controller.loginEmailFocusNode,
                                                //cursorColor: AppColors.blue,
                                                // maxLength: 10,
                                                decoration: InputDecoration(
                                                  hintText: "Enter Bank Name",
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
                                                TextInputType.text,
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
                                                onTap: () {
                                                  controller.showBanksDialog();
                                                },
                                              )
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
                                          child: SizedBox(
                                              width: ScreenSize.width(context),
                                              child: TextFormField(
                                                // initialValue: controller.profileData.value!.emailAddress,
                                                controller: controller.kycGenderController,
                                                // focusNode: controller.loginEmailFocusNode,
                                                //cursorColor: AppColors.blue,
                                                // maxLength: 10,
                                                decoration: InputDecoration(
                                                  hintText: "Enter Gender",
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
                                                TextInputType.text,
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
                                                onTap: () {
                                                  controller.showGenderDialog();
                                                },
                                              )
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
                                          child: SizedBox(
                                              width: ScreenSize.width(context),
                                              child: TextFormField(
                                                // initialValue: controller.profileData.value!.emailAddress,
                                                controller: controller.kycStateOfResidenceController,
                                                // focusNode: controller.loginEmailFocusNode,
                                                //cursorColor: AppColors.blue,
                                                // maxLength: 10,
                                                decoration: InputDecoration(
                                                  hintText: "Enter State of Residence",
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
                                                TextInputType.text,
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
                                                onTap: () {
                                                  controller.showStateOfResidenceDialog();
                                                },
                                              )
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
                                        Expanded(
                                          child: Text(
                                              AskStrings.SELFIE,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "LatoRegular",
                                                color: AppColors.black,
                                                // letterSpacing: .2,
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8,),
                                  const SizedBox(height: 16),
                                  // Camera Preview with Loading State
                                  Obx(() {
                                    return
                                      controller.imagePath.isNotEmpty
                                          ? Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.file(
                                            File(controller.imagePath.value),
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                          :
                                      controller.isCameraInitialized.value
                                          ? Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: SizedBox(
                                              width: 200,
                                              height: 200,
                                              child: FittedBox(
                                                fit: BoxFit.cover, // Ensures the center crop effect
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  width: controller.cameraController.value!.value.previewSize!.height,
                                                  height: controller.cameraController.value!.value.previewSize!.width,
                                                  child: CameraPreview(controller.cameraController.value!),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )

                                          : Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 200,
                                            width: 200,
                                            color: Colors.grey[200],
                                            child: Center(
                                              child: Text(
                                                'Camera not initialized',
                                                style: TextStyle(color: Colors.grey[600]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                  }),


                                  const SizedBox(height: 8,),
                                  const SizedBox(height: 8,),
                                  // Take Picture Button
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ScreenSize.scaleWidth(context, 24)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Visibility(
                                          // visible: controller.isCameraInitialized.value ? false : true,
                                          visible: true,
                                          child: AskButton(
                                            enabled: controller.isCameraInitialized.value ? false : true,
                                            text: (controller.imagePath.value == "" && !controller.isCameraInitialized.value) ? "Camera" : "Retake",
                                            function: () async {

                                              if (controller.isCameraInitialized.value) {
                                                // Utils.showTopSnackBar(
                                                //     t: "A.S.K Camera",
                                                //     m: "Already started",
                                                //     tc: AppColors.white,
                                                //     d: 3,
                                                //     bc: AppColors.askBlue,
                                                //     sp: SnackPosition.TOP);
                                                Utils.showInformationDialog(status: null, title: 'A.S.K KYC Camera', message: "Already started. Take your selfie ;)");
                                                return;
                                              }

                                              controller.imagePath.value = "";
                                              if (!controller.isCameraInitialized.value) {
                                                await controller.initializeCamera();
                                              }

                                              // if (controller.cameraController.value != null) {
                                              //   await controller.takePicture();
                                              // }
                                            },
                                            backgroundColor: controller.isCameraInitialized.value ? AppColors.askGray : AppColors.askBlue,
                                            textColor: controller.isCameraInitialized.value ? AppColors.askText : AppColors.white,
                                            buttonWidth: ScreenSize.scaleWidth(context, 140),
                                            buttonHeight: ScreenSize.scaleHeight(context, 48),
                                            borderCurve: 26,
                                            border: false,
                                            textSize: 14,
                                          ),
                                        ),

                                        const SizedBox(width: 10,),

                                        AskButton(
                                          enabled: true,
                                          text: "Take Selfie",
                                          function: () async {
                                            if (!controller.isCameraInitialized.value) {
                                              return;
                                            }



                                            if (controller.cameraController.value != null) {
                                              await controller.takePicture();
                                            }
                                          },
                                          backgroundColor: !controller.isCameraInitialized.value ? AppColors.askGray : AppColors.askBlue,
                                          textColor: !controller.isCameraInitialized.value ? AppColors.askText : AppColors.white,
                                          buttonWidth: ScreenSize.scaleWidth(context, 140),
                                          buttonHeight: ScreenSize.scaleHeight(context, 48),
                                          borderCurve: 26,
                                          border: false,
                                          textSize: 14,
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
                                            text: "Submit", //"""Verify KYC",
                                            function: () async {



                                              String email = controller.profileData.value!.emailAddress!;

                                              String phoneNumber = controller.countryCode + controller.kycPhoneNumberController.text;
                                              String accountNumber = controller.kycAccountNumberController.text;
                                              String bankName = controller.kycBankNameController.text;
                                              String bankCode = controller.selectedBankCode;
                                              String gender = controller.kycGenderController.text;
                                              String stateOfResidence = controller.kycStateOfResidenceController.text;

                                              String imagePath = controller.imagePath.value;


                                              List<String> missingFields = [];
                                              if (phoneNumber.isEmpty || phoneNumber.length == 4) {
                                                missingFields.add("Phone Number");
                                              }
                                              if (phoneNumber.length != 14) {
                                                missingFields.add("10-digit Phone Number ");
                                              }
                                              if (accountNumber.isEmpty) {
                                                missingFields.add("Account Number");
                                              }
                                              if (accountNumber.length != 10) {
                                                missingFields.add("10-digit Account Number ");
                                              }
                                              if (bankName.isEmpty) {
                                                missingFields.add("Bank Name");
                                              }
                                              if (gender.isEmpty) {
                                                missingFields.add("Gender");
                                              }
                                              if (stateOfResidence.isEmpty) {
                                                missingFields.add("State of Residence");
                                              }
                                              if (imagePath.isEmpty) {
                                                missingFields.add("Selfie");
                                              }


                                              if (missingFields.isNotEmpty) {
                                                // Utils.showTopSnackBar(
                                                //     t: "A.S.K Verify KYC",
                                                //     m: "KYC selfie and text fields cannot be empty",
                                                //     tc: AppColors.white,
                                                //     d: 3,
                                                //     bc: AppColors.askBlue,
                                                //     sp: SnackPosition.TOP);
                                                // Utils.showInformationDialog(status: false, title: 'A.S.K Update Kyc', message: "KYC selfie and text fields cannot be empty");
                                                Utils.showInformationDialog(
                                                  status: false,
                                                  title: 'A.S.K Update Kyc',
                                                  message: "The following fields cannot be empty:\n${missingFields.join('\n')}",
                                                );
                                              } else {
                                                // Utils.showTopSnackBar(
                                                //     t: "A.S.K Verify KYC",
                                                //     m:
                                                //     "${phoneNumber}\n"
                                                //         "${accountNumber}\n"
                                                //         "${bankName}\n"
                                                //         "${bankCode}\n"
                                                //         "${gender}\n"
                                                //         "${stateOfResidence}\n"
                                                //         "${imagePath}\n",
                                                //     tc: AppColors.white,
                                                //     d: 3,
                                                //     bc: AppColors.askBlue,
                                                //     sp: SnackPosition.TOP);

                                                // print(
                                                //   "${phoneNumber}\n"
                                                //       "${accountNumber}\n"
                                                //       "${bankName}\n"
                                                //       "${bankCode}\n"
                                                //       "${gender}\n"
                                                //       "${stateOfResidence}\n"
                                                //       "${imagePath}\n",
                                                // );


                                                await controller.updateUserKyc(
                                                  email: email,
                                                  phoneNumber: phoneNumber,
                                                  accountNumber: accountNumber,
                                                  bankName: bankName,
                                                  bankCode: bankCode,
                                                  gender: gender,
                                                  residence: stateOfResidence,
                                                  imagePath: imagePath,
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
                            ),


                            (
                            controller.profileData.value!.emailVerified == "Yes" &&
                            controller.profileData.value!.kycStatus == "APPROVED"
                            ) ? Container(
                              color: AppColors.askOrange,
                              // height: 60,
                              child: Column(
                                children: [

                                ],
                              ),
                            ) :
                                Container(
                                ),





                                  //pending or user is cheat
                                  (
                                        controller.profileData.value!.kycStatus != "APPROVED" ||
                                        controller.profileData.value!.isCheat == "Yes"

                                ) ? Container(
                                  // color: AppColors.red,
                                  // height: 60,
                                  child: Column(
                                    children: [
                                  (controller.profileData.value!.accountName != "") ?
                                  Padding(
                                        padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(0.0), // equivalent to p-4
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 0),
                                                  const Text(
                                                    'Your KYC is pending approval',
                                                    textAlign: TextAlign.center, style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "LatoRegular",
                                                    color: AppColors.askText,
                                                  ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Container(
                                                    color: AppColors.askBlue,
                                                    height: 2,
                                                    width: 64,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  const Icon(Icons.info, size: 70, color: AppColors.askBlue),
                                                  const SizedBox(height: 8),
                                                  const Text(
                                                    'Please wait for the approval process to complete.', style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "LatoRegular",
                                                    color: AppColors.askText,
                                                  ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  if (controller.profileData.value!.isCheat == 'Yes')
                                                    const Padding(
                                                      padding: EdgeInsets.only(top: 8),
                                                      child: Column(
                                                        children: [
                                                          // const Icon(Icons.warning, size: 32, color: AppColors.red),
                                                          const SizedBox(height: 8),
                                                          Text(
                                                            'Your account has been flagged for cheating.', style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: "LatoRegular",
                                                            color: AppColors.red,
                                                          ),
                                                            textAlign: TextAlign.center,

                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ) : Container(),
                                    ],
                                  )
                                    ,
                                )
                                      :

                                      //create request
                                  controller.myHelpRequestsData.value == null ?
                                Container(
                                  // color: AppColors.askOrange,
                                  // height: 100,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "New Help Request",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "LatoRegular",
                                              color: AppColors.askText,
                                              height: 1.0,
                                              // letterSpacing: .2,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
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
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      //   child: Column(
                                      //     crossAxisAlignment: CrossAxisAlignment.start,
                                      //     children: [
                                      //       const Text(
                                      //         "Email: ",
                                      //         style: TextStyle(
                                      //           fontSize: 14,
                                      //           fontWeight: FontWeight.w500,
                                      //           fontFamily: "LatoRegular",
                                      //           // letterSpacing: .2,
                                      //           color: AppColors.askText,
                                      //         ),
                                      //       ),
                                      //       const SizedBox(height: 4),
                                      //       FadeDownAnimation(
                                      //         delayMilliSeconds: 400,
                                      //         duration: 700,
                                      //         child: TextFormField(
                                      //           initialValue: controller.profileData.value!.emailAddress,
                                      //           // controller: controller.loginEmailController,
                                      //           // focusNode: controller.loginEmailFocusNode,
                                      //           //cursorColor: AppColors.blue,
                                      //           decoration: InputDecoration(
                                      //             hintText: "Email",
                                      //             // filled: true,
                                      //             // fillColor: AppColors.white,
                                      //             border: OutlineInputBorder(
                                      //               borderSide: const BorderSide(
                                      //                 color: AppColors.askBlue,
                                      //               ),
                                      //               borderRadius:
                                      //               BorderRadius.circular(8),
                                      //             ),
                                      //             enabledBorder: OutlineInputBorder(
                                      //               borderSide: const BorderSide(
                                      //                 color: AppColors
                                      //                     .askBlue,
                                      //               ),
                                      //               borderRadius:
                                      //               BorderRadius.circular(8),
                                      //             ),
                                      //             focusedBorder: OutlineInputBorder(
                                      //               borderSide: const BorderSide(
                                      //                 color: AppColors.askBlue,
                                      //               ),
                                      //               borderRadius:
                                      //               BorderRadius.circular(8),
                                      //             ),
                                      //             contentPadding:
                                      //             const EdgeInsets.only(left: 20),
                                      //           ),
                                      //           readOnly: true,
                                      //           keyboardType:
                                      //           TextInputType.emailAddress,
                                      //           style: const TextStyle(
                                      //             //letterSpacing: 0.7,
                                      //             fontSize: 16,
                                      //             color: AppColors.black,
                                      //             fontWeight: FontWeight.w400,
                                      //             fontFamily: "LatoRegular",
                                      //           ),
                                      //           inputFormatters: const [
                                      //             //FilteringTextInputFormatter.digitsOnly,
                                      //             //LengthLimitingTextInputFormatter(13),
                                      //           ],
                                      //           validator: (value) {
                                      //             Pattern pattern =
                                      //                 r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                      //             RegExp regex = RegExp('$pattern');
                                      //             if (!regex.hasMatch(value!)) {
                                      //               return 'Please enter a valid Email Address';
                                      //             } else {
                                      //               return null;
                                      //             }
                                      //           },
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      // const SizedBox(height: 4),

                                      // Description Field
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Description: ",
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
                                                //readOnly: controller.canUserAsk.value,
                                                controller: controller.helpRequestDescriptionController,
                                                // focusNode: controller.loginEmailFocusNode,
                                                //cursorColor: AppColors.blue,
                                                decoration: InputDecoration(
                                                  hintText: "Describe your Help Request here...",
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
                                                maxLines: 5,
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



                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 4),
                                      //Select an image
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                              //   const Text(
                                              //   "Select an Image:: ",
                                              //   style: TextStyle(
                                              //     fontSize: 14,
                                              //     fontWeight: FontWeight.w500,
                                              //     fontFamily: "LatoRegular",
                                              //     // letterSpacing: .2,
                                              //     color: AppColors.askText,
                                              //   ),
                                              // ),
                                                GestureDetector(
                                                    onTap: () async {
                                                      if (!controller.canUserAsk.value) {
                                                        Utils.showInformationDialog(
                                                          status: false,
                                                          title: 'A.S.K Help Request',
                                                          message: "You have already been a beneficiary. Kindly commit to nominating others for now.",
                                                        );
                                                        return;
                                                      }


                                                              final ImagePicker picker = ImagePicker();
                                                              {
                                                                final pickedFile =
                                                                    await picker.pickImage(
                                                                        source: ImageSource.gallery);
                                                                if (pickedFile != null) {
                                                                  controller.setLoading(true);
                                                                  controller.helpRequestImage.value = File(pickedFile.path);

                                                                  controller.setLoading(false);


                                                                }
                                                              }
                                                    },
                                                    child: Container(

                                                        decoration: BoxDecoration(
                                                          color: AppColors.askBlue,
                                                          border: Border.all(color: AppColors.askBlue, width: 2),
                                                          borderRadius: BorderRadius.circular(30),
                                                        ),
                                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                                        child: const Text("Select an Image", style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                          fontFamily: "LatoRegular",
                                                          color: AppColors.white,)))),
                                                ],
                                            ),
                                            const SizedBox(height: 8),
                                            Center(
                                              child: Obx(() => FadeDownAnimation(
                                                delayMilliSeconds: 400,
                                                duration: 700,
                                                child: controller.helpRequestImage.value != null
                                                    ? Image.file(
                                                  controller.helpRequestImage.value!,
                                                  width: 240,
                                                  height: 240,
                                                  fit: BoxFit.cover,
                                                )
                                                    : const Text('No image selected'),
                                              )),
                                            ),
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
                                                text: controller.isLoading ? 'Please wait..' : "Create Request",
                                                function: () async {

                                                  if (!controller.canUserAsk.value) {
                                                    Utils.showInformationDialog(
                                                      status: false,
                                                      title: 'A.S.K Help Request',
                                                      message: "You have already been a beneficiary. Kindly commit to nominating others for now.",
                                                    );
                                                    return;
                                                  }

                                                  if (controller.helpRequestImage.value == null ||
                                                      controller.helpRequestImage.value!.path.isEmpty) {
                                                    // Handle the case where image is null or path is empty

                                                    Utils.showInformationDialog(
                                                      status: false,
                                                      title: 'A.S.K Help Request',
                                                      message: "Select a Help Request image.",
                                                    );
                                                    return;
                                                  }


                                                  String email = controller.profileData.value!.emailAddress!;
                                                  String description = controller.helpRequestDescriptionController.text;
                                                  String fullname = controller.profileData.value!.fullname!;
                                                  File? image = controller.helpRequestImage.value!;

                                                  if (
                                                  description != "" &&
                                                      image.path != "") {

                                                    controller.createHelpRequest(
                                                        email: email,
                                                        description: description,
                                                        fullname: fullname,
                                                        image: image
                                                    );

                                                  } else {
                                                    Utils.showInformationDialog(status: null,
                                                        title: 'A.S.K Help Request',
                                                        message: "Enter a Help Request description and select an image to upload");
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
                                )
                                      :
                                      //edit request
                                  Container(
                                    // color: AppColors.askOrange,
                                    // height: 100,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Edit Help Request",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "LatoRegular",
                                                color: AppColors.askText,
                                                height: 1.0,
                                                // letterSpacing: .2,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
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
                                        // Help Token Field
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Help Token: ${controller.myHelpRequestsData.value!.helpToken!}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "LatoRegular",
                                                  // letterSpacing: .2,
                                                  color: AppColors.askText,
                                                ),
                                              ),
                                              // const SizedBox(height: 4),
                                              // FadeDownAnimation(
                                              //   delayMilliSeconds: 400,
                                              //   duration: 700,
                                              //   child: TextFormField(
                                              //     initialValue: controller.myHelpRequestsData.value!.helpToken!,
                                              //     // controller: controller.loginEmailController,
                                              //     // focusNode: controller.loginEmailFocusNode,
                                              //     //cursorColor: AppColors.blue,
                                              //     decoration: InputDecoration(
                                              //       hintText: "Help Token",
                                              //       // filled: true,
                                              //       // fillColor: AppColors.white,
                                              //       border: OutlineInputBorder(
                                              //         borderSide: const BorderSide(
                                              //           color: AppColors.askBlue,
                                              //         ),
                                              //         borderRadius:
                                              //         BorderRadius.circular(8),
                                              //       ),
                                              //       enabledBorder: OutlineInputBorder(
                                              //         borderSide: const BorderSide(
                                              //           color: AppColors
                                              //               .askBlue,
                                              //         ),
                                              //         borderRadius:
                                              //         BorderRadius.circular(8),
                                              //       ),
                                              //       focusedBorder: OutlineInputBorder(
                                              //         borderSide: const BorderSide(
                                              //           color: AppColors.askBlue,
                                              //         ),
                                              //         borderRadius:
                                              //         BorderRadius.circular(8),
                                              //       ),
                                              //       contentPadding:
                                              //       const EdgeInsets.only(left: 20),
                                              //     ),
                                              //     readOnly: true,
                                              //     keyboardType:
                                              //     TextInputType.text,
                                              //     style: const TextStyle(
                                              //       //letterSpacing: 0.7,
                                              //       fontSize: 16,
                                              //       color: AppColors.black,
                                              //       fontWeight: FontWeight.w400,
                                              //       fontFamily: "LatoRegular",
                                              //     ),
                                              //     inputFormatters: const [
                                              //       //FilteringTextInputFormatter.digitsOnly,
                                              //       //LengthLimitingTextInputFormatter(13),
                                              //     ],
                                              //     validator: (value) {
                                              //       // Pattern pattern =
                                              //       //     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                              //       // RegExp regex = RegExp('$pattern');
                                              //       // if (!regex.hasMatch(value!)) {
                                              //       //   return 'Please enter a valid Email Address';
                                              //       // } else {
                                              //       //   return null;
                                              //       // }
                                              //     },
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 4),

                                        // Description Field
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Description: ",
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
                                                  controller: controller.helpRequestDescriptionController,
                                                  // focusNode: controller.loginEmailFocusNode,
                                                  //cursorColor: AppColors.blue,
                                                  decoration: InputDecoration(
                                                    hintText: "Describe your Help Request here...",
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
                                                  maxLines: 5,
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



                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 4),
                                        //Select an image
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  //   const Text(
                                                  //   "Select an Image:: ",
                                                  //   style: TextStyle(
                                                  //     fontSize: 14,
                                                  //     fontWeight: FontWeight.w500,
                                                  //     fontFamily: "LatoRegular",
                                                  //     // letterSpacing: .2,
                                                  //     color: AppColors.askText,
                                                  //   ),
                                                  // ),
                                                  GestureDetector(
                                                      onTap: () async {
                                                        final ImagePicker picker = ImagePicker();
                                                        {
                                                          final pickedFile =
                                                          await picker.pickImage(
                                                              source: ImageSource.gallery);
                                                          if (pickedFile != null) {
                                                            controller.setLoading(true);
                                                            controller.helpRequestImage.value = File(pickedFile.path);

                                                            controller.setLoading(false);


                                                          }
                                                        }
                                                      },
                                                      child: Container(

                                                          decoration: BoxDecoration(
                                                            color: AppColors.askBlue,
                                                            border: Border.all(color: AppColors.askBlue, width: 2),
                                                            borderRadius: BorderRadius.circular(30),
                                                          ),
                                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                                          child: const Text("Change Image", style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: "LatoRegular",
                                                            color: AppColors.white,)))),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Center(
                                                child: Obx(() => FadeDownAnimation(
                                                  delayMilliSeconds: 400,
                                                  duration: 700,
                                                  child: controller.myHelpRequestsData.value != null && controller.helpRequestImage.value == null ?
                                                  SizedBox(
                                                    width: 250,//double.infinity,
                                                    height: 250,//double.infinity,
                                                    child: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Container(
                                                        // height: 250,//double.infinity,
                                                        // width: 250,//double.infinity,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.askBlue,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(10), // Match container's border radius
                                                          child: CachedNetworkImage(
                                                            imageUrl:
                                                            dotenv.getBool('LIVE_MODE') == false
                                                                ? "https://playground.askfoundations.org/backend/api/v1/${controller.myHelpRequestsData.value!.requestImage!}"
                                                                : "https://askfoundations.org/${controller.myHelpRequestsData.value!.requestImage!}",
                                                            fit: BoxFit.cover, // Changed from contain to cover
                                                            width: 250,//double.infinity,
                                                            height: 250,//double.infinity,
                                                            placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 1)),
                                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                      :
                                                  SizedBox(
                                                    width: 250,//double.infinity,
                                                    height: 250,//double.infinity,
                                                    child: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Container(
                                                        // height: 250,//double.infinity,
                                                        // width: 250,//double.infinity,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.askBlue,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(10), // Match container's border radius
                                                          child: Image.file(
                                                            controller.helpRequestImage.value!,
                                                            // width: 250,//double.infinity,
                                                            // height: 250,//double.infinity,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )



                                                  ,
                                                )),
                                              ),
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
                                                  text: controller.isLoading ? 'Please wait..' : "Update Request Image",
                                                  function: () async {

                                                    String email = controller.profileData.value!.emailAddress!;
                                                    // String description = controller.helpRequestDescriptionController.text;
                                                    String helpToken = controller.myHelpRequestsData.value!.helpToken!;
                                                    // String fullname = controller.profileData.value!.fullname!;
                                                    File? image = controller.helpRequestImage.value!;
                                                    //

                                                    // print(description);
                                                    if (
                                                    // description != ""
                                                    // &&
                                                    image.path != ""
                                                    ) {

                                                      controller.updateHelpRequestImage(
                                                          email: email,
                                                          image: image
                                                      );

                                                    } else {
                                                      Utils.showInformationDialog(status: null,
                                                          title: 'A.S.K Edit Help Request',
                                                          message: "Enter a Help Request description to update");
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
                                                height: 10,
                                              ),
                                              AskButton(
                                                  enabled: true,
                                                  text: controller.isLoading ? 'Please wait..' : "Edit Request",
                                                  function: () async {

                                                    String email = controller.profileData.value!.emailAddress!;
                                                    String description = controller.helpRequestDescriptionController.text;
                                                    String helpToken = controller.myHelpRequestsData.value!.helpToken!;
                                                    // String fullname = controller.profileData.value!.fullname!;
                                                    // File? image = controller.helpRequestImage.value!;
                                                    //

                                                    print(description);
                                                    if (
                                                    description != ""
                                                        // &&
                                                        // image.path != ""
                                                    ) {

                                                      controller.updateHelpRequest(
                                                          email: email,
                                                          description: description,
                                                          helpToken: helpToken
                                                      );

                                                    } else {
                                                      Utils.showInformationDialog(status: null,
                                                          title: 'A.S.K Edit Help Request',
                                                          message: "Enter a Help Request description to update");
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
                                                height: 10,
                                              ),
                                              AskButton(
                                                  enabled: true,
                                                  text: controller.isLoading ? 'Please wait..' : "View Request",
                                                  function: () async {

                                                    String email = controller.profileData.value!.emailAddress!;
                                                    String helpToken = controller.myHelpRequestsData.value!.helpToken!;
                                                    // String fullname = controller.profileData.value!.fullname!;
                                                    // File? image = controller.helpRequestImage.value!;
                                                    //
                                                    // if (
                                                    // description != "" &&
                                                    //     image.path != "") {
                                                    //
                                                    controller.handleNavigation(1);
                                                      controller.scrollToNewRequestViaHelptoken(
                                                           helpToken
                                                      );
                                                    //
                                                    // } else {
                                                    //   Utils.showInformationDialog(status: null,
                                                    //       title: 'A.S.K Help Request',
                                                    //       message: "Enter a Help Request description and select an image to upload");
                                                    // }
                                                  },
                                                  backgroundColor: AppColors.white,
                                                  textColor: AppColors.askBlue,
                                                  buttonWidth: ScreenSize.scaleWidth(context, 340),
                                                  buttonHeight: ScreenSize.scaleHeight(context, 60),
                                                  borderCurve: 26,
                                                  border: true,
                                                  borderColor: AppColors.askBlue,
                                                  textSize: 16
                                              ),
                                              // const SizedBox(
                                              //   height: 20,
                                              // ),
                                              // Divider(),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              AskButton(
                                                  enabled: true,
                                                  text: controller.isLoading ? 'Please wait..' : "Delete Request",
                                                  function: () async {

                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: const Text("Confirm Deletion"),
                                                          content: const Text("Are you sure you want to delete your help request?"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: const Text("Cancel"),
                                                              onPressed: () {
                                                                Navigator.of(context).pop(); // Close the dialog
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text("OK"),
                                                              onPressed: () async {
                                                                Navigator.of(context).pop(); // Close the dialog
                                                                try {
                                                                  String email = controller.profileData.value!.emailAddress!;
                                                                  String helpToken = controller.myHelpRequestsData.value!.helpToken!;
                                                                  await controller.deleteHelpRequest(
                                                                    email: email,
                                                                    helpToken: helpToken,
                                                                  );
                                                                  // Optional: Show success message
                                                                  // ScaffoldMessenger.of(context).showSnackBar(
                                                                  //   SnackBar(content: Text('Help request deleted successfully')),
                                                                  // );
                                                                } catch (e) {
                                                                  // Optional: Show error message
                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                    SnackBar(content: Text('Error deleting help request: $e')),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );



                                                    // String email = controller.profileData.value!.emailAddress!;
                                                    // String helpToken = controller.myHelpRequestsData.value!.helpToken!;
                                                    // // String fullname = controller.profileData.value!.fullname!;
                                                    // // File? image = controller.helpRequestImage.value!;
                                                    // //
                                                    // // if (
                                                    // // description != "" &&
                                                    // //     image.path != "") {
                                                    // //
                                                    // controller.deleteHelpRequest(
                                                    //     email: email,
                                                    //     helpToken: helpToken
                                                    // );
                                                    // //
                                                    // // } else {
                                                    // //   Utils.showInformationDialog(status: null,
                                                    // //       title: 'A.S.K Help Request',
                                                    // //       message: "Enter a Help Request description and select an image to upload");
                                                    // // }
                                                  },
                                                  backgroundColor: AppColors.red,
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
                                  )

















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
