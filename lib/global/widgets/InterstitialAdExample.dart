import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdExample extends StatefulWidget {
  @override
  _InterstitialAdExampleState createState() => _InterstitialAdExampleState();
}

class _InterstitialAdExampleState extends State<InterstitialAdExample> {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;
  bool _adShown = false;

  final String _adUnitId = 'ca-app-pub-8713818304641575/1346575917';

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isAdLoaded && !_adShown) {
      _showInterstitialAd();
    }
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          setState(() {
            _interstitialAd = ad;
            _isAdLoaded = true;
          });

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              ad.dispose();
              setState(() {
                _isAdLoaded = false;
                _adShown = true;
              });
              Navigator.of(context).pop(); // Close the ad screen after showing
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
              ad.dispose();
              setState(() {
                _isAdLoaded = false;
                _adShown = true;
              });
              Navigator.of(context).pop(); // Close the ad screen if failed to show
            },
          );

          // Show ad immediately after loading
          if (_isAdLoaded) {
            _showInterstitialAd();
          }
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
          setState(() {
            _isAdLoaded = false;
            _adShown = true;
          });
          Navigator.of(context).pop(); // Close if ad fails to load
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_isAdLoaded && _interstitialAd != null && !_adShown) {
      setState(() {
        _adShown = true;
      });
      _interstitialAd?.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('Advertisement'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(strokeWidth: 1),
            SizedBox(height: 20),
            Text('Loading advertisement...',
              style: const TextStyle(
                fontFamily: "LatoRegular",
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),),
          ],
        ),
      ),
    );
  }
}