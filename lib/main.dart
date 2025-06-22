import 'package:ask_mobile/app/modules/home/views/requests_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'app/data/storage/cached_data.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/routes/app_pages.dart';

import 'package:firebase_core/firebase_core.dart';

final CachedData _cachedData = CachedData();
String? userType;


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  await Firebase.initializeApp();

  userType = await _cachedData.getUserType();

// Initialize deep linking
  await initDynamicLinks();


  runApp(
    GetMaterialApp(
      title: "A.S.K",
      debugShowCheckedModeBanner: false,
      initialRoute: (userType == "User") ? AppPages.HOME : AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

Future<void> initDynamicLinks() async {
  // Handle links when app is opened from terminated state
  final PendingDynamicLinkData? initialLink =
  await FirebaseDynamicLinks.instance.getInitialLink();

  if (initialLink != null) {
    _handleDynamicLink(initialLink);
  }

  // Handle links when app is in foreground/background
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    _handleDynamicLink(dynamicLinkData);
  }).onError((error) {
    print('Dynamic Link Failed: ${error.message}');
  });
}

void _handleDynamicLink(PendingDynamicLinkData dynamicLinkData) {
  final Uri uri = dynamicLinkData.link;

  if (uri.path.startsWith('/help-request/')) {
    String requestId = uri.pathSegments[1];

    Get.to(
          () => RequestsView(),
      transition: Transition.fadeIn,
      duration: Duration(milliseconds: 500),
      binding: HomeBinding(),
      arguments: {'requestId': requestId},
    );
  }
}
