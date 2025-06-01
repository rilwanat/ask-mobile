import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/app_bar.dart';
import '../../../../global/widgets/navbar.dart';
import '../controllers/home_controller.dart';

class FaqView extends GetView<HomeController> {
  const FaqView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.askBackground,
      // appBar: AppBar(
      //   title: const Text('FAQs'),
      //   centerTitle: true,
      // ),
      // key: controller.scaffoldKey,

      // drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: AppColors.askBlue,
        iconTheme: const IconThemeData(color: AppColors.white),
        title: const
        Text(
          'A.S.K- FAQs',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: "LatoRegular",
            color: AppColors.white,
          ),
        ),
        // Text('A.S.K- FAQs'),
      ),
      body: Stack(
        children: [
          Container(
            height: ScreenSize.height(context),
            width: ScreenSize.width(context),
            child: Padding(
              padding: EdgeInsets.all(ScreenSize.scaleWidth(context, 10)),//24)),
              child: Stack(
                children: [
                  Positioned(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: ScreenSize.scaleHeight(context, 20),),
                          // SizedBox(height: ScreenSize.scaleHeight(context, 40),),
                          // const XippAppBar(
                          //   title: "FAQs",
                          //   showBackArrow: true,
                          //   textColor: AppColors.xippText,
                          // ),

                          Expanded(child: Container(
                            height: ScreenSize.height(context) * .7,
                            width: ScreenSize.width(context),
                            child: SingleChildScrollView(
                                child: Column(
                                  children: [

                                    FaqItem(
                                      question: "How do I ...",
                                      answer: "To ..",
                                    ),


                                  ],
                                )),
                          )),




                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const FaqItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: ScreenSize.width(context),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.askBlue,
                fontFamily: "LatoRegular",

              ),
            ),
            const SizedBox(height: 8),
            Text(
              answer,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                fontFamily: "LatoRegular",
              ),
            ),
          ],
        ),
      ),
    );
  }
}