import 'package:ask_mobile/app/modules/auth/bindings/auth_binding.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/fade_down_animation.dart';
import '../../../../global/widgets/ask_button.dart';
import '../../auth/views/register_view.dart';
import '../../home/views/home_view.dart';
import '../controllers/onboarding_controller.dart';
import '../../../../global/widgets/inverted_radius_clipper.dart';

import 'package:carousel_slider/carousel_slider.dart';


class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.askBackground,
        // appBar: AppBar(
        //   title: const Text('OnboardingView'),
        //   centerTitle: true,
        // ),
        body:
        // Obx(() =>
        Stack(
          children: [
            Container(
              height: ScreenSize.height(context),
              width: ScreenSize.width(context),
              // color: AppColors.xippGrayBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80,),
                  Container(
                    // color: AppColors.white,
                    padding: EdgeInsets.all(ScreenSize.scaleWidth(context, 24)),
                    height: ScreenSize.scaleHeight(context, 200),
                    width: ScreenSize.scaleHeight(context, 200),
                    child: FadeDownAnimation(
                      delayMilliSeconds: 1500,
                      duration: 700,
                      child: Image.asset(
                        "assets/images/logo-start.png",
                        //fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),

                  // const SizedBox(height: 60,),
                  CarouselSlider.builder(
                    itemCount: controller.onboardingTexts.length,
                    itemBuilder: (context, index, realIndex) {
                      final current = controller.onboardingTexts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              current['title']!,
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                                fontFamily: "LatoRegular",
                                color: AppColors.askBlue,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              current['subtitle']!,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                fontFamily: "LatoRegular",
                                color: AppColors.askText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        controller.setStep(index);
                      },
                      enableInfiniteScroll: false, // If you don't want it to loop back
                      scrollPhysics: const ClampingScrollPhysics(), // Prevents infinite scroll
                      height: 400, // Adjust height as needed
                      viewportFraction: 1.0,
                    ),
                  )

                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [

                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(1.0, -1.2), // Flip vertically
                    child: ClipPath(
                      clipper: InvertedRadiusClipper(),
                      child: Container(
                        color: AppColors.askBlue,
                        height: 30,
                      ),
                    ),
                  ),
                  Container(
                    color: AppColors.askBlue,
                    height: 10,
                  ),


                  Container(
                    // color: AppColors.askBlue,
                    decoration: BoxDecoration(

                      gradient: const LinearGradient(
                        colors: [
                          AppColors.askBlue,
                          AppColors.black,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const SizedBox(height: 10,),

                        Obx(() => Container(
                          // color: Colors.red,
                          height: ScreenSize.scaleHeight(context, 54),
                          width: ScreenSize.width(context),
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // controller.setStep(0);
                                },
                                child: Container(
                                  width: ScreenSize.scaleHeight(context, 12),
                                  height: ScreenSize.scaleHeight(context, 12),
                                  decoration: BoxDecoration(
                                    color: controller.currentStep == 0 ? AppColors.white : AppColors.askLightBlue,
                                    borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 12)),
                                    border: Border.all(width: 1, color: AppColors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12,),
                              GestureDetector(
                                onTap: () {
                                  // controller.setStep(1);
                                },
                                child: Container(
                                  width: ScreenSize.scaleHeight(context, 12),
                                  height: ScreenSize.scaleHeight(context, 12),
                                  decoration: BoxDecoration(
                                    color: controller.currentStep == 1 ? AppColors.white : AppColors.askLightBlue,
                                    borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 12)),
                                    border: Border.all(width: 1, color: AppColors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12,),
                              GestureDetector(
                                onTap: () {
                                  // controller.setStep(2);
                                },
                                child: Container(
                                  width: ScreenSize.scaleHeight(context, 12),
                                  height: ScreenSize.scaleHeight(context, 12),
                                  decoration: BoxDecoration(
                                    color: controller.currentStep == 2 ? AppColors.white : AppColors.askLightBlue,
                                    borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 12)),
                                    border: Border.all(width: 1, color: AppColors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),

                        const SizedBox(height: 40,),

                        AskButton(
                            enabled: true,
                            text: "Get Started",
                            function: () {
                              // controller.clearAuthToken();

                              Get.to(() => RegisterView(),
                                  transition: Transition.fadeIn, // Built-in transition type
                                  duration: Duration(milliseconds: 500),
                                binding: AuthBinding()
                              );
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
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      // ),
    );
  }
}