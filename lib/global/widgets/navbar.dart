
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../app/modules/home/controllers/home_controller.dart';
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
                    Text(controller.profileData!.value!.fullname!, style: TextStyle(color: AppColors.white, fontSize: 14, fontFamily: "LatoRegular"), ),
                  ],
                ),
              ),
              accountEmail: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(controller.profileData!.value!.emailAddress!, style: TextStyle(color: AppColors.white, fontSize: 14, fontFamily: "LatoRegular"), ),
                        const SizedBox(width: 4,),
                        Icon(controller.profileData!.value!.emailVerified == "Yes" ? Icons.check_circle : Icons.warning_amber_rounded,
                          color: controller.profileData!.value!.emailVerified == "Yes" ? AppColors.askGreen : AppColors.red,
                          size: 18,)
                      ],
                    ),
                    SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("KYC Level 2: ", style: TextStyle(color: AppColors.white, fontSize: 14, fontFamily: "LatoRegular"), ),
                        const SizedBox(width: 4,),
                        Icon(controller.profileData!.value!.kycStatus == "APPROVED" ? Icons.check_circle : Icons.warning_amber_rounded,
                          color: controller.profileData!.value!.emailVerified == "Yes" ? AppColors.askGreen : AppColors.red,
                          size: 18,)
                      ],
                    ),
                  ],
                ),
              ),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                    width: 16,
                    height: 16,
                    child: Image.asset("assets/images/logo-start.png")),
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
              title: const Text('Home', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular",),),
              onTap: () async {
                Navigator.of(context).pop();
                // controller.setSelectedCategory("men");
                // await controller.getCategoryProductsData(category: "men").then((value) {
                //   // Get.to(() => const ProductsView());
                // });
              },
            ),

            ListTile(
              tileColor: AppColors.white,
              leading: const Icon(Icons.request_page, color: AppColors.askBlue,),
              title: const Text('Requests', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular",),),
              onTap: () async {
                Navigator.of(context).pop();
                // controller.setSelectedCategory("women");
                // await controller.getCategoryProductsData(category: "women").then((value) {
                //   // Get.to(() => const ProductsView());
                // });
              },
            ),

            ListTile(
              tileColor: AppColors.white,
              leading: const Icon(Icons.question_answer, color: AppColors.askBlue,),
              title: const Text('Ask', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular",),),
              onTap: () async {
                Navigator.of(context).pop();
                // controller.setSelectedCategory("women");
                // await controller.getCategoryProductsData(category: "women").then((value) {
                //   // Get.to(() => const ProductsView());
                // });
              },
            ),

            ListTile(
              tileColor: AppColors.white,
              leading: const Icon(Icons.add_task, color: AppColors.askBlue,),
              title: const Text('Beneficiaries', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular",),),
              onTap: () async {
                Navigator.of(context).pop();
                // controller.setSelectedCategory("essentials");
                // await controller.getCategoryProductsData(category: "essentials").then((value) {
                //   // Get.to(() => const ProductsView());
                // });
              },
            ),

            ListTile(
              tileColor: AppColors.white,
              leading: const Icon(Icons.person, color: AppColors.askBlue,),
              title: const Text('Benefactors', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular",),),
              onTap: () {
                Navigator.of(context).pop();
                // Get.toNamed(Routes.PRODUCTS);
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
            InkWell(
              onTap: () {
                controller.logoutUser();
                // SystemNavigator.pop();
              },
              child: const ListTile(
                tileColor: AppColors.white,
                leading: Icon(Icons.logout, color: AppColors.askBlue,),
                title: Text('Log out', style: TextStyle(color: AppColors.red, fontFamily: "LatoRegular",),),
              ),
            ),

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