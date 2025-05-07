
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../app/modules/home/controllers/home_controller.dart';
import '../../app/routes/app_pages.dart';
import '../app_color.dart';
import '../screen_size.dart';


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
              accountName: const Padding(
                padding: EdgeInsets.only(left: 0.0),
                child: Text('#', style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "LatoRegular"), ),
              ),
              accountEmail: const Text("email"),
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
              tileColor: Colors.white,
              // leading: Icon(Icons.add, color: Colors.black,),
              title: const Text('Home', style: TextStyle(color: Colors.black,fontFamily: "LatoRegular",),),
              onTap: () async {
                Navigator.of(context).pop();
                // controller.setSelectedCategory("men");
                // await controller.getCategoryProductsData(category: "men").then((value) {
                //   // Get.to(() => const ProductsView());
                // });
              },
            ),

            ListTile(
              tileColor: Colors.white,
              // leading: Icon(Icons.add, color: Colors.black,),
              title: const Text('Requests', style: TextStyle(color: Colors.black,fontFamily: "LatoRegular",),),
              onTap: () async {
                Navigator.of(context).pop();
                // controller.setSelectedCategory("women");
                // await controller.getCategoryProductsData(category: "women").then((value) {
                //   // Get.to(() => const ProductsView());
                // });
              },
            ),
            ListTile(
              tileColor: Colors.white,
              // leading: Icon(Icons.add, color: Colors.black,),
              title: const Text('Beneficiaries', style: TextStyle(color: Colors.black,fontFamily: "LatoRegular",),),
              onTap: () async {
                Navigator.of(context).pop();
                // controller.setSelectedCategory("essentials");
                // await controller.getCategoryProductsData(category: "essentials").then((value) {
                //   // Get.to(() => const ProductsView());
                // });
              },
            ),

            ListTile(
              tileColor: Colors.white,
              // leading: Icon(Icons.add, color: Colors.black,),
              title: const Text('Benefactors', style: TextStyle(color: Colors.black,fontFamily: "LatoRegular",),),
              onTap: () {
                Navigator.of(context).pop();
                // Get.toNamed(Routes.PRODUCTS);
              },
            ),

            ListTile(
              tileColor: Colors.white,
              // leading: Icon(Icons.add, color: Colors.black,),
              title: const Text('Contact', style: TextStyle(color: Colors.black,fontFamily: "LatoRegular",),),
              onTap: () {
                Navigator.of(context).pop();
                // Get.toNamed(Routes.PRODUCTS);
              },
            ),


            const Divider(),
            InkWell(
              onTap: () {
                SystemNavigator.pop();
              },
              child: const ListTile(
                tileColor: Colors.white,
                // leading: Icon(Icons.logout, color: AppColors.black,),
                title: Text('Exit', style: TextStyle(color: AppColors.black,fontFamily: "LatoRegular",),),
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