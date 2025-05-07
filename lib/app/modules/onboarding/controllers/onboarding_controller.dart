import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../global/app_strings.dart';
import '../../../../utils/utils.dart';

class OnboardingController extends GetxController {

  final List<Map<String, String>> onboardingTexts = [
    {
      'title': OnboardingStrings.WELCOME,
      'subtitle': OnboardingStrings.SUBTITLE1,
    },
    {
      'title': OnboardingStrings.HEADER2,
      'subtitle': OnboardingStrings.SUBTITLE2,
    },
    {
      'title': OnboardingStrings.HEADER3,
      'subtitle': OnboardingStrings.SUBTITLE3,
    }
  ];


  final _currentStep = 0.obs;
  int get currentStep => _currentStep.value;

  nextStep() {
    if (_currentStep.value < 4) {
      _currentStep.value++;
      update();
      //print("currentStep: " + currentStep.value.toString());
    } else {
      // print("currentStep: " + _currentStep.value.toString());
      skipToBegin();
    }
  }

  previousStep() {
    if (_currentStep.value > 1) {
      _currentStep.value--;
      update();
      //print("currentStep: " + currentStep.value.toString());
    }
  }

  skipToBegin() {
    // Get.toNamed(Routes.BEGIN);
  }

  finalStep() {
    setStep(4);
    //print("finalStep: " + _currentStep.value.toString());
  }

  initStep() {
    _currentStep.value = 0;
    update();
  }

  setStep(int val) {
    _currentStep.value = val;
    update();
  }

  void onHorizontalDrag(DragEndDetails details) {
    if (details.primaryVelocity == null) return;

    if (details.primaryVelocity! < 0 && _currentStep.value < onboardingTexts.length - 1) {
      _currentStep.value++;
      update();
    } else if (details.primaryVelocity! > 0 && _currentStep.value > 0) {
      _currentStep.value--;
      update();
    }
  }



  @override
  void onInit() {
    Utils.hideKeyboard();
    Future.delayed(const Duration(seconds: 5), () {
      setStep(0);
    });

    super.onInit();
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
