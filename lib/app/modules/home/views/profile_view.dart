import 'package:ask_mobile/global/screen_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/widgets/LoadingScreen.dart';
import '../../../../global/widgets/app_bar_page.dart';
import '../../../../global/widgets/app_bar.dart';
import '../../../../global/widgets/navbar.dart';
import '../../../../utils/utils.dart';
import '../controllers/home_controller.dart';

class ProfileView extends GetView<HomeController> {
  ProfileView({super.key});

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
        title: 'A.S.K - Profile',
        backgroundColor: AppColors.askBlue,
      ),
      body: Container(
        height: ScreenSize.height(context),
        width: ScreenSize.width(context),
        child: Obx(() => controller.isLoading
            ? const LoadingScreen()
            : Container(
          // color: AppColors.askBlue,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(bottom: 20),
              child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
              if (controller.profileData.value!.profilePicture != null && controller.profileData.value!.profilePicture!.isNotEmpty)
                Row(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: ScreenSize.width(context) * 0.3,
                          width: ScreenSize.width(context) * 0.3,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              // height: ScreenSize.width(context) * 0.5,
                              // width: ScreenSize.width(context) * 0.5,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                // color: AppColors.askBlue,
                                border: Border.all(color: AppColors.askBlue, width: 2),
                                borderRadius: BorderRadius.circular(300),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(300), // Match container's border radius
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
                      ],
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,//paceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    controller.getUserProfile();
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.askBlue,
                                        border: Border.all(color: AppColors.askBlue, width: 2),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      child: const Text("Refresh", style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "LatoRegular",
                                        color: AppColors.white,)))),

                              // GestureDetector(
                              //     onTap: () {
                              //       // Navigator.of(context).pop();
                              //       controller.logoutUser();
                              //     },
                              //     child: Container(
                              //         decoration: BoxDecoration(
                              //           color: AppColors.red,
                              //           border: Border.all(color: AppColors.red, width: 2),
                              //           borderRadius: BorderRadius.circular(30),
                              //         ),
                              //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              //         child: const Text("Log out", style: TextStyle(
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.w500,
                              //           fontFamily: "LatoRegular",
                              //           color: AppColors.black,)))),
                            ],
                          ),
                      
                          const SizedBox(height: 8,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Utils.capitalizeEachWord(controller.profileData.value!.fullname!), style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "LatoRegular",
                                color: AppColors.askText,
                              ),),
                              Text("Gender: " + controller.profileData.value!.gender!, style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "LatoRegular",
                                color: AppColors.askText,
                              )),
                              Text("Account Age: " + Utils.timeElapsedSince(DateTime.parse(controller.profileData.value!.registrationDate!)), style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "LatoRegular",
                                color: AppColors.askText,
                              )),
                              // Text("KYC 1: " + controller.profileData.value!.gender!, style: const TextStyle(
                              //   fontSize: 14,
                              //   fontWeight: FontWeight.w400,
                              //   fontFamily: "LatoRegular",
                              //   color: AppColors.askText,
                              // ))
                      
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              const SizedBox(height: 16),
              // infoTile('Full Name:', Utils.capitalizeEachWord(controller.profileData.value!.fullname!)),
              infoTile('Email Address: ', controller.profileData.value?.emailAddress ?? 'N/A'),
              infoTile('Phone Number: ', controller.profileData.value?.phoneNumber ?? 'N/A'),
              // infoTile('Gender:', controller.profileData.value!.gender!),
              infoTile('State of Residence: ', controller.profileData.value?.stateOfResidence ?? 'N/A'),
              infoTile('Level 1 Verification (Email): ', controller.profileData.value?.emailVerified ?? 'N/A'),
              infoTile('Level 2 Verification (KYC): ', controller.profileData.value?.kycStatus ?? 'N/A'),
              // infoTile('Voter Consistency', controller.profileData.value!.voterConsistency.toString()),
              // infoTile('DNQ: ', controller.profileData.value?.voteWeight.toString() ?? 'N/A'),

              // infoTile('Account Name', controller.profileData.value!.accountName!),
              // infoTile('Account Number:', controller.profileData.value!.accountNumber!),
              // infoTile('Bank Name:', controller.profileData.value!.bankName!),

              // infoTile('Eligibility:', controller.profileData.value?.eligibility ?? 'N/A'),
              // infoTile('Is Cheat', controller.profileData.value!.isCheat!),

              // infoTile('Account Age:', controller.profileData.value!.registrationDate!),

                          infoTile('Consistency: ', Utils.formatVoterConsistencyDays(controller.profileData.value?.voterConsistency ?? 'N/A')),
                        ],
                      ),
            ),),
      ),
    );
  }

  Widget infoTile(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(title, style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: "LatoRegular",
          color: AppColors.askText,
        ),),
        subtitle: Text(value, style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: "LatoRegular",
          color: AppColors.askText,
        ),),
      ),
    );
  }
}
