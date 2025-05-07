import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/utils.dart';

class AuthController extends GetxController {

  late TextEditingController registerEmailController;
  late TextEditingController registerPasswordController;
  late TextEditingController registerConfirmPasswordController;

  late TextEditingController loginEmailController;
  late TextEditingController loginPasswordController;

  final FocusNode registerEmailFocusNode = FocusNode();
  final FocusNode registerPasswordFocusNode = FocusNode();
  final FocusNode registerConfirmPasswordFocusNode = FocusNode();

  final FocusNode loginEmailFocusNode = FocusNode();
  final FocusNode loginPasswordFocusNode = FocusNode();

  final _showContinue = true.obs;
  bool get showContinue => _showContinue.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  setLoading(bool? b) {
    _isLoading.value = b!;
    update();
  }

  @override
  void onInit() {
    Utils.hideKeyboard();

    _initializeControllers();
    _initializeFocusNodes();


    super.onInit();
  }

  _initializeControllers() {
    registerEmailController = TextEditingController();
    registerPasswordController = TextEditingController();
    registerConfirmPasswordController = TextEditingController();

    loginEmailController = TextEditingController();
    loginPasswordController = TextEditingController();
  }

  _initializeFocusNodes() {
    registerEmailFocusNode.addListener(_handleFocusChange);
    registerPasswordFocusNode.addListener(_handleFocusChange);
    registerConfirmPasswordFocusNode.addListener(_handleFocusChange);

    loginEmailFocusNode.addListener(_handleFocusChange);
    loginPasswordFocusNode.addListener(_handleFocusChange);



    // Listen for keyboard visibility changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ever(_showContinue, (_) => update()); // Ensure UI updates when `_showContinue` changes

      WidgetsBinding.instance!.addObserver(KeyboardVisibilityObserverHome());
    });
  }

  void _handleFocusChange() {
    if (
    registerEmailFocusNode.hasFocus
        || registerPasswordFocusNode.hasFocus
        || registerConfirmPasswordFocusNode.hasFocus

        || loginEmailFocusNode.hasFocus
        || loginPasswordFocusNode.hasFocus

    ) {
      setShowContinue(false);
    }
  }
  setShowContinue(bool? b) {
    _showContinue.value = b!;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


}

class KeyboardVisibilityObserverHome extends WidgetsBindingObserver {
  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.platformDispatcher.views.first.viewInsets.bottom;
    // if (!Get.isRegistered<TransferController>()) {
    //   Get.put(TransferController());
    // }

    if (bottomInset == 0.0) {
      // Keyboard is fully closed
      Get.find<AuthController>().setShowContinue(true);
    } else {
      // Keyboard is open
      Get.find<AuthController>().setShowContinue(false);
    }
  }
}