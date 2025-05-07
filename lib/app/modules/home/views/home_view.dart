import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/screen_size.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.askBackground,
      // appBar: AppBar(
      //   title: const Text('HomeView'),
      //   centerTitle: true,
      // ),
      body: Obx(
            () => controller.screens.elementAt(controller.navIndex),
      ),

      bottomNavigationBar: Obx(
            () => controller.showBottomNav.value ? Container(
          // color: AppColors.black,
          height: 60,
          margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          // decoration: BoxDecoration(
          //   color: AppColors.xippBlueDark,
          //   borderRadius: BorderRadius.circular(ScreenSize.scaleWidth(context, 22)),
          //   border: Border.all(width: 1, color: AppColors.xippText),
          // ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ScreenSize.scaleWidth(context, 22)),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              type: BottomNavigationBarType.fixed,
              onTap: controller.handleNavigation,
              currentIndex: controller.navIndex,
              selectedItemColor: AppColors.askBlue,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: const TextStyle(fontSize: 10),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SizedBox(
                      height: 26,
                      width: 26,
                      child: Image.asset(
                        controller.navIndex == 0 ?
                        "assets/images/icons/m-home-b.png" :
                        "assets/images/icons/m-home-a.png",
                        //fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SizedBox(
                      height: 26,
                      width: 26,
                      child: Image.asset(
                        controller.navIndex == 1 ?
                        "assets/images/icons/m-insight-b.png" :
                        "assets/images/icons/m-insight-a.png",
                        //fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  label: 'AI Budget',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SizedBox(
                      height: 26,
                      width: 26,
                      child: Image.asset(
                        controller.navIndex == 2 ?
                        "assets/images/icons/m-transaction-b.png" :
                        "assets/images/icons/m-transaction-a.png",
                        //fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  label: 'Transactions',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SizedBox(
                      height: 26,
                      width: 26,
                      child: Image.asset(
                        controller.navIndex == 3 ?
                        "assets/images/icons/m-user-b.png" :
                        "assets/images/icons/m-user-a.png",
                        //fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  label: 'Account',
                ),
              ],
            ),
          ),
        ) : const SizedBox(),
      ),
    );
  }
}

