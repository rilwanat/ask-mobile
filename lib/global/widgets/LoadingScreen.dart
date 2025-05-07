import 'package:flutter/material.dart';

import '../app_color.dart';
import '../screen_size.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1.0,
      child: SizedBox(
        height: ScreenSize.height(context),
        width: ScreenSize.width(context),
        // color: AppColors.eDoctorBlue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  // Container(
                  //   height: 80,
                  //   margin: const EdgeInsets.only(top: 12),
                  //   child: Align(
                  //     alignment: Alignment.center,
                  //     child: Image.asset(
                  //       "assets/images/icons/Featured icon.png",
                  //       fit: BoxFit.contain,
                  //       //size: 36,
                  //       //color: AppColors.white,
                  //     ),
                  //   ),
                  // ),
                  Center(
                    child: SizedBox(
                        height: ScreenSize.width(context) * .2,
                        width: ScreenSize.width(context) * .2,
                        child: const CircularProgressIndicator(
                          color: AppColors.askBlue,
                          strokeWidth: 1,
                        ) //Lottie.asset('assets/json/loading.json'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Please wait..",
                style: TextStyle(color: AppColors.askBlue),
              )
              // SizedBox(
              //     height: width(context) * .1,
              //     width: width(context) * .1,
              //     child: const CircularProgressIndicator(
              //       color: AppColors.priceWatchBlue,
              //       strokeWidth: 4,
              //     ) //Lottie.asset('assets/json/loading.json'),
              //     ),
            ],
          ),
        ),
      ),
    );
  }
}