import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/loading_screen.dart';
import '../../../../global/widgets/app_bar.dart';
import '../../../../global/widgets/app_bar_page.dart';

import '../../../../global/widgets/ask_button.dart';
import '../../../../global/widgets/fade_down_animation.dart';
import '../../../../global/widgets/navbar.dart';
import '../../../../utils/utils.dart';
import '../controllers/home_controller.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../../global/widgets/BannerAdExample.dart';

class DonationsView extends GetView<HomeController> {
  DonationsView({super.key});

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
        title: 'A.S.K- Donate',
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

                            // SizedBox(height: ScreenSize.scaleHeight(context, 40),),
                            const SizedBox(height: 30),
                            const Text(
                                "Donate Now",
                                style: TextStyle(
                                  fontSize: 22,
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
                            // const SizedBox(height: 40),
                            const SizedBox(height: 20),

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
                                          controller.selectOption("onetime");

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
                            const SizedBox(height: 10,),
                            Obx(() => controller.donationType != "crypto" ? Row(
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
                                Obx(() => controller.donationType == "naira" ? GestureDetector(
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
                                ) : Container()),
                              ],
                            ) : Container(),),

                            const SizedBox(height: 10,),

                            Obx(() =>
                            controller.donationType == "naira" && controller.selectedOption.value == "onetime" ?
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
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Row(
                                      children: [
                                        Text("${Utils.capitalizeEachWord(controller.donationType)} Donation",
                                            style: const TextStyle(
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
                                    children: controller.filterDonationsByType(controller.donationsData, controller.donationType).map((item) {
                                      return GestureDetector(
                                        onTap: () async {

                                          num toPay = num.parse(item!.price!);

                                          await controller.makePaymentToFundAccount(
                                              context: context,
                                              toPay: toPay,
                                              currency: 'NGN',
                                              isSubscription: false
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          width: (ScreenSize.width(context) * .4), // For 2 columns
                                          alignment: Alignment.center,
                                          child: Text(
                                            "₦${controller.formatPrice(item!.price!.toString())}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              // fontFamily: "LatoRegular",
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
                            controller.donationType == "naira" && controller.selectedOption.value == "recurring" ?
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: controller.groupPlansByInterval(controller.paystackSubscriptionsData).entries.map((entry) {
                                    final interval = entry.key;
                                    final plans = entry.value;

                                    // Sort plans by amount descending
                                    plans.sort((a, b) => b.amount!.compareTo(a.amount!));

                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          child: Row(
                                            children: [
                                              Text(
                                                  '${interval[0].toUpperCase()}${interval.substring(1)} Commitments',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "LatoRegular",
                                                    color: AppColors.white,
                                                    // letterSpacing: .2,
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                          child: Wrap(
                                            spacing: 12,
                                            runSpacing: 12,
                                            children: plans.map((plan) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  // showSelectedSubscribePriceToPay(
                                                  //   donateType,
                                                  //   plan.amount,
                                                  //   getCurrencySymbol('naira'),
                                                  //   true,
                                                  //   plan.planCode,
                                                  // );

                                                  num toPay = num.parse(plan!.amount!.toString());
                                                  // Utils.showTopSnackBar(
                                                  //     t: '${interval[0].toUpperCase()}${interval.substring(1)} Commitments',
                                                  //     m: toPay.toString(),
                                                  //     tc: AppColors.white,
                                                  //     d: 3,
                                                  //     bc: AppColors.askBlue,
                                                  //     sp: SnackPosition.TOP);

                                                  // print(plan!.planCode!.toString());
                                                  // return;

                                                  //
                                                  // required String planName,
                                                  // required int amount, // in kobo
                                                  // required String interval, // daily, weekly, monthly, yearly
                                                  // required String email,


                                                  await controller.makePaymentToFundAccount(
                                                      context: context,
                                                      toPay: toPay,
                                                      currency: 'NGN',

                                                        isSubscription: true,
                                                        planName: plan!.name!,
                                                        planCode: plan!.planCode!,
                                                        // toPay: int.parse(toPay.toString()),
                                                        interval: plan!.interval!,
                                                        email: controller.profileData.value!.emailAddress!
                                                  );

                                                  // await controller.makeSubscribePayment(
                                                  //     context: context,
                                                  //     // toPay: toPay,
                                                  //     // currency: 'NGN',
                                                  //     planName: plan!.name!,
                                                  //     planCode: plan!.planCode!,
                                                  //     toPay: int.parse(toPay.toString()),
                                                  //     interval: plan!.interval!,
                                                  //     email: controller.profileData.value!.emailAddress!
                                                  // );


                                                },
                                                child: Container(
                                                  width: (ScreenSize.width(context) * .35),
                                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 12)),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          "₦${controller.formatPrice(plan.amount!.toString())}",
                                                          // '${getCurrencySymbol('naira')}${formatPrice(plan.amount)}',
                                                          style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                            // fontFamily: "LatoRegular",
                                                            color: AppColors.askBlue,
                                                            // letterSpacing: .2,
                                                          )
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Text(
                                                          plan.name!,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: "LatoRegular",
                                                            color: AppColors.askBlue,
                                                            // letterSpacing: .2,
                                                          )
                                                      ),
                                                      // const SizedBox(height: 2),
                                                      // Text(
                                                      //   plan.interval!,
                                                      //     style: const TextStyle(
                                                      //       fontSize: 12,
                                                      //       fontWeight: FontWeight.w500,
                                                      //       fontFamily: "LatoRegular",
                                                      //       color: AppColors.askBlue,
                                                      //       // letterSpacing: .2,
                                                      //     )
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),

                                        const SizedBox(height: 20),
                                      ],
                                    );
                                  }).toList(),
                                )

                            )
                                :
                            controller.donationType == "dollar" ?
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
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Row(
                                      children: [
                                        Text("${Utils.capitalizeEachWord(controller.donationType)} Donation",
                                            style: const TextStyle(
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
                                    children: controller.filterDonationsByType(controller.donationsData, controller.donationType).map((item) {
                                      return GestureDetector(
                                        onTap: () async {

                                          num toPay = num.parse(item!.price!);

                                          await controller.makePaymentToFundAccount(
                                              context: context,
                                              toPay: toPay,
                                              currency: 'DOL',
                                              isSubscription: false
                                          );

                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          width: (ScreenSize.width(context) * .4), // For 2 columns
                                          alignment: Alignment.center,
                                          child: Text(
                                            '\$${controller.formatPrice(item!.price!.toString())}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              // fontFamily: "LatoRegular",
                                              color: AppColors.askText,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ) :
                            controller.donationType == "crypto" ?
                            Container(
                              // color: AppColors.askBlue,
                              width: ScreenSize.width(context),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.askBlue,
                                borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 12)),
                                border: Border.all(width: 1, color: AppColors.askGray),
                              ),
                              child: Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Row(
                                      children: [
                                        Text("${Utils.capitalizeEachWord(controller.donationType)} Donation",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "LatoRegular",
                                              color: AppColors.white,
                                              // letterSpacing: .2,
                                            )),
                                      ],
                                    ),
                                  ),
                                  // const SizedBox(height: 10,),

                                  Obx(() {
                                    final selected = controller.selectedAsset.value;
                                    final cryptos = controller.cryptosData.where((e) => e != null).toList();

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (selected != null)
                                            DropdownButtonFormField<String>(
                                              value: selected.network,
                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                                // focusedBorder: OutlineInputBorder(
                                                //   borderSide: const BorderSide(color: Colors.teal, width: 2),
                                                //   borderRadius: BorderRadius.circular(8),
                                                // ),
                                                filled: true,
                                                fillColor: AppColors.white,
                                              ),
                                              items: [
                                                const DropdownMenuItem(
                                                  value: "Select",
                                                  child: Text("Select Crypto Network", style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "LatoRegular",
                                                    color: AppColors.askBlue,
                                                    // letterSpacing: .2,
                                                  )),
                                                ),
                                                ...cryptos.map((asset) {
                                                  return DropdownMenuItem<String>(
                                                    value: asset!.network!,
                                                    child: Text(asset.network!, style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "LatoRegular",
                                                      color: AppColors.askBlue,
                                                      // letterSpacing: .2,
                                                    )),
                                                  );
                                                }).toList(),
                                              ],
                                              onChanged: (value) {
                                                final found = cryptos.firstWhere(
                                                      (asset) => asset!.network == value,
                                                  orElse: () => controller.defaultCrypto,
                                                );
                                                controller.selectedAsset.value = found;
                                              },
                                            ),

                                          const SizedBox(height: 10),

                                          if (selected != null)
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          selected.address ?? '',
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: "LatoRegular",
                                                            color: AppColors.white,
                                                            // letterSpacing: .2,
                                                          )
                                                      ),
                                                    ),
                                                    const SizedBox(width: 16),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Clipboard.setData(
                                                          ClipboardData(text: selected.address ?? ''),
                                                        );
                                                        // ScaffoldMessenger.of(context).showSnackBar(
                                                        //   SnackBar(
                                                        //     content: Text("Wallet address copied:\n${selected.address}"),
                                                        //     backgroundColor: AppColors.askBlue,
                                                        //   ),
                                                        //
                                                        // );
                                                        Utils.showTopSnackBar(
                                                            t: controller.selectedAsset.value!.network!,
                                                            m: "Wallet address copied:\n${selected.address}",
                                                            tc: AppColors.white,
                                                            d: 3,
                                                            bc: AppColors.askBlue,
                                                            sp: SnackPosition.TOP);
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                        decoration: BoxDecoration(
                                                          color: AppColors.white,
                                                          // border: Border.all(color: Colors.teal, width: 2),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: const Text(
                                                            "Copy",
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w500,
                                                              fontFamily: "LatoRegular",
                                                              color: AppColors.askBlue,
                                                              // letterSpacing: .2,
                                                            )
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(height: 12),

                                                Center(
                                                  child: Container(
                                                    width: 200,//double.infinity,
                                                    height: 200,
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white,
                                                      borderRadius: BorderRadius.circular(12),

                                                    ),
                                                    child: selected.image != null
                                                        ?
                                                    CachedNetworkImage(
                                                      imageUrl:
                                                      dotenv.getBool('LIVE_MODE') == false
                                                          ? "https://playground.askfoundations.org/${selected.image}"
                                                          : "https://askfoundations.org/${selected.image}",
                                                      fit: BoxFit.contain,//cover, // Changed from contain to cover
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 1)),
                                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                                    )
                                                        : const Center(child: Text("No image")),
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    );
                                  })



                                ],
                              ))
                              ,
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
