import 'package:get/get.dart';

import '../controllers/default_controller.dart';

class DefaultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DefaultController>(
      () => DefaultController(),
    );
  }
}
