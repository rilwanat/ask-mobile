import 'package:ask_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:ask_mobile/app/modules/home/views/faq_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../app/modules/home/views/notifications_view.dart';
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
                child: Icon(Icons.menu,
                  size: 26,//logoSize,
                  color: AppColors.white,
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
                      onTap: () async {
                        // homeCtrl.initializeProfileData();
                        Get.to(() => const NotificationsView());
                      },
                      child: Icon(
                        // Icons.more_vert_rounded,
                        // Icons.refresh,
                        Icons.notifications,
                        color: iconColor,
                      ),
                    ),
                  ],
                ),
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