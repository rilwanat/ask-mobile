import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/default_controller.dart';

class DefaultView extends GetView<DefaultController> {
  const DefaultView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DefaultView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DefaultView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
