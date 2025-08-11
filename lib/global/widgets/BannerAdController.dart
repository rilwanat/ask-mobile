import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../app/modules/home/controllers/home_controller.dart';

class BannerAdController extends GetxController {
  final Rx<BannerAd?> bannerAd = Rx<BannerAd?>(null);
  final RxBool isBannerAdLoaded = false.obs;

  int _retryAttempt = 0;
  final int _maxRetryAttempts = 1;

  final homeController = Get.find<HomeController>();
  String? adUnitId;

  @override
  void onInit() {
    super.onInit();

    // adUnitId = homeController.adMobUnit.value;
    // print(adUnitId);
    // _loadBannerAd();

    // Wait for HomeController to be ready
    ever(Get.find<HomeController>().adMobUnit, (value) {
      if (value.isNotEmpty) {
        adUnitId = value;
        // debugPrint('AdUnitId loaded: $adUnitId');
        _loadBannerAd();
      }
    });

    // Trigger initial check in case value was already set
    final homeAdUnit = Get.find<HomeController>().adMobUnit.value;
    if (homeAdUnit.isNotEmpty) {
      adUnitId = homeAdUnit;
      // debugPrint('AdUnitId loaded immediately: $adUnitId');
      _loadBannerAd();
    }
  }

  void _loadBannerAd() {
    final ad = BannerAd(
      adUnitId: adUnitId!,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          bannerAd.value = ad as BannerAd;
          isBannerAdLoaded.value = true;
          _retryAttempt = 0;
          debugPrint('BannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          isBannerAdLoaded.value = false;
          debugPrint('BannerAd failedToLoad: $error');

          if (_retryAttempt < _maxRetryAttempts) {
            _retryAttempt++;
            Future.delayed(const Duration(seconds: 5), _loadBannerAd);
          }
        },
      ),
    );

    ad.load();
  }

  @override
  void onClose() {
    bannerAd.value?.dispose();
    super.onClose();
  }
}
