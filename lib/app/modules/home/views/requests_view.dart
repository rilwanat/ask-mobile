import 'package:flutter/material.dart';

import 'package:get/get.dart';

class RequestsView extends GetView {
  const RequestsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RequestsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RequestsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
