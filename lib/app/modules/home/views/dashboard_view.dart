import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DashboardView extends GetView {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DashboardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
