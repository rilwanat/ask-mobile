import 'dart:async';
import 'package:ask_mobile/app/modules/onboarding/views/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/data/storage/cached_data.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/home/views/home_view.dart';
import 'app/modules/onboarding/bindings/onboarding_binding.dart';
import 'app/routes/app_pages.dart';

final CachedData _cachedData = CachedData();
late AppLinks _appLinks;
StreamSubscription<Uri>? _linkSubscription;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  _appLinks = AppLinks();

  final userType = await _cachedData.getUserType();

  runApp(MyApp(userType: userType));

  _handleInitialDeepLink();
}

class MyApp extends StatelessWidget {
  final String? userType;

  const MyApp({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "A.S.K",
      debugShowCheckedModeBanner: false,
      home: userType == "User" ? HomeView() : OnboardingView(),
      // initialRoute: userType == "User" ? Routes.HOME : Routes.ONBOARDING,
      // getPages: AppPages.routes,
      initialBinding: BindingsBuilder(() {
        if (userType == "User") {
          HomeBinding().dependencies();
        } else {
          // Your onboarding binding
          OnboardingBinding().dependencies();
        }
      }),
    );
  }
}

Future<void> _handleInitialDeepLink() async {
  try {
    await Future.delayed(const Duration(milliseconds: 800));

    final uri = await _appLinks.getInitialLink();
    if (uri != null) {
      await _processDeepLink(uri);
    }

    _linkSubscription = _appLinks.uriLinkStream.listen(_processDeepLink);
  } catch (e) {
    debugPrint('Deep link initialization error: $e');
  }
}

Future<void> _processDeepLink(Uri uri) async {
  debugPrint('Processing deep link: $uri');

  if (uri.pathSegments.length >= 2 && uri.pathSegments.first == 'help-request') {
    final requestId = uri.pathSegments[1];
    await _safeDeepLinkNavigation(requestId);
  }
}

Future<void> _safeDeepLinkNavigation(String requestId) async {
  debugPrint('### Deep link started');

  try {
    if (!Get.isRegistered<HomeController>()) {
      HomeBinding().dependencies();
    }

    // await Get.offAll(() => const HomeView());

    final controller = Get.find<HomeController>();

    // // Wait for HomeView and filteredRequestsData to be ready
    // int retries = 0;
    // while ((!controller.singleRequestScrollController.hasClients ||
    //     controller.filteredRequestsData.isEmpty) &&
    //     retries < 20) {
    //   await Future.delayed(const Duration(milliseconds: 300));
    //   retries++;
    //   debugPrint("Waiting for scroll controller and data... retry $retries");
    // }

    // Switch to the Requests tab
    controller.handleNavigation(1);
    await Future.delayed(const Duration(milliseconds: 300));

    // Scroll to the request
    await controller.scrollToNewRequestViaHelptoken(requestId);
    debugPrint('### Deep link finished');
  } catch (e, stack) {
    debugPrint('Deep link error: $e\n$stack');
  }
}




