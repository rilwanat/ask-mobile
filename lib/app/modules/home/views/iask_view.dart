import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../global/widgets/app_bar.dart';

class IaskView extends GetView {
  const IaskView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.askBackground,
      appBar: CustomAppBar(
        onMorePressed: () {
          // Handle menu button press
          print('More options pressed');
        },
        title: 'A.S.K',
        backgroundColor: AppColors.askBlue,
      ),
      body: const Center(
        child: Text(
          'IaskView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
