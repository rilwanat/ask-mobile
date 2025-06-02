import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdExample extends StatefulWidget {
  @override
  _BannerAdExampleState createState() => _BannerAdExampleState();
}

class _BannerAdExampleState extends State<BannerAdExample> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',//'ca-app-pub-8713818304641575/8362867834',
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
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