import 'package:ask_mobile/app/modules/auth/views/register_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/app_strings.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/loading_screen.dart';
import '../../../../global/widgets/ask_button.dart';
import '../../../../global/widgets/fade_down_animation.dart';
import '../../../../utils/utils.dart';
import '../../home/bindings/home_binding.dart';
import '../../home/views/home_view.dart';
import '../bindings/auth_binding.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.askBackground,
      // appBar: AppBar(
      //   title: const Text('LoginView'),
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
                                AuthStrings.LOGIN_HEADER,
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
                                AuthStrings.LOGIN_SUBHEADER,
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
                                controller: controller.loginEmailController,
                                focusNode: controller.loginEmailFocusNode,
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
                                controller: controller.loginPasswordController,
                                focusNode: controller.loginPasswordFocusNode,
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
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                              children: [
                                // Row(
                                //   children: [
                                //     Container(
                                //         decoration: BoxDecoration(
                                //             border: Border.all()
                                //             //color: AppColors.black,
                                //             //controller.termsAccepted
                                //             //    ? AppColors.blue
                                //             //    : AppColors.lighterGrey,
                                //             //borderRadius: BorderRadius.circular(12),
                                //             //boxShadow: buttonShadow
                                //             ),
                                //         height: 17,
                                //         width: 17,
                                //         child: const Icon(
                                //           Icons.check,
                                //           size: 12,
                                //           color: AppColors.askBlue,
                                //         )),
                                //     const SizedBox(
                                //       width: 10,
                                //     ),
                                //     const Text("Remember Me"),
                                //   ],
                                // ),
                                GestureDetector(
                                  onTap: () async {
                                    //

                                    // Utils.showTopSnackBar(
                                    //     t: "A.S.K Forgot Password",
                                    //     m: "",
                                    //     tc: AppColors.white,
                                    //     d: 3,
                                    //     bc: AppColors.askBlue,
                                    //     sp: SnackPosition.TOP);
                                    String email = controller.loginEmailController.text;


                                    if (email.isEmpty || !Utils.validateEmail(email)) {
                                      Utils.showInformationDialog(status: null,
                                          title: 'A.S.K Forgot Password',
                                          message: "Please, enter a valid email first, and then tap Forgot password."
                                      );
                                      return;
                                    }

                                    await controller.sendMobileResetPasswordCode(email: email).then((response) {
                                      // Only show modal if the API call was successful (status == true)
                                      if (response?.status == true) {
                                        // showForgotPasswordModal(context);
                                        showEnterFourDigitsCodeModal(context);
                                      }
                                    }).catchError((error) {
                                      // Handle any errors (already handled in `sendMobileResetPassordCode`)
                                    });



                                  },
                                  child: const Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "LatoRegular",
                                        // letterSpacing: .2,
                                        color: AppColors.askBlue),
                                  ),
                                )
                              ],
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
                                          text: "Sign in with Google",
                                          function: () async {
                                            // controller.finalStep();
                                            await controller.signInWithGoogle();
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
                                        //   text: "Sign in with Apple",
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
                                        //     // textSize: 16
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
                            text: "Login",
                            function: () async {
                              // controller.clearAuthToken();

                              String email = controller.loginEmailController.text;
                              String password = controller.loginPasswordController.text;


                              if (email.isEmpty || !Utils.validateEmail(email)) {
                                Utils.showInformationDialog(status: null,
                                    title: 'A.S.K Login',
                                    message: "Please, enter a valid email."
                                );
                                return;
                              }



                              if (
                              // email.isEmpty ||
                                  password.isEmpty) {
                                Utils.showTopSnackBar(
                                    t: "A.S.K Login",
                                    m: "Password cannot be empty",
                                    tc: AppColors.white,
                                    d: 3,
                                    bc: AppColors.askBlue,
                                    sp: SnackPosition.TOP);
                              } else {
                                await controller.loginUser(
                                  email: email,
                                  password: password,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Don't have an account? ",
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

                                Get.off(() => RegisterView(),
                                    transition: Transition.fadeIn, // Built-in transition type
                                    duration: Duration(milliseconds: 500),
                                    binding: AuthBinding()
                                );
                              },
                              child: const Text(
                                "Register now",
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



// showForgotPasswordModal(context) {
//   AuthController controller = Get.find<AuthController>();
//
//   showModalBottomSheet(
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
//     ),
//     builder: (context) {
//       return Container(
//         padding: const EdgeInsets.all(20.0),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   // alignment: Alignment.center,
//                   height: 5,
//                   width: ScreenSize.height(context) * .3,
//                   // color: AppColors.eDoctorModalTop,
//                   decoration: BoxDecoration(
//                     // border: Border.all()
//                     color: AppColors.eDoctorModalTop,
//                     borderRadius: BorderRadius.circular(6),
//                     //boxShadow: buttonShadow
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               const Text(
//                 AuthStrings.FORGOTPASSWORD,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w700,
//                   fontFamily: "ManropeRegular",
//                   letterSpacing: .2,
//                 ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               const Text(
//                 AuthStrings.ENTERYOUREMAILFOR,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: "ManropeRegular",
//                   // letterSpacing: .2,
//                 ),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               FadeDownAnimation(
//                 delayMilliSeconds: 400,
//                 duration: 700,
//                 child: TextFormField(
//                   controller: controller.patientEmailAddressController,
//                   //cursorColor: AppColors.blue,
//                   decoration: InputDecoration(
//                     hintText: "Enter your email",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         color: AppColors.askBlue,
//                       ),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         color: AppColors.eDoctorInputBorder,
//                       ),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         color: AppColors.black,
//                       ),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     contentPadding: const EdgeInsets.only(left: 20),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   style: const TextStyle(
//                     letterSpacing: 0.7,
//                     fontSize: 16,
//                   ),
//                   inputFormatters: const [
//                     //FilteringTextInputFormatter.digitsOnly,
//                     //LengthLimitingTextInputFormatter(13),
//                   ],
//                   validator: (value) {
//                     Pattern pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
//                     RegExp regex = RegExp('$pattern');
//                     if (!regex.hasMatch(value!)) {
//                       return 'Please enter a valid Email Address';
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//               ),
//               const SizedBox(height: 16),
//               AskButton(
//                   text: AuthStrings.CONTINUE,
//                   function: () async {
//                     final email = controller.patientEmailAddressController.value.text;
//
//                     if (email.isEmpty) {
//                       Utils.showTopSnackBar(
//                           t: "Forgot Password",
//                           m: "Enter your email",
//                           tc: AppColors.white,
//                           d: 3,
//                           bc: AppColors.askBlue,
//                           sp: SnackPosition.TOP);
//                       return;}
//
//
//                     Navigator.pop(context);
//                     showEnterFourDigitsCodeModal(context);
//
//
//                     await controller.patientSendForgotPasswordOTP(email: email);
//
//
//
//
//                   },
//                   backgroundColor: AppColors.askBlue,
//                   textColor: AppColors.eDoctorButtonTextLight,
//                   buttonWidth: width(context),
//                   buttonHeight: 40,
//                   borderCurve: 8,
//                   enabled: true,
//                   border: false,
//                   borderColor: AppColors.eDoctorButtonBorder),
//               const SizedBox(
//                 height: 32,
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

showEnterFourDigitsCodeModal(context) {
  AuthController controller = Get.find<AuthController>();

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  // alignment: Alignment.center,
                  height: 2,
                  width: ScreenSize.width(context) * .1,
                  // color: AppColors.eDoctorModalTop,
                  decoration: BoxDecoration(
                    // border: Border.all()
                    color: AppColors.askLightBlue,
                    borderRadius: BorderRadius.circular(6),
                    //boxShadow: buttonShadow
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Forgot Your Password ?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  fontFamily: "LatoRegular",
                  // letterSpacing: .2,
                  color: AppColors.askText,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Enter the code we just sent to your email address: ${controller.loginEmailController.text}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "LatoRegular",
                  // letterSpacing: .2,
                  color: AppColors.askText,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              FadeDownAnimation(
                delayMilliSeconds: 400,
                duration: 700,
                child: TextFormField(
                  controller: controller.resetCodeController,
                  // focusNode: controller.loginEmailFocusNode,
                  //cursorColor: AppColors.blue,
                  decoration: InputDecoration(
                    hintText: "Enter reset code",
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
                    // Pattern pattern =
                    //     r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                    // RegExp regex = RegExp('$pattern');
                    // if (!regex.hasMatch(value!)) {
                    //   return 'Please enter a valid Email Address';
                    // } else {
                    //   return null;
                    // }
                  },
                ),//CustomOTPFourFieldPatient(),
              ),
              const SizedBox(height: 16),
              AskButton(
                enabled: true,
                  text: "Continue",
                  function: () async {
                    String email = controller.loginEmailController.text;
                    String emailCode = controller.resetCodeController.text;

                    if (emailCode.isEmpty) {
                      Utils.showInformationDialog(status: null,
                          title: 'A.S.K Forgot Password',
                          message: "Please, enter the code sent to your email."
                      );
                      return;
                    }

                    // verificationCode
//validate mobile code

                    await controller.validateMobileResetPasswordCode(email: email, emailCode: emailCode).then((response) {
                      // Only show modal if the API call was successful (status == true)
                      if (response?.status == true) {
                        Navigator.pop(context);
                        showResetPasswordModal(context);
                      }
                    }).catchError((error) {
                      // Handle any errors (already handled in `sendMobileResetPassordCode`)
                    });


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
                height: 32,
              ),
            ],
          ),
        ),
      );
    },
  );
}
//
showResetPasswordModal(context) {
  AuthController controller = Get.find<AuthController>();

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  // alignment: Alignment.center,
                  height: 2,
                  width: ScreenSize.height(context) * .1,
                  // color: AppColors.eDoctorModalTop,
                  decoration: BoxDecoration(
                    // border: Border.all()
                    color: AppColors.askLightBlue,
                    borderRadius: BorderRadius.circular(6),
                    //boxShadow: buttonShadow
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Reset your Password",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  fontFamily: "LatoRegular",
                  // letterSpacing: .2,
                  color: AppColors.askText,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Set your new password below:",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "LatoRegular",
                  // letterSpacing: .2,
                  color: AppColors.askText,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  // const Text(
                  //   AuthStrings.PASSWORD,
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w500,
                  //     fontFamily: "ManropeRegular",
                  //     // letterSpacing: .2,
                  //   ),
                  // ),
                  // const SizedBox(height: 8),
                  FadeDownAnimation(
                    delayMilliSeconds: 400,
                    duration: 700,
                    child: TextFormField(
                      controller: controller.newPasswordController,
                      obscureText: controller.obscurePassword,
                      //cursorColor: AppColors.blue,
                      decoration: InputDecoration(
                        hintText: "New password",
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
                                  .askBlue,
                              size: 16,
                            ),
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(left: 20),
                      ),
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        letterSpacing: 0.7,
                        fontSize: 16,
                      ),
                      inputFormatters: const [
                        //FilteringTextInputFormatter.digitsOnly,
                        //LengthLimitingTextInputFormatter(13),
                      ],
                      validator: (value) {
                        // Pattern pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                        // RegExp regex = RegExp('$pattern');
                        // if (!regex.hasMatch(value!)) {
                        //   return 'Please enter a valid Email Address';
                        // } else {
                        //   return null;
                        // }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FadeDownAnimation(
                    delayMilliSeconds: 400,
                    duration: 700,
                    child: TextFormField(
                      controller: controller.confirmPasswordController,
                      //cursorColor: AppColors.blue,
                      obscureText: controller.obscurePassword,
                      decoration: InputDecoration(
                        hintText: "Re-enter password",
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
                                  .askBlue,
                              size: 16,
                            ),
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(left: 20),
                      ),
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        letterSpacing: 0.7,
                        fontSize: 16,
                      ),
                      inputFormatters: const [
                        //FilteringTextInputFormatter.digitsOnly,
                        //LengthLimitingTextInputFormatter(13),
                      ],
                      validator: (value) {
                        // Pattern pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
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
              ),),
              const SizedBox(height: 16),
              AskButton(
                enabled: true,
                  text: "Submit",
                  function: () async  {

                    String email = controller.loginEmailController.text;
                    String newPassword = controller.newPasswordController.text;
                    String confirmPassword = controller.confirmPasswordController.text;
                    // String otp = controller.firstOTPBox.text + controller.secondOTPBox.text + controller.thirdOTPBox.text + controller.fourthOTPBox.text;
                    //
                    if (newPassword.isEmpty || confirmPassword.isEmpty) {
                      Utils.showTopSnackBar(
                          t: "ASK: Reset Password",
                          m: "Passwords must not be empty",
                          tc: AppColors.white,
                          d: 3,
                          bc: AppColors.askBlue,
                          sp: SnackPosition.TOP);
                      return;
                    }
                    //
                    if (newPassword != confirmPassword) {
                      Utils.showTopSnackBar(
                          t: "ASK: Reset Password",
                          m: "Passwords do not match",
                          tc: AppColors.white,
                          d: 3,
                          bc: AppColors.askBlue,
                          sp: SnackPosition.TOP);
                      return;
                    }


                    //
                    //
                    //
                    // Navigator.pop(context);
                    await controller.resetPassword(email: email, newPassword: newPassword).then((response) async {
                      // Only show modal if the API call was successful (status == true)
                      if (response?.status == true) {
                        Navigator.pop(context);
                        await controller.loginUser(email: email, password: newPassword);

                        controller.newPasswordController.clear();
                        controller.confirmPasswordController.clear();
                      }
                    }).catchError((error) {
                      // Handle any errors (already handled in `sendMobileResetPassordCode`)
                    });


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
                height: 32,
              ),
            ],
          ),
        ),
      );
    },
  );
}