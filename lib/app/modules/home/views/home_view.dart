import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/screen_size.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        // Example: prevent leaving the HomeView unless on first tab
        if (controller.navIndex != 0) {
          controller.handleNavigation(0);
          return false; // block the back button
        }

        // Optional: confirm exit
        final shouldExit = await Get.dialog<bool>(
          AlertDialog(
            title: const Text("Exit A.S.K",style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              fontFamily: "LatoRegular",
              color: AppColors.askBlue,
              // letterSpacing: .2,
            )),
            content: const Text("Do you want to exit A.S.K ?",style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "LatoRegular",
              color: AppColors.askBlue,
              // letterSpacing: .2,
            )),
            actions: [
              TextButton(onPressed: () => Get.back(result: false), child:
              const Text("Cancel",style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: "LatoRegular",
                color: AppColors.askBlue,
                // letterSpacing: .2,
              ))),
              TextButton(onPressed: () => Get.back(result: true), child:
              const Text("Exit",style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: "LatoRegular",
                color: AppColors.red,
                // letterSpacing: .2,
              ))),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
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
      ),
    );
  }
}

