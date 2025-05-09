import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/widgets/app_bar.dart';
import '../../../../global/widgets/navbar.dart';
import '../controllers/home_controller.dart';

class RequestsView extends GetView<HomeController> {
  RequestsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: AppColors.askBackground,
      drawer: NavBar(),
      appBar: CustomAppBar(
        onMenuPressed: () {
          controller.scaffoldKey.currentState?.openDrawer();
        },
        onMorePressed: () {
          // controller.scaffoldKey.currentState?.openDrawer();
        },
        title: 'A.S.K',
        backgroundColor: AppColors.askBlue,
      ),
      body: const Center(
        child: Text(
          'RequestsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
