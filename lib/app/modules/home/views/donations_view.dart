import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/LoadingScreen.dart';
import '../../../../global/widgets/app_bar_page.dart';

import '../../../../global/widgets/ask_button.dart';
import '../../../../global/widgets/fade_down_animation.dart';
import '../../../../utils/utils.dart';
import '../controllers/home_controller.dart';

class DonationsView extends GetView<HomeController> {
  const DonationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.askBackground,
      appBar: CustomAppBarPage(
        onMenuPressed: () {
          // controller.scaffoldKey.currentState?.openDrawer();
          Get.back();
        },
        onMorePressed: () {
          // controller.scaffoldKey.currentState?.openDrawer();
        },
        title: 'A.S.K - Donate',
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
                                "Donate Now",
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
                                "Kindly support us with your kind donations to help us share the pie of kindness to the vulnerable in the society. Together, we can make the world a better place.",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "LatoRegular",
                                  color: AppColors.askText,
                                  // letterSpacing: .2,
                                )
                            ),
                            const SizedBox(height: 40),

                            Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: AskButton(
                                      enabled: true,
                                      text: "Naira",
                                      function: () {
                                        controller.setDonationType("naira");
                                        //
                                        // Get.to(() => const XipptransferView(),
                                        //     transition: Transition.fadeIn, // Built-in transition type
                                        //     duration: const Duration(milliseconds: 500),
                                        //     binding: TransferBinding());
                                        // // Get.toNamed(Routes.TRANSF)
                                      },
                                      backgroundColor: controller.donationType == "naira" ? AppColors.askBlue : AppColors.white,
                                      textColor: controller.donationType == "naira" ? AppColors.white : AppColors.askBlue,
                                      buttonWidth: ScreenSize.width(context) * .2,
                                      buttonHeight: ScreenSize.scaleHeight(context, 50),
                                      borderCurve: 16,
                                      border: false,//controller.donationType == "naira" ? false : true,
                                      textSize: 16
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                    child: AskButton(
                                        enabled: true,
                                        text: "Dollar",
                                        function: () {
                                          controller.setDonationType("dollar");

                                          //
                                          // Get.to(() => const TransferscanView(),
                                          //     transition: Transition.fadeIn, // Built-in transition type
                                          //     duration: const Duration(milliseconds: 500));
                                        },
                                        backgroundColor: controller.donationType == "dollar" ? AppColors.askBlue : AppColors.white,
                                        textColor: controller.donationType == "dollar" ? AppColors.white : AppColors.askBlue,
                                        buttonWidth: ScreenSize.width(context) * .2,
                                        buttonHeight: ScreenSize.scaleHeight(context, 50),
                                        borderCurve: 16,
                                        border: false,//controller.donationType == "dollar" ? false : true,
                                        textSize: 16
                                    )),
                                const SizedBox(width: 10,),
                                Expanded(
                                    child: AskButton(
                                        enabled: true,
                                        text: "Crypto",
                                        function: () {
                                          controller.setDonationType("crypto");
                                          //
                                          // Get.to(() => const TransferscanView(),
                                          //     transition: Transition.fadeIn, // Built-in transition type
                                          //     duration: const Duration(milliseconds: 500));
                                        },
                                        backgroundColor: controller.donationType == "crypto" ? AppColors.askBlue : AppColors.white,
                                        textColor: controller.donationType == "crypto" ? AppColors.white : AppColors.askBlue,
                                        buttonWidth: ScreenSize.width(context) * .2,
                                        buttonHeight: ScreenSize.scaleHeight(context, 50),
                                        borderCurve: 16,
                                        border: false,//controller.donationType == "crypto" ? false : true,
                                        textSize: 16
                                    )),
                              ],
                            ),),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => controller.selectOption('onetime'),
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: 'onetime',
                                        groupValue: controller.selectedOption.value,
                                        onChanged: (value) {
                                          controller.selectOption(value!);
                                        },
                                      ),
                                      Text(
                                        'One-time',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "LatoRegular",
                                          color: AppColors.askText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () => controller.selectOption('recurring'),
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: 'recurring',
                                        groupValue: controller.selectedOption.value,
                                        onChanged: (value) {
                                          controller.selectOption(value!);
                                        },
                                      ),
                                      Text(
                                        'Recurring',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "LatoRegular",
                                          color: AppColors.askText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10,),

                            Obx(() =>
                            controller.donationType == "naira" ?
                            Container(
                              // color: AppColors.askBlue,
                              width: ScreenSize.width(context),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.askBlue,
                                borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 12)),
                                border: Border.all(width: 1, color: AppColors.askGray),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Row(
                                      children: [
                                        Text("${Utils.capitalizeEachWord(controller.donationType)} Donation",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "LatoRegular",
                                              color: AppColors.white,
                                              // letterSpacing: .2,
                                            )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  Wrap(
                                    spacing: 12, // horizontal gap
                                    runSpacing: 12, // vertical gap
                                    children: controller.donationsData.map((item) {
                                      return GestureDetector(
                                        onTap: () {
                                          // controller.showSelectedPriceToPay(
                                          //   controller.donationType,
                                          //   item.price,
                                          //   getCurrencySymbol(item.type),
                                          // );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          width: (ScreenSize.width(context) * .4), // For 2 columns
                                          alignment: Alignment.center,
                                          child: Text(
                                            item!.price!.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "LatoRegular",
                                              color: AppColors.askText,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            )
                                :
                            controller.donationType == "dollar" ?
                                Container(
                                  // color: AppColors.askBlue,
                                  width: ScreenSize.width(context),
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.askBlue,
                                    borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 12)),
                                    border: Border.all(width: 1, color: AppColors.askGray),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(Utils.capitalizeEachWord(controller.donationType) + " Donation",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "LatoRegular",
                                            color: AppColors.white,
                                            // letterSpacing: .2,
                                          )),
                                    ],
                                  ),
                                ) :
                            controller.donationType == "crypto" ?
                                Container(
                                  // color: AppColors.askBlue,
                                  width: ScreenSize.width(context),
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.askBlue,
                                    borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 12)),
                                    border: Border.all(width: 1, color: AppColors.askGray),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(Utils.capitalizeEachWord(controller.donationType) + " Donation",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "LatoRegular",
                                            color: AppColors.white,
                                            // letterSpacing: .2,
                                          )),
                                    ],
                                  ),
                                ) :
                                Container()
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
