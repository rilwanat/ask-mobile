import 'dart:async';
import 'package:ask_mobile/app/modules/home/views/requests_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app_links/app_links.dart';
import 'app/data/storage/cached_data.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/home/views/home_view.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

final CachedData _cachedData = CachedData();
String? userType;
late AppLinks _appLinks;
StreamSubscription<Uri>? _linkSubscription;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();

  userType = await _cachedData.getUserType();

  // Initialize AppLinks instance
  _appLinks = AppLinks();

  // Initialize deep linking
  initDeepLinking();

  runApp(
    GetMaterialApp(
      title: "A.S.K",
      debugShowCheckedModeBanner: false,
      initialRoute: (userType == "User") ? AppPages.HOME : AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

void initDeepLinking() {
  // Get the initial link if app was launched from one
  _appLinks.getInitialLink().then((Uri? uri) {
    debugPrint('Initial URI: $uri');
    if (uri != null) {
      _handleDeepLink(uri);
    }
  });

  // Listen for incoming links
  _linkSubscription = _appLinks.uriLinkStream.listen((Uri uri) {
    debugPrint('Incoming deep link: $uri');
    _handleDeepLink(uri);
  }, onError: (error) {
    debugPrint('Deep link error: $error');
  });
}

void _handleDeepLink(Uri uri) async {
  debugPrint('Handling deep link: $uri');

  if (uri.pathSegments.length >= 2 &&
      uri.pathSegments.first == 'help-request') {

    final requestId = uri.pathSegments[1];
    debugPrint('Navigating to request: $requestId');

    // Get.to(() => HomeView(),
    //     transition: Transition.fadeIn, // Built-in transition type
    //     duration: Duration(milliseconds: 500),
    //     binding: HomeBinding()
    // );
    Get.find<HomeController>().handleNavigation(1);
    await Get.find<HomeController>().scrollToNewRequestViaHelptoken(requestId);

    //
    //
    // // First navigate to the RequestsView (index 1 in your bottom nav)
    // Get.until((route) => Get.currentRoute == AppPages.HOME);
    //
    // Get.find<HomeController>().handleNavigation(1);
    // // Then push the specific request with arguments
    // Get.to(
    //       () => RequestsView(),
    //   transition: Transition.fadeIn,
    //   duration: const Duration(milliseconds: 500),
    //   arguments: {'requestId': requestId},
    // );



  } else {
    debugPrint('Unhandled deep link path: ${uri.path}');
  }
}