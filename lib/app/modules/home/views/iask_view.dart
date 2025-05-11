import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
                            // const SizedBox(height: 30),


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
                                            child:
                                            DropdownSearch<String>(
                                              selectedItem: controller.selectedBankName,
                                              items: (filter, infiniteScrollProps) {
                                                return controller.bankCodeData
                                                    .where((bank) => bank != null && bank.bankName != null)
                                                    .map((bank) => bank!.bankName!) // Show only bank name
                                                    .toList();
                                              },
                                              filterFn: (item, filter) => item.toLowerCase().contains(filter.toLowerCase()),
                                              onChanged: (String? selectedName) {
                                                if (selectedName != null) {
                                                  // Find the corresponding bank code
                                                  final selectedBank = controller.bankCodeData.firstWhere(
                                                        (bank) => bank?.bankName == selectedName,
                                                    orElse: () => null,
                                                  );

                                                  if (selectedBank != null) {
                                                    controller.kycBankNameController.text = selectedBank.bankName!;
                                                    controller.setSelectedBankName(selectedBank.bankName ?? '');
                                                    controller.setSelectedBankCode(selectedBank.bankCode ?? '');
                                                  }
                                                }
                                              },
                                              decoratorProps: DropDownDecoratorProps(
                                                decoration: InputDecoration(
                                                  hintText: "Select Bank Name",
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                    borderSide: const BorderSide(color: AppColors.askText),
                                                  ),
                                                  contentPadding: const EdgeInsets.only(left: 20),
                                                ),
                                              ),
                                              popupProps: const PopupProps.menu(
                                                showSearchBox: true,
                                                searchFieldProps: TextFieldProps(
                                                  decoration: InputDecoration(
                                                    hintText: "Search bank name...",
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                                  ),
                                                ),
                                                // Added from documentation example
                                                fit: FlexFit.loose,
                                                constraints: BoxConstraints(),
                                              ),
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
                                            child:
                                            DropdownButtonFormField<
                                                String>(
                                              value: controller.selectedGender,
                                              onChanged:
                                                  (String? newValue) {
                                                controller.kycGenderController.text = newValue!;
                                                controller.setSelectedGender(newValue);
                                              },
                                              items: controller.gender.map((state) {
                                                return DropdownMenuItem<String>(
                                                  value: state['value'],
                                                  child: Text(
                                                    state['label']!,
                                                    style: const TextStyle(
                                                      color: AppColors.askText,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "LatoRegular",
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              decoration:
                                              InputDecoration(
                                                //filled: true,
                                                //fillColor: AppColors.priceWatchBlue,
                                                border:
                                                OutlineInputBorder(
                                                  borderSide:
                                                  const BorderSide(
                                                    color: AppColors
                                                        .askText,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      8),
                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide:
                                                  const BorderSide(
                                                    color: AppColors
                                                        .askText,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      8),
                                                ),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide:
                                                  const BorderSide(
                                                    color: AppColors
                                                        .askText,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      8),
                                                ),
                                                contentPadding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 20),
                                              ),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight:
                                                FontWeight.w500,
                                                fontFamily:
                                                "LatoRegular",
                                                // letterSpacing: .2,
                                              ),
                                              hint: const Text(
                                                  'Select Gender'),
                                              icon: const Padding(
                                                padding: EdgeInsets.only(right: 10.0),
                                                child: Icon(
                                                  Icons.arrow_drop_down, // The dropdown arrow icon
                                                  color: AppColors.askText, // Optional: Change icon color
                                                ),
                                              ),
                                            ),
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
                                            child:
                                            DropdownButtonFormField<
                                                String>(
                                              value: controller.selectedStateOfResidence,
                                              onChanged:
                                                  (String? newValue) {
                                                controller.kycStateOfResidenceController.text = newValue!;
                                                controller.setSelectedStateOfResidence(newValue);
                                              },
                                              items: controller.statesOfResidence.map((state) {
                                                return DropdownMenuItem<String>(
                                                  value: state['value'],
                                                  child: Text(
                                                    state['label']!,
                                                    style: const TextStyle(
                                                      color: AppColors.askText,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "LatoRegular",
                                                    ),
                                                  ),
                                                );
                                              }).toList(),

                                              decoration:
                                              InputDecoration(
                                                //filled: true,
                                                //fillColor: AppColors.priceWatchBlue,
                                                border:
                                                OutlineInputBorder(
                                                  borderSide:
                                                  const BorderSide(
                                                    color: AppColors
                                                        .askText,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      8),
                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide:
                                                  const BorderSide(
                                                    color: AppColors
                                                        .askText,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      8),
                                                ),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide:
                                                  const BorderSide(
                                                    color: AppColors
                                                        .askText,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      8),
                                                ),
                                                contentPadding:
                                                const EdgeInsets
                                                    .only(
                                                    left: 20),
                                              ),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight:
                                                FontWeight.w500,
                                                fontFamily:
                                                "LatoRegular",
                                                // letterSpacing: .2,
                                              ),
                                              hint: const Text(
                                                  'Select Account Type'),
                                              icon: const Padding(
                                                padding: EdgeInsets.only(right: 10.0),
                                                child: Icon(
                                                  Icons.arrow_drop_down, // The dropdown arrow icon
                                                  color: AppColors.askText, // Optional: Change icon color
                                                ),
                                              ),
                                            ),
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
                                        AskButton(
                                          enabled: controller.isCameraInitialized.value ? false : true,
                                          text: !controller.isCameraInitialized.value ? "Retake" : "Start Camera",
                                          function: () async {

                                            if (controller.isCameraInitialized.value) {
                                              Utils.showTopSnackBar(
                                                  t: "A.S.K Camera",
                                                  m: "Already started",
                                                  tc: AppColors.white,
                                                  d: 3,
                                                  bc: AppColors.askBlue,
                                                  sp: SnackPosition.TOP);
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
                                          backgroundColor: AppColors.askBlue,
                                          textColor: AppColors.white,
                                          buttonWidth: ScreenSize.scaleWidth(context, 140),
                                          buttonHeight: ScreenSize.scaleHeight(context, 48),
                                          borderCurve: 26,
                                          border: false,
                                          textSize: 14,
                                        ),

                                        const SizedBox(width: 10,),

                                        AskButton(
                                          enabled: true,
                                          text: "Take Selfie",
                                          function: () async {

                                            if (controller.cameraController.value != null) {
                                              await controller.takePicture();
                                            }
                                          },
                                          backgroundColor: AppColors.askBlue,
                                          textColor: AppColors.white,
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
                                            text: "Verify KYC",
                                            function: () async {

                                              String email = controller.profileData.value!.emailAddress!;

                                              String phoneNumber = controller.kycPhoneNumberController.text;
                                              String accountNumber = controller.kycAccountNumberController.text;
                                              String bankName = controller.kycBankNameController.text;
                                              String gender = controller.kycGenderController.text;
                                              String stateOfResidence = controller.kycStateOfResidenceController.text;




                                              if (
                                              phoneNumber.isEmpty
                                                  || accountNumber.isEmpty
                                                  || bankName.isEmpty
                                                  || gender.isEmpty
                                                  || stateOfResidence.isEmpty
                                              ) {
                                                Utils.showTopSnackBar(
                                                    t: "A.S.K Verify KYC",
                                                    m: "KYC Fields cannot be empty",
                                                    tc: AppColors.white,
                                                    d: 3,
                                                    bc: AppColors.askBlue,
                                                    sp: SnackPosition.TOP);
                                              } else {
                                                Utils.showTopSnackBar(
                                                    t: "A.S.K Verify KYC",
                                                    m:
                                                    "${phoneNumber}\n"
                                                        "${accountNumber}\n"
                                                        "${bankName}\n"
                                                        "${gender}\n"
                                                        "${stateOfResidence}",
                                                    tc: AppColors.white,
                                                    d: 3,
                                                    bc: AppColors.askBlue,
                                                    sp: SnackPosition.TOP);


                                                // await controller.verifyEmail(
                                                //   email: email,
                                                //   verificationCode: verificationCode,
                                                // );
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
