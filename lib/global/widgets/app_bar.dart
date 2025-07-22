import 'package:ask_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:ask_mobile/app/modules/home/views/faq_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../app/modules/home/views/notifications_view.dart';
import '../../utils/utils.dart';
import '../app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onMorePressed;
  final String title;
  final String logoPath;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final double logoSize;
  final double titleFontSize;

  // Declare the controller
  final HomeController homeCtrl = Get.find<HomeController>();

  CustomAppBar({
    super.key,
    this.scaffoldKey,
    this.onMenuPressed,
    this.onMorePressed,
    this.title = 'A.S.K',
    this.logoPath = "assets/images/logo-start.png",
    this.backgroundColor = AppColors.askBlue,
    this.iconColor = AppColors.white,
    this.textColor = AppColors.white,
    this.logoSize = 32,
    this.titleFontSize = 20,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onMenuPressed,
                // child: Image.asset(
                //   logoPath,
                //   width: logoSize,
                //   height: logoSize,
                // ),
                child: const SizedBox(
                  width: 32,  // Larger tap area
                  height: 48,
                  child: Icon(Icons.menu,
                    size: 26,//logoSize,
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w600,
                  fontFamily: "LatoRegular",
                  color: textColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 20,
                width: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Future(() async {
                          String helpToken = homeCtrl.myHelpRequestsData.value?.helpToken ?? '';

                          if (helpToken.isNotEmpty) {

                            await homeCtrl.handleTheHelptokenNavigation(helpToken: helpToken, goBack: false);

                          } else {
                            // Utils.showTopSnackBar(
                            //   t: "My Request",
                            //   m: "You don't have an active help request. Please create one.",
                            //   tc: AppColors.white,
                            //   d: 3,
                            //   bc: AppColors.askBlue,
                            //   sp: SnackPosition.TOP,
                            // );
                            Utils.showInformationDialog(status: null,
                                title: "My Request",
                                message: "You don't have an active help request. Please create one."
                            );
                          }
                        });
                      },
                      child: Icon(
                        // Icons.more_vert_rounded,
                        Icons.request_page,
                        color: iconColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10,),

              GestureDetector(
                onTap: () async {
                  // homeCtrl.initializeProfileData();
                  Get.to(() => const NotificationsView());
                  homeCtrl.markNotificationsAsSeen();
                },
                child: Obx(() => Stack(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              // Icons.more_vert_rounded,
                              // Icons.refresh,
                              Icons.notifications,
                              color: iconColor,
                            ),
                          ],
                        ),
                      ),
                      homeCtrl.hasNewNotification ?
                      Positioned(top: 0, right: 4, child: Container(width: 8, height: 8, color: AppColors.red))
                          : Container()
                    ]
                ),)
              ),

              const SizedBox(width: 10,),

              SizedBox(
                height: 20,
                width: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const FaqView());
                      },
                      child: Icon(
                        // Icons.more_vert_rounded,
                        Icons.help,
                        color: iconColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}