
import 'package:ask_mobile/app/modules/home/views/benefactors_view.dart';
import 'package:ask_mobile/app/modules/home/views/donations_view.dart';
import 'package:ask_mobile/app/modules/home/views/profile_view.dart';
import 'package:ask_mobile/app/modules/home/views/requests_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../app/modules/home/controllers/home_controller.dart';
import '../../app/modules/home/views/beneficiaries_view.dart';
import '../../app/modules/home/views/iask_view.dart';
import '../../utils/utils.dart';
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
            Container(
              decoration: BoxDecoration(
                color: AppColors.askBlue,
              ),
              height: 220,
              child: UserAccountsDrawerHeader(
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
                accountEmail: SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Obx(() => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (controller.profileData.value!.emailVerified != "Yes") {
                              Navigator.of(context).pop();
                              // Get.to(() => IaskView());
                              controller.handleNavigation(2);
                            } else {
                              Utils.showTopSnackBar(
                                  t: "KYC",
                                  m: "Level 1 Email Verification Okay",
                                  tc: AppColors.white,
                                  d: 3,
                                  bc: AppColors.askBlue,
                                  sp: SnackPosition.TOP);
                            }
                          },
                          child: Row(
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
                        ),
                        SizedBox(height: 4,),
                        GestureDetector(
                          onTap: () {
                            if (controller.profileData.value!.kycStatus != "APPROVED") {
                              Navigator.of(context).pop();
                              // Get.to(() => IaskView());
                              controller.handleNavigation(2);
                            } else {
                              Utils.showTopSnackBar(
                                  t: "KYC",
                                  m: "Level 2 Verification (KYC) Okay !",
                                  tc: AppColors.white,
                                  d: 3,
                                  bc: AppColors.askBlue,
                                  sp: SnackPosition.TOP);
                            }
                          },
                          child: Row(
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
                        ),
                        // SizedBox(height: 4,),

                      ],
                    )),
                  ),
                ),
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.to(() => ProfileView());
                  },
                  child:
                  SizedBox(
                    height: ScreenSize.width(context) * 0.3,
                    width: ScreenSize.width(context) * 0.3,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        // height: ScreenSize.width(context) * 0.5,
                        // width: ScreenSize.width(context) * 0.5,
                        // padding: EdgeInsets.all(4),
                        // margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          // color: AppColors.askBlue,
                          border: Border.all(color: AppColors.white, width: 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30), // Match container's border radius
                          child: CachedNetworkImage(
                            imageUrl:
                            "https://playground.askfoundations.org/" +
                                // "https://askfoundations.org/" +
                                "${controller.profileData.value!.profilePicture!}",
                            fit: BoxFit.cover, // Changed from contain to cover
                            width: ScreenSize.width(context) * 0.2,
                            height: ScreenSize.width(context) * 0.2,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 1)),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  )

                  // Container(
                  //   padding: const EdgeInsets.all(8),
                  //   child: SizedBox(
                  //       width: 16,
                  //       height: 16,
                  //       child: Image.asset("assets/images/logo-start.png")),
                  // ),
                ),
                decoration: const BoxDecoration(
                  color: AppColors.askBlue,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -6),  // Negative vertical offset
              child: Container(
              decoration: const BoxDecoration(
                color: AppColors.askOrange,//askBlue,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Utils.showInformationDialog(status: true, title: 'A.S.K DNQ', message: "You can increase your influence in deciding beneficiary by boosting your daily nomination quota through becoming a donor.");

                            },
                            child: Text("DNQ: ${controller.profileData.value?.voteWeight}" ?? 'N/A', style: TextStyle(color: AppColors.white, fontSize: 12, fontFamily: "LatoRegular"), )),
                        Text("Consistency: ${Utils.formatVoterConsistencyDays(controller.profileData.value?.voterConsistency)}" ?? 'N/A', style: TextStyle(color: AppColors.white, fontSize: 12, fontFamily: "LatoRegular"), ),
                      ],
                    ),
                    const SizedBox(height: 6,),
                  ],
                ),
              ),
            ),),

            const SizedBox(height: 4,),
            Expanded(
              // height: ScreenSize.height(context) * .7,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      tileColor: AppColors.white,
                      leading: const Icon(Icons.home, size: 28, color: AppColors.askBlue,),
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
                      leading: const Icon(Icons.person, size: 28, color: AppColors.askBlue,),
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
                      leading: const Icon(Icons.request_page, size: 28, color: AppColors.askBlue,),
                      title: const Text('Request', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular", fontSize: 12),),
                      onTap: () async {
                        Navigator.of(context).pop();
                        // controller.setSelectedCategory("women");
                        // await controller.getCategoryProductsData(category: "women").then((value) {
                        //   //
                        // });
                        controller.handleNavigation(1);

                        // Get.to(() => RequestsView());
                      },
                    ),

                    ListTile(
                      tileColor: AppColors.white,
                      leading: const Icon(Icons.question_answer, size: 28, color: AppColors.askBlue,),
                      title: const Text('iAsk', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular", fontSize: 12),),
                      onTap: () async {
                        Navigator.of(context).pop();
                        // controller.setSelectedCategory("women");
                        // await controller.getCategoryProductsData(category: "women").then((value) {
                        //   //
                        // });
                        await controller.getCheckIfUserCanAsk(email: controller.profileData.value!.emailAddress!);

                        controller.handleNavigation(2);

                        // Get.to(() => IaskView());
                      },
                    ),

                    ListTile(
                      tileColor: AppColors.white,
                      leading: const Icon(Icons.star, size: 28, color: AppColors.askBlue,),
                      title: const Text('Benefactors', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular", fontSize: 12),),
                      onTap: () {
                        Navigator.of(context).pop();
                        // Get.toNamed(Routes.PRODUCTS);

                        Get.to(() => BenefactorsView());
                      },
                    ),

                    ListTile(
                      tileColor: AppColors.white,
                      leading: const Icon(Icons.waving_hand, size: 28, color: AppColors.askBlue,),
                      title: const Text('Donations', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular", fontSize: 12),),
                      onTap: () async {
                        Navigator.of(context).pop();
                        // controller.setSelectedCategory("essentials");
                        // await controller.getCategoryProductsData(category: "essentials").then((value) {
                        //   // Get.to(() => const ProductsView());
                        // });

                        // Get.to(() => const DonationsView());



                        controller.handleNavigation(3);
                      },
                    ),

                    ListTile(
                      tileColor: AppColors.white,
                      leading: const Icon(Icons.monetization_on, size: 28, color: AppColors.askBlue,),
                      title: const Text('Beneficiaries', style: TextStyle(color: AppColors.askBlue, fontFamily: "LatoRegular", fontSize: 12),),
                      onTap: () async {
                        Navigator.of(context).pop();
                        // controller.setSelectedCategory("essentials");
                        // await controller.getCategoryProductsData(category: "essentials").then((value) {
                        //   // Get.to(() => const ProductsView());
                        // });

                        Get.to(() => BeneficiariesView());

                        // controller.handleNavigation(3);
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
                        Navigator.of(context).pop();
                        controller.logoutUser();
                        // SystemNavigator.pop();
                      },
                      child: const ListTile(
                        tileColor: AppColors.white,
                        leading: Icon(Icons.logout, size: 28, color: AppColors.askBlue,),
                        title: Text('Log out', style: TextStyle(color: AppColors.red, fontFamily: "LatoRegular", fontSize: 12),),
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
              )
            )


          ],
        ),
      ),
    );
  }
}