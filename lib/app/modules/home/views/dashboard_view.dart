import 'package:ask_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:ask_mobile/app/modules/home/views/beneficiaries_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../global/app_color.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/LoadingScreen.dart';
import '../../../../global/widgets/app_bar.dart';
import '../../../../global/widgets/ask_button.dart';
import '../../../../global/widgets/navbar.dart';
import '../../../../utils/utils.dart';

import '../../../data/models/requests/Data.dart' as hrd;
import '../../../data/models/beneficiaries/Data.dart' as bd;

class DashboardView extends GetView<HomeController> {
  DashboardView({super.key});

  final NumberFormat currencyFormat = NumberFormat.currency(locale: 'en_US', symbol: '₦', decimalDigits: 0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: AppColors.askBackground,
      drawer: NavBar(),
      appBar: CustomAppBar(
        onMenuPressed: () {
          controller.scaffoldKey.currentState?.openDrawer();
        },
        onMorePressed: () {
          // controller.scaffoldKey.currentState?.openDrawer();
        },
        title: 'A.S.K - Home',
        backgroundColor: AppColors.askBlue,
      ),
      body: Container(
          height: ScreenSize.height(context),
          width: ScreenSize.width(context),
          child: Obx(() => controller.isLoading
              ? const LoadingScreen() : SingleChildScrollView(
              child: Column(
                children: [

                  //
                  CarouselSlider(
                    items: [
                      Stack(
                        children: [
                          Container(
                            color: AppColors.black,
                            width: ScreenSize.width(context),
                            height: ScreenSize.width(context) * .5,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Image.network(
                                'https://playground.askfoundations.org/images/slider-images/slide1.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          // Container(
                          //   //color: AppColors.red,
                          //   decoration: const BoxDecoration(
                          //     //boxShadow: shadowListSmall,
                          //       color: AppColors.askGray,
                          //       //border: Border.all(width: 1, color: AppColors.grey),
                          //       borderRadius: BorderRadius.only(
                          //           topRight: Radius.circular(20),
                          //           bottomRight: Radius.circular(20))),
                          //   width: ScreenSize.width(context) * .5,
                          //   height: ScreenSize.width(context) * .5,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(left: 20.0),
                          //     // child: Column(
                          //     //   mainAxisAlignment: MainAxisAlignment.center,
                          //     //   crossAxisAlignment: CrossAxisAlignment.start,
                          //     //   children: [
                          //     //     const Text("#",
                          //     //         style: TextStyle(
                          //     //             fontFamily: "LatoRegular",
                          //     //             fontSize: 18,
                          //     //             fontWeight: FontWeight.w900,
                          //     //             color: AppColors.white)),
                          //     //     const SizedBox(
                          //     //       height: 8,
                          //     //     ),
                          //     //     const Text(
                          //     //         "#",
                          //     //         style: TextStyle(
                          //     //             fontFamily: "LatoRegular",
                          //     //             fontSize: 12,
                          //     //             fontWeight: FontWeight.w500,
                          //     //             color: AppColors.white)),
                          //     //     const SizedBox(
                          //     //       height: 16,
                          //     //     ),
                          //     //     GestureDetector(
                          //     //       onTap: () {
                          //     //         Utils.showTopSnackBar(
                          //     //           t: "A.S.K",
                          //     //           m: "A.S.K",
                          //     //           tc: AppColors.black,
                          //     //           d: 3,
                          //     //           bc: AppColors.askBlue,
                          //     //           sp: SnackPosition.BOTTOM,
                          //     //         );
                          //     //       },
                          //     //       child: Container(
                          //     //           padding: const EdgeInsets.symmetric(
                          //     //               horizontal: 20, vertical: 10),
                          //     //           decoration: const BoxDecoration(
                          //     //             //boxShadow: shadowListSmall,
                          //     //               color: AppColors.askGray,
                          //     //               //border: Border.all(width: 1, color: AppColors.grey),
                          //     //               borderRadius: BorderRadius.all(
                          //     //                 Radius.circular(30),
                          //     //               )),
                          //     //           child: const Text(
                          //     //             "Sample",
                          //     //             style: TextStyle(
                          //     //                 fontFamily: "LatoRegular",
                          //     //                 fontSize: 12,
                          //     //                 fontWeight: FontWeight.w500,
                          //     //                 color: AppColors.white),
                          //     //           )),
                          //     //     ),
                          //     //   ],
                          //     // ),
                          //   ),
                          // ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            color: AppColors.black,
                            width: ScreenSize.width(context),
                            height: ScreenSize.width(context) * .5,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Image.network(
                                'https://playground.askfoundations.org/images/slider-images/slide2.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          // Container(
                          //   //color: AppColors.red,
                          //   decoration: const BoxDecoration(
                          //     //boxShadow: shadowListSmall,
                          //       color: AppColors.askGray,
                          //       //border: Border.all(width: 1, color: AppColors.grey),
                          //       borderRadius: BorderRadius.only(
                          //           topRight: Radius.circular(20),
                          //           bottomRight: Radius.circular(20))),
                          //   width: ScreenSize.width(context) * .5,
                          //   height: ScreenSize.width(context) * .5,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(left: 20.0),
                          //     // child: Column(
                          //     //   mainAxisAlignment: MainAxisAlignment.center,
                          //     //   crossAxisAlignment: CrossAxisAlignment.start,
                          //     //   children: [
                          //     //     const Text("#",
                          //     //         style: TextStyle(
                          //     //             fontFamily: "LatoRegular",
                          //     //             fontSize: 18,
                          //     //             fontWeight: FontWeight.w900,
                          //     //             color: AppColors.white)),
                          //     //     const SizedBox(
                          //     //       height: 8,
                          //     //     ),
                          //     //     const Text(
                          //     //         "#",
                          //     //         style: TextStyle(
                          //     //             fontFamily: "LatoRegular",
                          //     //             fontSize: 12,
                          //     //             fontWeight: FontWeight.w500,
                          //     //             color: AppColors.white)),
                          //     //     const SizedBox(
                          //     //       height: 16,
                          //     //     ),
                          //     //     GestureDetector(
                          //     //       onTap: () {
                          //     //         Utils.showTopSnackBar(
                          //     //           t: "A.S.K",
                          //     //           m: "A.S.K",
                          //     //           tc: AppColors.black,
                          //     //           d: 3,
                          //     //           bc: AppColors.askBlue,
                          //     //           sp: SnackPosition.BOTTOM,
                          //     //         );
                          //     //       },
                          //     //       child: Container(
                          //     //           padding: const EdgeInsets.symmetric(
                          //     //               horizontal: 20, vertical: 10),
                          //     //           decoration: const BoxDecoration(
                          //     //             //boxShadow: shadowListSmall,
                          //     //               color: AppColors.askGray,
                          //     //               //border: Border.all(width: 1, color: AppColors.grey),
                          //     //               borderRadius: BorderRadius.all(
                          //     //                 Radius.circular(30),
                          //     //               )),
                          //     //           child: const Text(
                          //     //             "Sample",
                          //     //             style: TextStyle(
                          //     //                 fontFamily: "LatoRegular",
                          //     //                 fontSize: 12,
                          //     //                 fontWeight: FontWeight.w500,
                          //     //                 color: AppColors.white),
                          //     //           )),
                          //     //     ),
                          //     //   ],
                          //     // ),
                          //   ),
                          // ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            color: AppColors.black,
                            width: ScreenSize.width(context),
                            height: ScreenSize.width(context) * .5,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Image.network(
                                'https://playground.askfoundations.org/images/slider-images/slide3.png',
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          // Container(
                          //   //color: AppColors.red,
                          //   decoration: const BoxDecoration(
                          //     //boxShadow: shadowListSmall,
                          //       color: AppColors.askGray,
                          //       //border: Border.all(width: 1, color: AppColors.grey),
                          //       borderRadius: BorderRadius.only(
                          //           topRight: Radius.circular(20),
                          //           bottomRight: Radius.circular(20))),
                          //   width: ScreenSize.width(context) * .5,
                          //   height: ScreenSize.width(context) * .5,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(left: 20.0),
                          //     // child: Column(
                          //     //   mainAxisAlignment: MainAxisAlignment.center,
                          //     //   crossAxisAlignment: CrossAxisAlignment.start,
                          //     //   children: [
                          //     //     const Text("#",
                          //     //         style: TextStyle(
                          //     //             fontFamily: "LatoRegular",
                          //     //             fontSize: 18,
                          //     //             fontWeight: FontWeight.w900,
                          //     //             color: AppColors.white)),
                          //     //     const SizedBox(
                          //     //       height: 8,
                          //     //     ),
                          //     //     const Text(
                          //     //         "#",
                          //     //         style: TextStyle(
                          //     //             fontFamily: "LatoRegular",
                          //     //             fontSize: 12,
                          //     //             fontWeight: FontWeight.w500,
                          //     //             color: AppColors.white)),
                          //     //     const SizedBox(
                          //     //       height: 16,
                          //     //     ),
                          //     //     GestureDetector(
                          //     //       onTap: () {
                          //     //         Utils.showTopSnackBar(
                          //     //           t: "A.S.K",
                          //     //           m: "A.S.K",
                          //     //           tc: AppColors.black,
                          //     //           d: 3,
                          //     //           bc: AppColors.askBlue,
                          //     //           sp: SnackPosition.BOTTOM,
                          //     //         );
                          //     //       },
                          //     //       child: Container(
                          //     //           padding: const EdgeInsets.symmetric(
                          //     //               horizontal: 20, vertical: 10),
                          //     //           decoration: const BoxDecoration(
                          //     //             //boxShadow: shadowListSmall,
                          //     //               color: AppColors.askGray,
                          //     //               //border: Border.all(width: 1, color: AppColors.grey),
                          //     //               borderRadius: BorderRadius.all(
                          //     //                 Radius.circular(30),
                          //     //               )),
                          //     //           child: const Text(
                          //     //             "Sample",
                          //     //             style: TextStyle(
                          //     //                 fontFamily: "LatoRegular",
                          //     //                 fontSize: 12,
                          //     //                 fontWeight: FontWeight.w500,
                          //     //                 color: AppColors.white),
                          //     //           )),
                          //     //     ),
                          //     //   ],
                          //     // ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],

                    //Slider Container properties
                    options: CarouselOptions(
                        height: ScreenSize.width(context) * 0.5,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                        const Duration(milliseconds: 2000),
                        viewportFraction: 1,
                        onPageChanged:
                            (int index, CarouselPageChangedReason reason) {
                          if (reason == CarouselPageChangedReason.manual ||
                              reason == CarouselPageChangedReason.timed) {
                            //Get.snackbar("Page Changed", "Current page: $index");

                            controller.setCurrentSlide((index + 1));
                          }
                        }),
                  ),
                  //



                  Column(
                    children: [
                      SizedBox(height: 10,),
                      const Text(
                        "Help Requests",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "LatoRegular",
                          color: AppColors.askBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        color: AppColors.askBlue,
                        height: 2,
                        width: 64,
                      ),
                      const SizedBox(height: 8,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),

                        child: Container(
                          // color: Colors.red,
                          // padding: const EdgeInsets.symmetric(vertical: 4),
                            height: 240,
                            child: Obx(() => ListView.builder(
                              controller: controller.helpScrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.helpRequestsData.length,
                              itemBuilder: (context, index) {

                                hrd.Data helpRequest = controller.helpRequestsData[index]!;

                                return GestureDetector(
                                  onLongPress: () {
                                    // controller.showTopSnackBar(
                                    //   t: "#",
                                    //   m: "long pressed...",
                                    //   tc: AppColors.black,
                                    //   d: 3,
                                    //   bc: AppColors.green,
                                    //   sp: SnackPosition.BOTTOM,
                                    // );
                                  },
                                  onTap: () async {
                                    controller.searchRequestsController.clear();

                                    await controller.handleNavigation(1);
                                    await controller.scrollToNewRequest(int.parse(helpRequest.id!));

                                    // //open product details view
                                    // Get.to(() => ProductDetailsView(
                                    //   product: product,
                                    //   productImage:
                                    //   "https://es.shopafricana.co/product-images/detailed-900x1125/" + "${product.productImages![0]}",
                                    // ));

                                    // Utils.showTopSnackBar(
                                    //   t: helpRequest.user!.fullname!,
                                    //   m: "Request view will open",
                                    //   tc: AppColors.white,
                                    //   d: 3,
                                    //   bc: AppColors.askBlue,
                                    //   sp: SnackPosition.BOTTOM,
                                    // );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    margin: EdgeInsets.only(right: 8),
                                    // color: Colors.redAccent,
                                    decoration: BoxDecoration(
                                      // color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 12)),
                                      border: Border.all(width: 1, color: AppColors.askGray),
                                    ),
                                    width: 144,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    "https://playground.askfoundations.org/backend/api/v1/response/" +
                                                        // "https://askfoundations.org/" +
                                                        "${helpRequest.requestImage}",
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
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          // color: Colors.green,
                                          //alignment: Alignment.center,
                                            width: double.infinity,
                                            //padding: EdgeInsets.all(10),
                                            //margin: const EdgeInsets.only(right: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                                  child: Text(
                                                    helpRequest.description!,
                                                    style: const TextStyle(
                                                      fontFamily: "LatoRegular",
                                                      color: Colors.black,
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      controller.formatNominationCount(helpRequest.nominationCount!),
                                                      style: const TextStyle(
                                                        fontFamily: "LatoRegular",
                                                        color: AppColors.askBlue,
                                                        fontSize: 18.0,
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                AskButton(
                                                  enabled: true,
                                                  text: "Nominate",
                                                  function: () async {
                                                    controller.searchRequestsController.clear();

                                                    await controller.handleNavigation(1);
                                                    await controller.scrollToNewRequest(int.parse(helpRequest.id!));


                                                    // Utils.showTopSnackBar(
                                                    //   t: helpRequest.user!.fullname!,
                                                    //   m: "Request view will open",
                                                    //   tc: AppColors.white,
                                                    //   d: 3,
                                                    //   bc: AppColors.askBlue,
                                                    //   sp: SnackPosition.BOTTOM,
                                                    // );

                                                  },
                                                  backgroundColor: AppColors.askOrange,
                                                  textColor: AppColors.white,
                                                  buttonWidth: 100, //ScreenSize.scaleWidth(context, 80),
                                                  buttonHeight: 28, //ScreenSize.scaleHeight(context, 20),
                                                  borderCurve: 4,
                                                  border: false,
                                                  textSize: 12,
                                                ),


                                                // const SizedBox(
                                                //   height: 2,
                                                // ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ))),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Column(
                    children: [
                      SizedBox(height: 10,),
                      const Text(
                        "Beneficiaries",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "LatoRegular",
                          color: AppColors.askBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8,),
                      Container(
                        color: AppColors.askBlue,
                        height: 2,
                        width: 64,
                      ),
                      const SizedBox(height: 8,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenSize.scaleWidth(context, 24)),

                        child: Container(
                          // color: Colors.red,
                          // padding: const EdgeInsets.symmetric(vertical: 4),
                            height: 260,
                            child: Obx(() => ListView.builder(
                              controller: controller.beneficiariesScrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.beneficiariesData.length,
                              itemBuilder: (context, index) {

                                bd.Data beneficiary = controller.beneficiariesData[index]!;

                                return GestureDetector(
                                  onLongPress: () {
                                    // controller.showTopSnackBar(
                                    //   t: "#",
                                    //   m: "long pressed...",
                                    //   tc: AppColors.black,
                                    //   d: 3,
                                    //   bc: AppColors.green,
                                    //   sp: SnackPosition.BOTTOM,
                                    // );
                                  },
                                  onTap: () {
                                    controller.handleNavigation(3);

                                    // Get.to(() => const BeneficiariesView(),
                                    //     transition: Transition.fadeIn, // Built-in transition type
                                    //     duration: const Duration(milliseconds: 500),
                                    //     // binding: AuthBinding()
                                    // );


                                    // //open product details view
                                    // Get.to(() => ProductDetailsView(
                                    //   product: product,
                                    //   productImage:
                                    //   "https://es.shopafricana.co/product-images/detailed-900x1125/" + "${product.productImages![0]}",
                                    // ));

                                    // Utils.showTopSnackBar(
                                    //   t: helpRequest.user!.fullname!,
                                    //   m: "Request view will open",
                                    //   tc: AppColors.white,
                                    //   d: 3,
                                    //   bc: AppColors.askBlue,
                                    //   sp: SnackPosition.BOTTOM,
                                    // );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    margin: EdgeInsets.only(right: 8),
                                    // color: Colors.redAccent,
                                    decoration: BoxDecoration(
                                      // color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(ScreenSize.scaleHeight(context, 12)),
                                      border: Border.all(width: 1, color: beneficiary.status! == "approved" ? AppColors.askGreen : AppColors.askOrange),
                                    ),
                                    width: 144,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                                        "${beneficiary.user!.profilePicture}",
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
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          // color: Colors.green,
                                          //alignment: Alignment.center,
                                            width: double.infinity,
                                            //padding: EdgeInsets.all(10),
                                            //margin: const EdgeInsets.only(right: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                                  child: Text(
                                                    currencyFormat.format(double.parse(beneficiary.amount!)),
                                                    style: const TextStyle(
                                                      // fontFamily: "LatoRegular",
                                                      color: Colors.black,
                                                      fontSize: 16.0,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                                  child: Text(
                                                    beneficiary.date!,
                                                    style: const TextStyle(
                                                      fontFamily: "LatoRegular",
                                                      color: Colors.black,
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                // const SizedBox(
                                                //   height: 2,
                                                // ),
                                                // Row(
                                                //   mainAxisAlignment: MainAxisAlignment.center,
                                                //   children: [
                                                //     Text(
                                                //       beneficiary.nominationCount!,
                                                //       style: const TextStyle(
                                                //         fontFamily: "LatoRegular",
                                                //         color: AppColors.askBlue,
                                                //         fontSize: 18.0,
                                                //         fontWeight: FontWeight.w800,
                                                //       ),
                                                //       textAlign: TextAlign.center,
                                                //     ),
                                                //   ],
                                                // ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Row(children: [
                                                  Expanded(
                                                    child: AskButton(
                                                      enabled: true,
                                                      text: beneficiary.remark!,
                                                      function: () async {

                                                        // Utils.showTopSnackBar(
                                                        //   t: helpRequest.user!.fullname!,
                                                        //   m: "Request view will open",
                                                        //   tc: AppColors.white,
                                                        //   d: 3,
                                                        //   bc: AppColors.askBlue,
                                                        //   sp: SnackPosition.BOTTOM,
                                                        // );

                                                      },
                                                      backgroundColor: AppColors.askSoftTheme,
                                                      textColor: AppColors.askText,
                                                      buttonWidth: 100, //ScreenSize.scaleWidth(context, 80),
                                                      buttonHeight: 28, //ScreenSize.scaleHeight(context, 20),
                                                      borderCurve: 4,
                                                      border: false,
                                                      textSize: 12,
                                                    ),
                                                  ),
                                                ],),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                AskButton(
                                                  enabled: true,
                                                  text: beneficiary.status![0].toUpperCase() + beneficiary.status!.substring(1),
                                                  function: () async {

                                                    // Utils.showTopSnackBar(
                                                    //   t: helpRequest.user!.fullname!,
                                                    //   m: "Request view will open",
                                                    //   tc: AppColors.white,
                                                    //   d: 3,
                                                    //   bc: AppColors.askBlue,
                                                    //   sp: SnackPosition.BOTTOM,
                                                    // );

                                                  },
                                                  backgroundColor: AppColors.askOrange,
                                                  textColor: AppColors.white,
                                                  buttonWidth: 100, //ScreenSize.scaleWidth(context, 80),
                                                  buttonHeight: 28, //ScreenSize.scaleHeight(context, 20),
                                                  borderCurve: 4,
                                                  border: false,
                                                  textSize: 12,
                                                ),


                                                // const SizedBox(
                                                //   height: 2,
                                                // ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ))),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                ],
              )
          ),)
      ),
    );
  }
}
