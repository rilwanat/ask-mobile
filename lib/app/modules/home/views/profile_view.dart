import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/widgets/app_bar_page.dart';
import '../../../../global/widgets/app_bar.dart';
import '../../../../global/widgets/navbar.dart';
import '../controllers/home_controller.dart';

class ProfileView extends GetView<HomeController> {
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.askBackground,
      // drawer: NavBar(),
      appBar: CustomAppBarPage(
        onMenuPressed: () {
          // controller.scaffoldKey.currentState?.openDrawer();
          Get.back();
        },
        onMorePressed: () {
          // controller.scaffoldKey.currentState?.openDrawer();
        },
        title: 'A.S.K - Profile',
        backgroundColor: AppColors.askBlue,
      ),
      body: const Center(
        child: Text(
          'ProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
