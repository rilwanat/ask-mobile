import 'package:ask_mobile/app/modules/auth/views/register_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/ask_button.dart';
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
      body: Stack(
        children: [
          Positioned(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ScreenSize.scaleHeight(context, 70),),
                      Container(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Row(
                          //   children: [
                          //     Stack(
                          //         children: [
                          //           Container(
                          //             width: ScreenSize.scaleHeight(context, 50),
                          //             height: ScreenSize.scaleHeight(context, 50),
                          //             // padding: const EdgeInsets.all(2),
                          //             // margin: const EdgeInsets.all(8),
                          //             decoration: BoxDecoration(
                          //               border: Border.all(color: AppColors.xippBlue, width: 2),
                          //               // color: AppColors.white,
                          //               borderRadius:
                          //               BorderRadius.circular(ScreenSize.scaleHeight(context, 50)),
                          //               //boxShadow: buttonShadow
                          //             ),
                          //             child: Visibility(
                          //               visible: true,
                          //               child: Image.asset(
                          //                 "assets/images/Ellipse 176.png",
                          //                 //fit: BoxFit.fitWidth,
                          //               ),
                          //             ),
                          //           ),
                          //           //
                          //           Positioned(
                          //               right: 0,
                          //               bottom: 0,
                          //               child: Container(
                          //                 // padding: const EdgeInsets.all(2),
                          //                 width: 16, height: 16,
                          //                 decoration: new BoxDecoration(
                          //                   color: Colors.red,
                          //                   borderRadius: BorderRadius.circular(26),
                          //                 ),))
                          //         ]
                          //     ),
                          //     const SizedBox(width: 10,),
                          //     // Obx(() {
                          //     //   // final profile = controller.profileData.value;
                          //     //   final firstName = "";//profile?.data?.firstName ?? "-"; // Default to "Guest" if null
                          //     //
                          //     //   return Text(
                          //     //     "Hi $firstName!",
                          //     //     style: const TextStyle(
                          //     //       fontSize: 18,
                          //     //       fontWeight: FontWeight.w600,
                          //     //       fontFamily: "Outfit",
                          //     //       color: AppColors.xippText,
                          //     //     ),
                          //     //     textAlign: TextAlign.center,
                          //     //   );
                          //     // })
                          //     const Text(
                          //       "Hi !",
                          //       style: TextStyle(
                          //         fontSize: 18,
                          //         fontWeight: FontWeight.w600,
                          //         fontFamily: "Outfit",
                          //         color: AppColors.xippText,
                          //       ),
                          //       textAlign: TextAlign.center,
                          //     )
                          //
                          //
                          //   ],
                          // ),


                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     GestureDetector(
                          //       onTap: () {
                          //         // controller.getUserProfile();
                          //         // controller.getUserTransactionsHistory();
                          //         // controller.getMyBudgets();();
                          //       },
                          //       child: Container(
                          //         width: ScreenSize.scaleHeight(context, 26),
                          //         height: ScreenSize.scaleHeight(context, 26),
                          //         // padding: const EdgeInsets.all( 2),
                          //         // margin: const EdgeInsets.all( 8),
                          //         decoration: BoxDecoration(
                          //           // border: Border.all(color: AppColors.eDoctorInputBorder),
                          //           // color: AppColors.red,
                          //           borderRadius:
                          //           BorderRadius.circular(ScreenSize.scaleHeight(context, 50)),
                          //           //boxShadow: buttonShadow
                          //         ),
                          //         child: Visibility(
                          //             visible: true,
                          //             child: Icon(Icons.refresh, color: AppColors.white,)
                          //           // Image.asset(
                          //           //   "assets/images/icons/h-customer-service.png",
                          //           //   //fit: BoxFit.fitWidth,
                          //           // ),
                          //         ),
                          //       ),
                          //     ),
                          //     const SizedBox(width: 20,),
                          //
                          //
                          //     GestureDetector(
                          //       onTap: () {
                          //         // Get.toNamed(Routes.ACCOUNTSETTINGS);
                          //       },
                          //       child: Container(
                          //         width: ScreenSize.scaleHeight(context, 26),
                          //         height: ScreenSize.scaleHeight(context, 26),
                          //         // padding: const EdgeInsets.all( 2),
                          //         // margin: const EdgeInsets.all( 8),
                          //         decoration: BoxDecoration(
                          //           // border: Border.all(color: AppColors.eDoctorInputBorder),
                          //           color: Colors.red,
                          //           borderRadius:
                          //           BorderRadius.circular(ScreenSize.scaleHeight(context, 50)),
                          //           //boxShadow: buttonShadow
                          //         ),
                          //         child: Visibility(
                          //           visible: true,
                          //           child: Image.asset(
                          //             "assets/images/icons/h-customer-service.png",
                          //             //fit: BoxFit.fitWidth,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     const SizedBox(width: 20,),
                          //     GestureDetector(
                          //       onTap: () {
                          //         // Get.toNamed(Routes.ACCOUNTSETTINGS);
                          //       },
                          //       child: Container(
                          //         width: ScreenSize.scaleHeight(context, 26),
                          //         height: ScreenSize.scaleHeight(context, 26),
                          //         // padding: const EdgeInsets.all( 2),
                          //         // margin: const EdgeInsets.all( 8),
                          //         decoration: BoxDecoration(
                          //           // border: Border.all(color: AppColors.eDoctorInputBorder),
                          //           // color: AppColors.white,
                          //           borderRadius:
                          //           BorderRadius.circular(ScreenSize.scaleHeight(context, 50)),
                          //           //boxShadow: buttonShadow
                          //         ),
                          //         child: Visibility(
                          //           visible: true,
                          //           child: Image.asset(
                          //             "assets/images/icons/h-settings.png",
                          //             //fit: BoxFit.fitWidth,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     const SizedBox(width: 20,),
                          //     GestureDetector(
                          //       onTap: () {
                          //         // Get.toNamed(Routes.NOTIFICATIONS);
                          //       },
                          //       child: Stack(
                          //           children: [Container(
                          //             width: ScreenSize.scaleHeight(context, 26),
                          //             height: ScreenSize.scaleHeight(context, 26),
                          //             // padding: const EdgeInsets.all( 2),
                          //             // margin: const EdgeInsets.all( 8),
                          //             decoration: BoxDecoration(
                          //               // border: Border.all(color: AppColors.eDoctorInputBorder),
                          //               // color: AppColors.white,
                          //               borderRadius:
                          //               BorderRadius.circular(ScreenSize.scaleHeight(context, 50)),
                          //               //boxShadow: buttonShadow
                          //             ),
                          //             child: Visibility(
                          //               visible: true,
                          //               child: Image.asset(
                          //                 "assets/images/icons/h-notification.png",
                          //                 //fit: BoxFit.fitWidth,
                          //               ),
                          //             ),
                          //           ),
                          //
                          //             Positioned(
                          //                 right: 0,
                          //                 top: 0,
                          //                 child: Container(
                          //                   // padding: const EdgeInsets.all(2),
                          //                   width: 12, height: 12,
                          //                   decoration: new BoxDecoration(
                          //                     color: Colors.red,
                          //                     borderRadius: BorderRadius.circular(26),
                          //                   ),child: const Center(
                          //                     child: Text("#", style: TextStyle(fontSize: 10, color: AppColors.white),)
                          //                 ),))
                          //           ]
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      )),

                      // Expanded(
                      //   child: Container(
                      //     // height: ScreenSize.height(context),
                      //     width: ScreenSize.width(context),
                      //     // color: AppColors.xippGrayBackground,
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         const SizedBox(height: 20,),
                      //         Spacer(),
                      //         Container(
                      //           color: AppColors.black,
                      //           padding: EdgeInsets.all(ScreenSize.scaleWidth(context, 24)),
                      //           height: ScreenSize.scaleHeight(context, 300),
                      //           width: ScreenSize.scaleHeight(context, 300),
                      //         ),
                      //         const SizedBox(height: 20,),
                      //         Spacer(),
                      //
                      //         AskButton(
                      //             enabled: true,
                      //             text: "Login",
                      //             function: () {
                      //               // Get.to(() => XipptransferView(),
                      //               //     transition: Transition.fadeIn, // Built-in transition type
                      //               //     duration: Duration(milliseconds: 500),
                      //               //     binding: TransferBinding());
                      //             },
                      //             backgroundColor: AppColors.askBlue,
                      //             textColor: AppColors.white,
                      //             buttonWidth: ScreenSize.width(context),
                      //             buttonHeight: ScreenSize.scaleHeight(context, 60),
                      //             borderCurve: 16,
                      //             border: false,
                      //             textSize: 16
                      //         ),
                      //         const SizedBox(height: 20,),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ]),
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
                          function: () {
                            // controller.clearAuthToken();

                            // Get.toNamed(Routes.HOME);
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
                                // fontFamily: "Inter",
                                color: AppColors.askBlue
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // controller.clearOnboardingFields();

                              Get.to(() => RegisterView(),
                                  transition: Transition.fadeIn, // Built-in transition type
                                  duration: Duration(milliseconds: 500),
                                  binding: AuthBinding()
                              );
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  // fontFamily: "Inter",
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
      ),
    );
  }
}
