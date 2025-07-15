import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/loading_screen.dart';
import '../../../../global/widgets/app_bar.dart';
import '../../../../global/widgets/ask_button.dart';
import '../../../../global/widgets/fade_down_animation.dart';
import '../../../../global/widgets/navbar.dart';
import '../../../../utils/utils.dart';
import '../controllers/home_controller.dart';

import '../../../data/models/requests/Data.dart' as hrd;

import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../../global/widgets/BannerAdExample.dart';

class RequestsView extends GetView<HomeController> {
  RequestsView({
    super.key
  });

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
        title: 'Requests',
        backgroundColor: AppColors.askBlue,
      ),
      body: Obx(() => controller.isLoading
          ? const LoadingScreen()
          : Column(
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
          // const Text(
          //   "Help Requests",
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.w700,
          //     fontFamily: "LatoRegular",
          //     color: AppColors.askBlue,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
          // const SizedBox(height: 4,),
          // Container(
          //   color: AppColors.askBlue,
          //   height: 2,
          //   width: 64,
          // ),
          const SizedBox(height: 8,),
          Padding(
            // padding: const EdgeInsets.symmetric(vertical: 0.0),
            padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),
            child: Container(
              // color: AppColors.red,
              // width: ScreenSize.width(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        controller.goToPreviousItem();
                      },
                      child: Container(
                          height: 44,
                          width: 44,
                          // color: AppColors.askBlue,
                          decoration: BoxDecoration(
                            color: AppColors.askBlue,
                            borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 8)),
                            border: Border.all(width: 1, color: AppColors.askGray),
                          ),
                          child: Center(child: const Icon(Icons.keyboard_arrow_left, size: 18, color: AppColors.white,)))),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: FadeDownAnimation(
                      delayMilliSeconds: 400,
                      duration: 700,
                      child: TextFormField(
                        // initialValue: controller.profileData.value!.emailAddress,
                        controller: controller.searchRequestsController,
                        onChanged: (value) {
                          controller.searchText.value = value;
                        },
                        // focusNode: controller.loginEmailFocusNode,
                        //cursorColor: AppColors.blue,
                        // maxLength: 10,
                        decoration: InputDecoration(
                          hintText: "Search requests",
                          filled: true,
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "LatoRegular",
                          ),
                          fillColor: AppColors.askBlue,
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
                          // contentPadding: const EdgeInsets.only(left: 20),
                          contentPadding: const EdgeInsets.symmetric(vertical: 2),
                        ),
                        textAlign: TextAlign.center,
                        // readOnly: true,
                        keyboardType:
                        TextInputType.text,
                        style: const TextStyle(
                          //letterSpacing: 0.7,
                          fontSize: 16,
                          color: AppColors.white,
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
                  ),
                  const SizedBox(width: 12,),
                  GestureDetector(
                      onTap: () {
                        controller.goToNextItem();
                      },
                      child: Container(
                          height: 44,
                          width: 44,
                          // color: AppColors.askBlue,
                          decoration: BoxDecoration(
                            color: AppColors.askBlue,
                            borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 8)),
                            border: Border.all(width: 1, color: AppColors.askGray),
                          ),
                          child: const Center(child: Icon(Icons.keyboard_arrow_right, size: 18, color: AppColors.white,)))),

                ],
              ),
            ),
          ),
          const SizedBox(height: 8,),
          Container(
            color: AppColors.askBlue,
            height: 2,
            width: 128,
          ),
          const SizedBox(height: 8,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),

              child: Container(
                // color: AppColors.white,
                // padding: const EdgeInsets.symmetric(vertical: 4),
                  height: ScreenSize.height(context) * .7,
                  child: Obx(() => ListView.builder(
                    controller: controller.singleRequestScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.filteredRequestsData.length,
                    itemBuilder: (context, index) {

                      hrd.Data helpRequest = controller.filteredRequestsData[index]!;

                      return GestureDetector(
                        onLongPress: () {
                          // controller.showTopSnackBar(
                          //   t: "#",
                          //   m: "long pressed...",
                          //   tc: AppColors.black,
                          //   d: 3,
                          //   bc: AppColors.green,
                          //   sp: SnackPosition.BOTTOM,
                          // );
                        },
                        onTap: () {
                          // controller.handleNavigation(1);

                          // //open product details view
                          // Get.to(() => ProductDetailsView(
                          //   product: product,
                          //   productImage:
                          //   "https://es.shopafricana.co/product-images/detailed-900x1125/" + "${product.productImages![0]}",
                          // ));

                          // Utils.showTopSnackBar(
                          //   t: helpRequest.user!.fullname!,
                          //   m: "Request view will open",
                          //   tc: AppColors.white,
                          //   d: 3,
                          //   bc: AppColors.askBlue,
                          //   sp: SnackPosition.BOTTOM,
                          // );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(right: 8),
                          // color: Colors.redAccent,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 12)),
                            border: Border.all(width: 1, color: AppColors.askGray),
                          ),
                          width: ScreenSize.width(context) * .8,
                          height: ScreenSize.height(context) * .6,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    "You are viewing ${helpRequest.user!.fullname!}'s help request",
                                    style: const TextStyle(
                                      fontFamily: "LatoRegular",
                                      color: AppColors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                    // maxLines: 1,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  "token: ${helpRequest.helpToken!}",
                                  style: const TextStyle(
                                    fontFamily: "LatoRegular",
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                  // maxLines: 1,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "helpRequest: ${helpRequest.id!}",
                                  style: const TextStyle(
                                    fontFamily: "LatoRegular",
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                  // maxLines: 1,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "id: ${index}",
                                  style: const TextStyle(
                                    fontFamily: "LatoRegular",
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                  // maxLines: 1,
                                  // overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  // color: AppColors.red,
                                  width: ScreenSize.width(context),
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    helpRequest.description!,
                                    style: const TextStyle(
                                      fontFamily: "LatoRegular",
                                      color: AppColors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                    // maxLines: 1,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Center(
                                  child: SizedBox(
                                    height: ScreenSize.width(context) * .6,
                                    width: ScreenSize.width(context) * .6,
                                    child: Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: Container(
                                            // height: ScreenSize.width(context) * .8,
                                            // width: ScreenSize.width(context) * .8,
                                            decoration: BoxDecoration(
                                              color: AppColors.askBlue,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10), // Match container's border radius
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                dotenv.getBool('LIVE_MODE') == false
                                                    ? "https://playground.askfoundations.org/backend/api/v1/response/${helpRequest.requestImage}"
                                                    : "https://askfoundations.org/${helpRequest.requestImage}",
                                                fit: BoxFit.cover, // Changed from contain to cover
                                                width: double.infinity,
                                                height: double.infinity,
                                                placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 1)),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.formatNominationCount(helpRequest.nominationCount!),
                                      style: const TextStyle(
                                        fontFamily: "LatoRegular",
                                        color: AppColors.askBlue,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Icon(Icons.favorite)
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AskButton(
                                      enabled: true,
                                      text: "Confirm Nomination",
                                      function: () async {

                                        String email = controller.profileData.value!.emailAddress!;
                                        String helpToken = helpRequest.helpToken!;
                                        String? fingerPrint = await Utils.getDeviceId();

                                        controller.handleNominate(
                                            email: email,
                                            helpToken: helpToken,
                                            fingerPrint: fingerPrint!
                                        );

                                        // Utils.showTopSnackBar(
                                        //   t: helpRequest.user!.fullname!,
                                        //   m: "Request view will open",
                                        //   tc: AppColors.white,
                                        //   d: 3,
                                        //   bc: AppColors.askBlue,
                                        //   sp: SnackPosition.BOTTOM,
                                        // );

                                      },
                                      backgroundColor: AppColors.askOrange,
                                      textColor: AppColors.white,
                                      buttonWidth: ScreenSize.scaleWidth(context, 200),
                                      buttonHeight: ScreenSize.scaleHeight(context, 50),
                                      borderCurve: 12,
                                      border: false,
                                      textSize: 14,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AskButton(
                                      enabled: true,
                                      text: "Share",
                                      function: () async {

                                        // Utils.shareText();
                                        Utils.shareText(
                                        dotenv.getBool('LIVE_MODE') == false
                                        ? "https://playground.askfoundations.org/help-request/${helpRequest.helpToken}"
                                        : "https://askfoundations.org/help-request/${helpRequest.helpToken}"
                                        );

                                      },
                                      backgroundColor: AppColors.askBlue,
                                      textColor: AppColors.white,
                                      buttonWidth: ScreenSize.scaleWidth(context, 200),
                                      buttonHeight: ScreenSize.scaleHeight(context, 50),
                                      borderCurve: 12,
                                      border: false,
                                      textSize: 14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))),
            ),
          ),
        ],
      )),
    );
  }
}
