import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/app_strings.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/LoadingScreen.dart';
import '../../../../global/widgets/ask_button.dart';
import '../../../../global/widgets/fade_down_animation.dart';
import '../../../../utils/utils.dart';
import '../../../routes/app_pages.dart';
import '../bindings/auth_binding.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.askBackground,
      // appBar: AppBar(
      //   title: const Text('RegisterView'),
      //   centerTitle: true,
      // ),
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
                            const Text(
                                AuthStrings.REGISTRATION_HEADER,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "LatoRegular",
                                  color: AppColors.askText,
                                  height: 1.0,
                                  // letterSpacing: .2,
                                )
                            ),
                            const SizedBox(height: 20),
                            const Text(
                                AuthStrings.REGISTRATION_SUBHEADER,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "LatoRegular",
                                  color: AppColors.askText,
                                  // letterSpacing: .2,
                                )
                            ),
                            const SizedBox(height: 40),

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
                                controller: controller.registerEmailController,
                                focusNode: controller.registerEmailFocusNode,
                                //cursorColor: AppColors.blue,
                                decoration: InputDecoration(
                                  hintText: "Enter your email",
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors.askBlue,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(22),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors
                                          .askBlue,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(22),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors.askBlue,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(22),
                                  ),
                                  contentPadding:
                                  const EdgeInsets.only(left: 20),
                                ),
                                keyboardType:
                                TextInputType.emailAddress,
                                style: const TextStyle(
                                  //letterSpacing: 0.7,
                                  fontSize: 16,
                                  // color: AppColors.eDoctorAppText,
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

                            const SizedBox(height: 20),

                            const Text(
                              "Password: ",
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
                                controller: controller.registerPasswordController,
                                focusNode: controller.registerPasswordFocusNode,
                                obscureText: controller.obscurePassword,
                                //cursorColor: AppColors.blue,
                                decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors.askBlue,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(22),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors
                                          .askBlue,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(22),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors.askBlue,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(22),
                                  ),
                                  suffixIcon: Obx(
                                        () => IconButton(
                                      onPressed: controller
                                          .toggleObscurePassword,
                                      icon: Icon(
                                        controller.obscurePassword
                                            ? Icons.visibility
                                            : Icons
                                            .visibility_off,
                                        color: AppColors
                                            .askText,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  contentPadding:
                                  const EdgeInsets.only(left: 20),
                                ),
                                keyboardType:
                                TextInputType.text,
                                style: const TextStyle(
                                  //letterSpacing: 0.7,
                                  fontSize: 16,
                                  // color: AppColors.eDoctorAppText,
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

                            const SizedBox(height: 20),

                            const Text(
                              "Confirm Password: ",
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
                                controller: controller.registerConfirmPasswordController,
                                focusNode: controller.registerConfirmPasswordFocusNode,
                                obscureText: controller.obscurePassword,
                                //cursorColor: AppColors.blue,
                                decoration: InputDecoration(
                                  hintText: "Confirm your password",
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors.askBlue,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(22),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors
                                          .askBlue,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(22),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: AppColors.askBlue,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(22),
                                  ),
                                  suffixIcon: Obx(
                                        () => IconButton(
                                      onPressed: controller
                                          .toggleObscurePassword,
                                      icon: Icon(
                                        controller.obscurePassword
                                            ? Icons.visibility
                                            : Icons
                                            .visibility_off,
                                        color: AppColors
                                            .askText,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  contentPadding:
                                  const EdgeInsets.only(left: 20),
                                ),
                                keyboardType:
                                TextInputType.text,
                                style: const TextStyle(
                                  //letterSpacing: 0.7,
                                  fontSize: 16,
                                  // color: AppColors.eDoctorAppText,
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


                            Flexible(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: ScreenSize.width(context),
                                  alignment: Alignment.bottomCenter,
                                  // color: AppColors.askBlue,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 32,
                                        ),

                                        AskButton(
                                          text: "Register with Google",
                                          function: () async {
                                            // controller.finalStep();
                                            await controller.registerWithGoogle();
                                          },
                                          backgroundColor: AppColors.askSoftTheme,
                                          textColor: AppColors.askBlue,
                                          buttonWidth: ScreenSize.width(context),
                                          buttonHeight: ScreenSize.scaleHeight(context, 50),
                                          borderCurve: 26,
                                          enabled: true,
                                          border: false,
                                          borderColor: AppColors.askBlue,
                                          imgPath: "assets/images/icons/g.png",
                                          // textSize: 16
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        // AskButton(
                                        //   text: "Register with Apple",
                                        //   function: () {
                                        //     // controller.finalStep();
                                        //     // controller.skipToBegin();
                                        //   },
                                        //   backgroundColor: AppColors.askSoftTheme,
                                        //   textColor: AppColors.askBlue,
                                        //   buttonWidth: ScreenSize.width(context),
                                        //   buttonHeight: ScreenSize.scaleHeight(context, 50),
                                        //   borderCurve: 26,
                                        //   enabled: true,
                                        //   border: false,
                                        //   borderColor: AppColors.askBlue,
                                        //   imgPath: "assets/images/icons/a.png",
                                        //   // textSize: 16
                                        // ),

                                        const SizedBox(
                                          height: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),


                          ]),
                    ),
                  ),
                )),

            Obx(() => controller.showContinue ? Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    // color: AppColors.xippBlue,
                    width: ScreenSize.width(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10,),
                        AskButton(
                            enabled: true,
                            text: "Register",
                            function: () async {

                              String email = controller.registerEmailController.text;
                              String password = controller.registerPasswordController.text;
                              String confirmPassword = controller.registerConfirmPasswordController.text;


                              if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                                Utils.showTopSnackBar(
                                    t: "A.S.K Registration",
                                    m: "Email, password or confirm password cannot be empty",
                                    tc: AppColors.white,
                                    d: 3,
                                    bc: AppColors.askBlue,
                                    sp: SnackPosition.TOP);
                              } else {
                                if (password == confirmPassword) {
                                  await controller.registerUser(
                                    email: email,
                                    password: password,
                                  );
                                } else {
                                  Utils.showTopSnackBar(
                                      t: "A.S.K Registration",
                                      m: "Passwords don't match",
                                      tc: AppColors.white,
                                      d: 3,
                                      bc: AppColors.askBlue,
                                      sp: SnackPosition.TOP);
                                }
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Already registered? ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "LatoRegular",
                                  color: AppColors.askBlue
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // controller.clearOnboardingFields();

                                Get.off(() => LoginView(),
                                    transition: Transition.fadeIn, // Built-in transition type
                                    duration: Duration(milliseconds: 500),
                                    binding: AuthBinding()
                                );
                              },
                              child: const Text(
                                "Log in",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "LatoRegular",
                                    // letterSpacing: .2,
                                    color: AppColors.askBlue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ) : Container() )
          ],
        ),),
      ),
    );
  }
}
