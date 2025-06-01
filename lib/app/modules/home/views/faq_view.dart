import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/screen_size.dart';
import '../../../../global/widgets/app_bar.dart';
import '../../../../global/widgets/navbar.dart';
import '../controllers/home_controller.dart';

import 'package:url_launcher/url_launcher.dart';

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
          'A.S.K - Contact',
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

                                    // FaqItem(
                                    //   question: "How do I ...",
                                    //   answer: "To ..",
                                    // ),

                                    Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      width: ScreenSize.width(context),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Row(
                                              children: [
                                                Icon(Icons.phone),
                                                SizedBox(width: 8),
                                                Text(
                                                  "Phone Number",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.askBlue,
                                                    fontFamily: "LatoRegular",

                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            GestureDetector(
                                              onTap: () => _launchUrl("tel:+2349122090051"),
                                              child: const Text(
                                                "+234 912 2090 051",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1.5,
                                                  fontFamily: "LatoRegular",
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            GestureDetector(
                                              onTap: () => _launchUrl("tel:+447864869571"),
                                              child: const Text(
                                                "+44 786 4869 571",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1.5,
                                                  fontFamily: "LatoRegular",
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            GestureDetector(
                                              onTap: () async {
                                                const whatsappUrl = "https://wa.me/2349051047138";
                                                const fallbackUrl = "https://api.whatsapp.com/send?phone=2349051047138";

                                                if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                                                  await launchUrl(
                                                    Uri.parse(whatsappUrl),
                                                    mode: LaunchMode.externalApplication, // This is important
                                                  );
                                                } else if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
                                                  await launchUrl(Uri.parse(fallbackUrl), mode: LaunchMode.externalApplication);
                                                } else {
                                                  // Fallback or show error
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text("Could not launch WhatsApp")),
                                                  );
                                                }
                                              },
                                              child: const Text(
                                                "+234 905 1047 138",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1.5,
                                                  fontFamily: "LatoRegular",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      width: ScreenSize.width(context),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Row(
                                              children: [
                                                Icon(Icons.email),
                                                SizedBox(width: 8),
                                                Text(
                                                  "Email Address",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.askBlue,
                                                    fontFamily: "LatoRegular",

                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            GestureDetector(
                                              onTap: () async {
                                                const url = "mailto:info@askfoundations.org";
                                                if (await canLaunchUrl(Uri.parse(url))) {
                                                  await launchUrl(
                                                    Uri.parse(url),
                                                    mode: LaunchMode.externalApplication,
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text("Could not launch email client")),
                                                  );
                                                }
                                              },
                                              child: const Text(
                                                "info@askfoundations.org",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1.5,
                                                  fontFamily: "LatoRegular",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      width: ScreenSize.width(context),
                                      child: const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.place),
                                                SizedBox(width: 8),
                                                Text(
                                                  "Address",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.askBlue,
                                                    fontFamily: "LatoRegular",

                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "69 Avenue Road, \nBexleyheath Kent DA7 4EQ, \nLondon.",
                                              style: TextStyle(
                                                fontSize: 14,
                                                height: 1.5,
                                                fontFamily: "LatoRegular",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )


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



Future<void> _launchUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  }
}
