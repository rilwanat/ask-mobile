import 'package:ask_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/app_bar.dart';
import '../../../../global/widgets/app_bar_page.dart';
import '../../../../global/widgets/navbar.dart';
import '../../../../utils/utils.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../../global/widgets/BannerAdExample.dart';

class BeneficiariesView extends GetView<HomeController> {
  BeneficiariesView({super.key});

  final RxInt currentPage = 0.obs;
  final int itemsPerPage = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: controller.scaffoldKey,
      // backgroundColor: AppColors.askBackground,
      // drawer: NavBar(),
      // appBar: CustomAppBar(
      //   onMenuPressed: () {
      //     controller.scaffoldKey.currentState?.openDrawer();
      //   },
      //   onMorePressed: () {
      //     // controller.scaffoldKey.currentState?.openDrawer();
      //   },
      //   title: 'A.S.K - Beneficiaries',
      //   backgroundColor: AppColors.askBlue,
      // ),
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
          title: 'A.S.K - Beneficiaries',
          backgroundColor: AppColors.askBlue,
        ),
        body: Container(
          // color: AppColors.black,
          // width: ScreenSize.width(context),
          // height: ScreenSize.height(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    height: AdSize.banner.height.toDouble(), // 50.0 for standard banner
                    child: BannerAdExample(),
                  ),
                ),
                //

                // Grid of cards
                Expanded(
                  child: Obx(() {
                    final totalItems = controller.beneficiariesData.length;
                    final totalPages = (totalItems / itemsPerPage).ceil();

                    final start = currentPage.value * itemsPerPage;
                    final end = ((start + itemsPerPage) > controller.beneficiariesData.length)
                        ? controller.beneficiariesData.length
                        : start + itemsPerPage;

                    final currentItems = controller.beneficiariesData.sublist(start, end);

                    final pageController = PageController(initialPage: currentPage.value);

                    // Sync page controller with current page
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (pageController.hasClients && pageController.page?.round() != currentPage.value) {
                        pageController.animateToPage(
                          currentPage.value,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    });

                    return PageView.builder(controller: pageController,
                        onPageChanged: (page) {
                          currentPage.value = page;
                        },
                        itemCount: totalPages,
                        itemBuilder: (context, pageIndex) {
                          return GridView.builder(
                            padding: const EdgeInsets.only(top: 16),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              childAspectRatio: .64,
                            ),
                            itemCount: currentItems.length,
                            itemBuilder: (context, index) {

                              final data = currentItems[index];

                              return Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.white,
                                  border: Border.all(width: 1, color: AppColors.askGray),
                                  // boxShadow: shadowLight,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 1,
                                          child: Container(
                                            // height: double.infinity,
                                            // width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: AppColors.askBlue,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10), // Match container's border radius
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                "https://playground.askfoundations.org/backend/api/v1/" +
                                                    // "https://askfoundations.org/" + "" +
                                                    "${data?.user!.profilePicture}",
                                                fit: BoxFit.cover, // Changed from contain to cover
                                                width: double.infinity,
                                                height: double.infinity,
                                                placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 1)),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                                    // Text('Email: ${data?.emailAddress ?? ''}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    Text(data?.user?.fullname ?? '', style: const TextStyle(
                                      fontFamily: "LatoRegular",
                                      color: AppColors.black,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                    ), textAlign: TextAlign.center,),
                                    const SizedBox(height: 2,),
                                    Text(Utils.currencyFormat.format(double.parse((data?.amount ?? '').replaceAll(",", ""))), style: const TextStyle(
                                      // fontFamily: "LatoRegular",
                                      color: AppColors.askGreen,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                    ),),
                                    const SizedBox(height: 2,),
                                    Text(data?.date ?? '', style: const TextStyle(
                                      fontFamily: "LatoRegular",
                                      color: AppColors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                    ),),
                                    // Text('Status: ${data?.status ?? ''}'),
                                  ],
                                ),
                              );
                            },
                          );
                        });

                  }),
                ),

                // Pagination controls
                Obx(() {
                  final totalPages = (controller.beneficiariesData.length / itemsPerPage).ceil();

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Container(
                      color: AppColors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: currentPage.value > 0
                                  ? () => currentPage.value--
                                  : null,
                              child: Container(
                                  height: 48,
                                  width: 48,
                                  child: const Icon(Icons.arrow_back_ios, size: 14,))),

                          const SizedBox(width: 16,),
                          Text('${currentPage.value + 1} of $totalPages', style: const TextStyle(
                            fontFamily: "LatoRegular",
                            color: AppColors.askBlue,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          )),
                          const SizedBox(width: 16,),
                          GestureDetector(
                              onTap: (currentPage.value + 1) < totalPages
                                  ? () => currentPage.value++
                                  : null,
                              child: Container(
                                  height: 48,
                                  width: 48,
                                  child: const Icon(Icons.arrow_forward_ios, size: 14,))),

                        ],
                      ),
                    ),
                  );
                }),

                SizedBox(height: 20,)
              ],
            ),
          ),
        )
    );
  }
}
