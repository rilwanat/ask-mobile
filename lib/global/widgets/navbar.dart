
import 'package:ask_mobile/app/modules/home/views/benefactors_view.dart';
import 'package:ask_mobile/app/modules/home/views/donations_view.dart';
import 'package:ask_mobile/app/modules/home/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../app/modules/home/controllers/home_controller.dart';
import '../../utils/utils.dart';
import '../app_color.dart';

class NavBar extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
            currentAccountPictureSize: const Size(64, 64),
              accountName: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(Utils.capitalizeEachWord(controller.profileData.value!.fullname!), style: TextStyle(color: AppColors.white, fontSize: 12, fontFamily: "LatoRegular"), ),
                  ],
                ),
              ),
              accountEmail: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Obx(() => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(controller.profileData.value!.emailAddress!, style: TextStyle(color: AppColors.white, fontSize: 12, fontFamily: "LatoRegular"), ),
                        const SizedBox(width: 4,),
                        Icon(controller.profileData.value!.emailVerified == "Yes" ? Icons.check_circle : Icons.warning_amber_rounded,
                          color: controller.profileData.value!.emailVerified == "Yes" ? AppColors.askGreen : AppColors.red,
                          size: 18,)
                      ],
                    ),
                    SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Level 2 Verification (KYC): ", style: TextStyle(color: AppColors.white, fontSize: 12, fontFamily: "LatoRegular"), ),
                        const SizedBox(width: 4,),
                        Icon(controller.profileData.value!.kycStatus == "APPROVED" ? Icons.check_circle : Icons.warning_amber_rounded,
                          color: controller.profileData.value!.kycStatus == "APPROVED" ? AppColors.askGreen : AppColors.red,
                          size: 18,)
                      ],
                    ),
                  ],
                )),
              ),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                      width: 16,
                      height: 16,
                      child: Image.asset("assets/images/logo-start.png")),
                ),
              ),
              decoration: const BoxDecoration(
                color: AppColors.askBlue,
              ),
            ),
            // Container(
            //     margin: EdgeInsets.symmetric(horizontal: 20),
            //     child: Image(image: AssetImage("image/decoration/d0.png"),)
            // ),
            const SizedBox(height: 4,),
            ListTile(
              tileColor: AppColors.white,
              leading: const Icon(Icons.home, color: AppColors.askBlue,),
              title: const Text('Home', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular", fontSize: 12),),
              onTap: () async {
                Navigator.of(context).pop();
                // controller.setSelectedCategory("men");
                // await controller.getCategoryProductsData(category: "men").then((value) {
                //   // Get.to(() => const ProductsView());
                // });
                controller.handleNavigation(0);
              },
            ),

            ListTile(
              tileColor: AppColors.white,
              leading: const Icon(Icons.person, color: AppColors.askBlue,),
              title: const Text('Profile', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular", fontSize: 12),),
              onTap: () async {
                Navigator.of(context).pop();
                // controller.setSelectedCategory("women");
                // await controller.getCategoryProductsData(category: "women").then((value) {
                //   //
                // });
                // controller.handleNavigation(1);

                Get.to(() => ProfileView());
              },
            ),

            ListTile(
              tileColor: AppColors.white,
              leading: const Icon(Icons.star, color: AppColors.askBlue,),
              title: const Text('Benefactors', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular", fontSize: 12),),
              onTap: () {
                Navigator.of(context).pop();
                // Get.toNamed(Routes.PRODUCTS);

                Get.to(() => BenefactorsView());
              },
            ),

            ListTile(
              tileColor: AppColors.white,
              leading: const Icon(Icons.waving_hand, color: AppColors.askBlue,),
              title: const Text('Donations', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular", fontSize: 12),),
              onTap: () async {
                Navigator.of(context).pop();
                // controller.setSelectedCategory("essentials");
                // await controller.getCategoryProductsData(category: "essentials").then((value) {
                //   // Get.to(() => const ProductsView());
                // });

                Get.to(() => const DonationsView());
              },
            ),

            // ListTile(
            //   tileColor: Colors.white,
            //   leading: const Icon(Icons.help, color: Colors.black,),
            //   title: const Text('Contact', style: TextStyle(color: Colors.black,fontFamily: "LatoRegular",),),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     // Get.toNamed(Routes.PRODUCTS);
            //   },
            // ),


            const Divider(),
            // InkWell(
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     controller.logoutUser();
            //     // SystemNavigator.pop();
            //   },
            //   child: const ListTile(
            //     tileColor: AppColors.white,
            //     leading: Icon(Icons.logout, color: AppColors.askBlue,),
            //     title: Text('Log out', style: TextStyle(color: AppColors.red, fontFamily: "LatoRegular",),),
            //   ),
            // ),

            /*Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text("rb-apps",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    fontWeight: FontWeight.w100
                  ),
                )
            ),*/
          ],
        ),
      ),
    );
  }
}