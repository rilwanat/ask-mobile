import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/app_strings.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/LoadingScreen.dart';
import '../../../../global/widgets/app_bar.dart';
import '../../../../global/widgets/fade_down_animation.dart';
import '../../../../global/widgets/navbar.dart';
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
                            const Text(
                                AskStrings.NEW_HELP_REQUEST,
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

                            Obx(() =>
                                (controller.profileData.value!.emailVerified == null
                                || controller.profileData.value!.emailVerified == ""
                                || controller.profileData.value!.emailVerified == "No") ?
                            Container() : Container()
                            ),



                            const SizedBox(height: 20),


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
