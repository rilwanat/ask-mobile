import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/data/storage/cached_data.dart';
import 'app/routes/app_pages.dart';


final CachedData _cachedData = CachedData();
String? userType;


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  userType = await _cachedData.getUserType();


  runApp(
    GetMaterialApp(
      title: "A.S.K",
      debugShowCheckedModeBanner: false,
      initialRoute: (userType == "User") ? AppPages.HOME : AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
