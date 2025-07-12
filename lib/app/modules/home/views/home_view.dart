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
      key: controller.scaffoldKey,

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
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          // decoration: BoxDecoration(
          //   color: AppColors.xippBlueDark,
          //   borderRadius: BorderRadius.circular(ScreenSize.scaleWidth(context, 22)),
          //   border: Border.all(width: 1, color: AppColors.xippText),
          // ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ScreenSize.scaleWidth(context, 22)),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: AppColors.askBlue,
              type: BottomNavigationBarType.fixed,
              onTap: controller.handleNavigation,
              // onTap: (int index) {
              //   controller.handleNavigation(index);
              //   Navigator.of(context).pop();
              // },
              currentIndex: controller.navIndex,
              selectedItemColor: AppColors.white,
              unselectedItemColor: AppColors.askBackground,
              selectedLabelStyle: const TextStyle(fontSize: 10),
              unselectedLabelStyle: const TextStyle(fontSize: 10),
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SizedBox(
                      height: 26,
                      width: 26,
                      child: Icon(Icons.home,
                        color: controller.navIndex == 0 ? AppColors.white : AppColors.askGray,
                      )
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
                      child: Icon(Icons.request_page,
                        color: controller.navIndex == 1 ? AppColors.white : AppColors.askGray,
                      ),
                    ),
                  ),
                  label: 'Nominate',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SizedBox(
                      height: 26,
                      width: 26,
                      child: Icon(Icons.question_answer  ,
                        color: controller.navIndex == 2 ? AppColors.white : AppColors.askGray,
                      ),
                    ),
                  ),
                  label: 'iAsk',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SizedBox(
                      height: 26,
                      width: 26,
                      child:
                      // Icon(Icons.account_circle,
                      Icon(Icons.waving_hand,
                      color: controller.navIndex == 3 ? AppColors.white : AppColors.askGray,
                      )
                    ),
                  ),
                  // label: 'Profile',
                  label: 'Donate',
                ),
              ],
            ),
          ),
        ) : const SizedBox(),
      ),
    );
  }
}

