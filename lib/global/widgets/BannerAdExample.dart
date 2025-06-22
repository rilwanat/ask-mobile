import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdExample extends StatefulWidget {
  @override
  _BannerAdExampleState createState() => _BannerAdExampleState();
}

class _BannerAdExampleState extends State<BannerAdExample> {
  BannerAd? _bannerAd;


  int _retryAttempt = 0;
  final int _maxRetryAttempts = 1;


  static const String appId = 'ca-app-pub-8713818304641575/8362867834'; //live
  // static const String appId = 'ca-app-pub-3940256099942544/6300978111'; //demo

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: appId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            // _isLoading = false;
            // _loadFailed = false;
            _retryAttempt = 0;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();

          if (_retryAttempt < _maxRetryAttempts) {
            _retryAttempt++;
            debugPrint('Retrying ad load ($_retryAttempt/$_maxRetryAttempts)...');
            Future.delayed(const Duration(seconds: 5), _loadBannerAd);
          }
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _bannerAd?.size.width.toDouble() ?? AdSize.banner.width.toDouble(),
      height: _bannerAd?.size.height.toDouble() ?? AdSize.banner.height.toDouble(),
      child: _bannerAd != null
          ? AdWidget(ad: _bannerAd!)
          : const SizedBox.shrink(), // Show nothing if ad is null
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}