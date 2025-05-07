import 'package:flutter/material.dart';

import 'package:get/get.dart';

class IaskView extends GetView {
  const IaskView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IaskView'),
        centerTitle: true,
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
