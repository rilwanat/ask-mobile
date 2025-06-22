import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../global/app_color.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/BannerAdExample.dart';
import '../../../../global/widgets/loading_screen.dart';
import '../../../../global/widgets/app_bar.dart';
import '../../../../global/widgets/app_bar_page.dart';
import '../../../../global/widgets/ask_button.dart';
import '../../../../global/widgets/fade_down_animation.dart';
import '../../../../global/widgets/navbar.dart';
import '../../../../utils/utils.dart';
import '../../../data/models/banks/Data.dart';
import '../controllers/home_controller.dart';
import 'beneficiaries_view.dart';

import '../../../data/models/requests/Data.dart' as hrd;
import '../../../data/models/beneficiaries/Data.dart' as bd;

class NotificationsView extends GetView<HomeController> {
  const NotificationsView({super.key});
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
        title: 'A.S.K - Notifications',
        backgroundColor: AppColors.askBlue,
      ),
      body:

      // const Center(
      //   child: Text(
      //     'NotificationsView is working',
      //     style: TextStyle(fontSize: 20),
      //   ),
      // ),

      Container(
        height: ScreenSize.height(context),
        width: ScreenSize.width(context),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),
          child: Stack(
            children: [
              Positioned(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ScreenSize.scaleHeight(context, 70),),
                      // const FlashAppBar(
                      //   title: "Notifications",
                      //   showBackArrow: true,
                      //   textColor: AppColors.white,
                      // ),






                      const SizedBox(height: 20),
                      Flexible(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              // color: AppColors.background,
                              child: Obx(() =>

                              controller.notificationMessages.isNotEmpty ?

                                  ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true, // Prevents unnecessary scrolling inside Expanded
                                  physics: BouncingScrollPhysics(), // Optional for smooth scrolling
                                  itemCount: controller.notificationMessages.length,
                                  itemBuilder: (context, index) {

                                    final askNotification = controller.notificationMessages[index];

                                    return GestureDetector(
                                      onTap: () async {
                                        // print(askNotification);
                                        // return;

                                        Get.back();
                                        // controller.handleNavigation(1);

                                        // final data = jsonDecode(response.payload!);
                                        final meta = askNotification['meta'] ?? '';

                                        // print("Notification clicked: ${response.payload}");
                                        print("Notification clicked: ${meta}");

                                        if (meta != '') {
                                          controller.handleNavigation(1);
                                          await Get.find<HomeController>().scrollToNewRequest(int.parse(meta!));

                                        }
                                      },
                                      child: Dismissible(
                                        key: Key(askNotification['id'].toString()), // Unique key for each item
                                        direction: DismissDirection.endToStart, // Only allow swipe left to right
                                        confirmDismiss: (direction) async {
                                          // Show confirmation dialog
                                          return await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return
                                                AlertDialog(
                                                  backgroundColor: AppColors.askBackground,
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                                  shape: RoundedRectangleBorder(  // This is what you're missing
                                                    borderRadius: BorderRadius.circular(16.0),  // Adjust radius as needed
                                                    side: BorderSide(
                                                      color: AppColors.white.withOpacity(0.2),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  elevation: 8,
                                                  content: Container(
                                                    height: ScreenSize.height(context) * 0.6,
                                                    width: double.maxFinite,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(height: 20),
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),
                                                          child: Text(
                                                            "Confirm Delete",
                                                            style: const TextStyle(
                                                              fontSize: 26,
                                                              fontWeight: FontWeight.w500,
                                                              color: AppColors.askText,
                                                              fontFamily: "LatoRegular",
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 20),
                                                        Center(
                                                          child: FadeDownAnimation(
                                                              delayMilliSeconds: 400,
                                                              duration: 700,
                                                              child:
                                                              const Icon(Icons.info, size: 70, color: AppColors.askBlue)
                                                          ),
                                                        ),
                                                        const SizedBox(height: 20),
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(
                                                            horizontal: ScreenSize.scaleWidth(context, 24),
                                                          ),
                                                          child: FadeDownAnimation(
                                                            delayMilliSeconds: 400,
                                                            duration: 700,
                                                            child: Container(
                                                              margin: const EdgeInsets.only(bottom: 12),
                                                              child: Text(
                                                                "Are you sure you want to delete this notification?",
                                                                style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: AppColors.askText,
                                                                  fontFamily: "LatoRegular",
                                                                ),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                          ),),
                                                        const Spacer(),
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Expanded(
                                                                child: AskButton(
                                                                  enabled: true,
                                                                  text: "Cancel",
                                                                  function: () async {
                                                                    Navigator.pop(context);

                                                                  },
                                                                  backgroundColor: AppColors.askBlue,
                                                                  textColor: AppColors.white,
                                                                  buttonWidth: ScreenSize.width(context) * .4,
                                                                  buttonHeight: ScreenSize.scaleHeight(context, 54),
                                                                  borderCurve: 26,
                                                                  border: false,
                                                                  textSize: 14,
                                                                ),
                                                              ),

                                                              const SizedBox(width: 10),
                                                              Expanded(child: AskButton(
                                                                enabled: true,
                                                                text: "Delete",
                                                                function: () async {

                                                                  final documentId = "adm-${controller.profileData.value!.emailAddress!}";
                                                                  await controller.deleteNotification(documentId, askNotification);
                                                                  Navigator.pop(context);


                                                                },
                                                                backgroundColor: AppColors.red,
                                                                textColor: AppColors.white,
                                                                buttonWidth: ScreenSize.width(context) * .4,
                                                                buttonHeight: ScreenSize.scaleHeight(context, 54),
                                                                borderCurve: 26,
                                                                border: false,
                                                                textSize: 14,
                                                              )),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(height: 30),
                                                      ],
                                                    ),
                                                  ),
                                                  // actions: <Widget>[
                                                  //   TextButton(
                                                  //     onPressed: () => Navigator.of(context).pop(false),
                                                  //     child: Text("CANCEL"),
                                                  //   ),
                                                  //   TextButton(
                                                  //     onPressed: () => Navigator.of(context).pop(true),
                                                  //     child: Text("DELETE", style: TextStyle(color: Colors.red)),
                                                  //   ),
                                                  // ],
                                                );

                                              //   AlertDialog(
                                              //   title: Text("Confirm Delete"),
                                              //   content: Text("Are you sure you want to delete this notification?"),
                                              //   actions: <Widget>[
                                              //     TextButton(
                                              //       onPressed: () => Navigator.of(context).pop(false),
                                              //       child: Text("CANCEL"),
                                              //     ),
                                              //     TextButton(
                                              //       onPressed: () => Navigator.of(context).pop(true),
                                              //       child: Text("DELETE", style: TextStyle(color: Colors.red)),
                                              //     ),
                                              //   ],
                                              // );
                                            },
                                          );
                                        },
                                        onDismissed: (direction) {
                                          // Remove the item from the list
                                          // controller.deleteNotification(index);
                                        },
                                        child: Container(
                                          height: ScreenSize.scaleHeight(context, 80),
                                          margin: const EdgeInsets.only(bottom: 10),
                                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                          decoration: BoxDecoration(
                                            color: AppColors.askBlue,
                                            borderRadius: BorderRadius.circular(16),
                                            // border: Border.all(color: AppColors.gold),
                                            // boxShadow: shadowDefault,
                                          ),
                                          child: Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Container(
                                                width: ScreenSize.scaleHeight(context, 8),
                                                height: ScreenSize.scaleHeight(context, 8),
                                                // padding: const EdgeInsets.all( 2),
                                                // margin: const EdgeInsets.all( 8),
                                                decoration: BoxDecoration(
                                                  // border: Border.all(color: AppColors.eDoctorInputBorder),
                                                  color: AppColors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(ScreenSize.scaleHeight(context, 50)),
                                                  //boxShadow: buttonShadow
                                                ),
                                                child: Visibility(
                                                  visible: false,
                                                  child: Image.asset(
                                                    "assets/images/icons/forward.png",
                                                    //fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      askNotification['message'],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: "LatoRegular",
                                                        // letterSpacing: .2,
                                                        color: AppColors.white,
                                                      ),
                                                    ),
                                                    // SizedBox(height: 4),
                                                    // Text(
                                                    //   "Pay 100 to get ",
                                                    //   style: TextStyle(
                                                    //     fontSize: 12,
                                                    //     fontWeight: FontWeight.w400,
                                                    //     fontFamily: "LatoRegular",
                                                    //     letterSpacing: .2,
                                                    //     color: AppColors.white,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    Utils.formatFirestoreDate(askNotification['timestamp']),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "LatoRegular",
                                                      // letterSpacing: .2,
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                  // SizedBox(height: 4),
                                                  // Icon(
                                                  //     Icons.arrow_forward_ios, color: AppColors.white, size: 16
                                                  // ),
                                                  Text(
                                                    Utils.formatFirestoreTime(askNotification['timestamp']),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "LatoRegular",
                                                      // letterSpacing: .2,
                                                      color: AppColors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  })

                                  :

                                  const Center(child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,//center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'No notifications',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "LatoRegular",
                                          // letterSpacing: .2,
                                          color: AppColors.askBlue,
                                        ),
                                      ),
                                      // SizedBox(height: 4),
                                      // Text(
                                      //   "Pay 100 to get ",
                                      //   style: TextStyle(
                                      //     fontSize: 12,
                                      //     fontWeight: FontWeight.w400,
                                      //     fontFamily: "LatoRegular",
                                      //     letterSpacing: .2,
                                      //     color: AppColors.white,
                                      //   ),
                                      // ),
                                    ],
                                  ))
                              ),
                            ),
                          )

                      ),


                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),


    );
  }
}
