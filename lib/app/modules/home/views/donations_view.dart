import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DonationsView extends GetView {
  const DonationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DonationsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DonationsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
