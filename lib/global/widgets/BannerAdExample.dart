import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'BannerAdController.dart';

class BannerAdExample extends StatelessWidget {

  final BannerAdController controller =
  // Get.isRegistered<BannerAdController>()
  //     ? Get.find<BannerAdController>()
  //     :
  // Get.put(BannerAdController());
  Get.put(BannerAdController(), tag: UniqueKey().toString());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ad = controller.bannerAd.value;
      final isLoaded = controller.isBannerAdLoaded.value;

      return SizedBox(
        width: ad?.size.width.toDouble() ?? AdSize.banner.width.toDouble(),
        height: ad?.size.height.toDouble() ?? AdSize.banner.height.toDouble(),
        child: isLoaded && ad != null
            ? AdWidget(ad: ad)
            // : Image.asset('assets/images/logo-start.png', fit: BoxFit.cover),
            : Image.asset('assets/images/banner.png', fit: BoxFit.cover),
      );
    });
  }
}
