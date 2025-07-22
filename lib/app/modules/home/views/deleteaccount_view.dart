import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/app_bar_page.dart';
import '../../../../global/widgets/ask_button.dart';
import '../../../../global/widgets/fade_down_animation.dart';
import '../../../../global/widgets/loading_screen.dart';
import '../../../../utils/utils.dart';
import '../controllers/home_controller.dart';

class DeleteaccountView extends GetView<HomeController> {
  const DeleteaccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.askBackground,
      // drawer: NavBar(),
      appBar: CustomAppBarPage(
        onMenuPressed: () {
          Get.back();
        },
        onMorePressed: () {
        },
        title: '',
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
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                            //   child: Container(
                            //     // color: AppColors.askBlue,
                            //     height: AdSize.banner.height.toDouble(), // 50.0 for standard banner
                            //     child: BannerAdExample(),
                            //   ),
                            // ),
                            // //

                            SizedBox(height: 10,),

                            SizedBox(height: 8,),






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
                                        "A.S.K Delete Account",
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

                                  // Description Field
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Hello,",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "LatoRegular",
                                            // letterSpacing: .2,
                                            color: AppColors.askText,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          "You requested to delete your A.S.K account.",
                                          // "\nEnter your email below and we'll send you a token.",
                                          textAlign: TextAlign.center,
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
                                            readOnly: true,
                                            controller: controller.deleteEmailController,
                                            // focusNode: controller.loginEmailFocusNode,
                                            //cursorColor: AppColors.blue,
                                            decoration: InputDecoration(
                                              // hintText: "Describe your Help Request here...",
                                              // fillColor: AppColors.white,
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBackground,//askBlue,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors
                                                      .askBackground,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: AppColors.askBackground,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              contentPadding:
                                              const EdgeInsets.only(left: 20),
                                            ),
                                            // readOnly: true,
                                            maxLines: 1,
                                            keyboardType:
                                            TextInputType.text,
                                            style: const TextStyle(
                                              // //letterSpacing: 0.7,
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "LatoRegular",
                                            ),
                                            textAlign: TextAlign.center,
                                            inputFormatters: const [
                                              //FilteringTextInputFormatter.digitsOnly,
                                              //LengthLimitingTextInputFormatter(13),
                                            ],
                                            validator: (value) {

                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 4),
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
                                                  text: controller.isLoading ? 'Please wait..' : "Send Delete Token",
                                                  function: () async {

                                                    await controller.sendDeleteToken(
                                                        email: controller.deleteEmailController.text
                                                    );

                                                    // Utils.showInformationDialog(status: null,
                                                    //     title: 'A.S.K Help Request',
                                                    //     message: "Enter a Help Request description and select an image to upload");

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



                                        const SizedBox(
                                          height: 10,
                                        ),



                                        const SizedBox(height: 20),
                                        const Text(
                                          "Enter the token you received below to delete your A.S.K account:",
                                          textAlign: TextAlign.center,
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
                                            controller: controller.deleteTokenController,
                                            // focusNode: controller.loginEmailFocusNode,
                                            //cursorColor: AppColors.blue,
                                            decoration: InputDecoration(
                                              hintText: "Delete Token",
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
                                            maxLines: 1,
                                            keyboardType:
                                            TextInputType.text,
                                            style: const TextStyle(
                                              // //letterSpacing: 0.7,
                                              fontSize: 16,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "LatoRegular",
                                            ),
                                            textAlign: TextAlign.center,
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
                                            text: controller.isLoading ? 'Please wait..' : "Delete My Account",
                                            function: () async {

                                              await controller.deleteAccount(
                                                  email: controller.deleteEmailController.text,
                                                  deleteToken: controller.deleteTokenController.text
                                              );

                                              // Utils.showInformationDialog(status: null,
                                              //     title: 'A.S.K Help Request',
                                              //     message: "Enter a Help Request description and select an image to upload");

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

          ],
        ),),
      ),
    );
  }
}
