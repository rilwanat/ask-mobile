// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class BannerAdExample extends StatefulWidget {
//   @override
//   _BannerAdExampleState createState() => _BannerAdExampleState();
// }
//
// class _BannerAdExampleState extends State<BannerAdExample> {
//   BannerAd? _bannerAd;
//
//
//   int _retryAttempt = 0;
//   final int _maxRetryAttempts = 1;
//
//   // bool isBannerAdLoaded = false;
//
//
//   static const String appId = 'ca-app-pub-8713818304641575/8362867834'; //live
//   // static const String appId = 'ca-app-pub-3940256099942544/6300978111'; //demo
//
//   @override
//   void initState() {
//     super.initState();
//     _loadBannerAd();
//   }
//
//   void _loadBannerAd() {
//     _bannerAd = BannerAd(
//       adUnitId: appId,
//       request: AdRequest(),
//       size: AdSize.banner,
//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$BannerAd loaded.');
//           // isBannerAdLoaded = true;
//
//           setState(() {
//             // _isLoading = false;
//             // _loadFailed = false;
//             _retryAttempt = 0;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$BannerAd failedToLoad: $error');
//           ad.dispose();
//
//           // isBannerAdLoaded = false;
//
//           if (_retryAttempt < _maxRetryAttempts) {
//             _retryAttempt++;
//             debugPrint('Retrying ad load ($_retryAttempt/$_maxRetryAttempts)...');
//             Future.delayed(const Duration(seconds: 5), _loadBannerAd);
//           }
//         },
//       ),
//     )..load();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() =>
//       SizedBox(
//         width: _bannerAd?.size.width.toDouble() ?? AdSize.banner.width.toDouble(),
//         height: _bannerAd?.size.height.toDouble() ?? AdSize.banner.height.toDouble(),
//         child: _bannerAd != null
//             ? AdWidget(ad: _bannerAd!)
//             : Image.asset('assets/images/logo-start.png', fit: BoxFit.cover), // Show nothing if ad is null
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _bannerAd?.dispose();
//     super.dispose();
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'BannerAdController.dart';

class BannerAdExample extends StatelessWidget {

  final BannerAdController controller = Get.isRegistered<BannerAdController>()
      ? Get.find<BannerAdController>()
      : Get.put(BannerAdController());

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
