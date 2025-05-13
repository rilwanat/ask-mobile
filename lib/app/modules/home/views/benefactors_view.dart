import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BenefactorsView extends GetView {
  const BenefactorsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BenefactorsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BenefactorsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
