import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../utils/utils.dart';
import '../../../data/models/login/LoginResponse.dart';
import '../../../data/models/register/RegisterResponse.dart';
import '../../../data/network/dio_error.dart';
import '../../../data/services/secure_service.dart';
import '../../../data/storage/cached_data.dart';
import '../../home/bindings/home_binding.dart';
import '../../home/views/home_view.dart';
import '../bindings/auth_binding.dart';
import '../views/login_view.dart';

class AuthController extends GetxController {

  final CachedData _cachedData = CachedData();

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

  final _obscurePassword = true.obs;
  bool get obscurePassword => _obscurePassword.value;

  RxString errorMessage = "".obs;

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

  toggleObscurePassword() {
    update([_obscurePassword.value = !_obscurePassword.value]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  registerUser({
    required String email,
    required String password,
  }) async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      RegisterResponse? response;
      response =
      await SecureService().registerUser(
          email: email,
          password: password
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // showTopSnackBar(
        //     t: "A.S.K Registration",
        //     m: "${response!.toJson().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.gold,
        //     sp: SnackPosition.TOP);


        Get.off(() => LoginView(),
            transition: Transition.fadeIn, // Built-in transition type
            duration: Duration(milliseconds: 500),
            binding: AuthBinding()
        );

        registerEmailController.clear();
        registerPasswordController.clear();
        registerConfirmPasswordController.clear();

      } else {
        errorMessage.value = "A.S.K Registration: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Registration",
            m: errorMessage.value, //"${response.message}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.askBlue,
            sp: SnackPosition.TOP);
      }

      //clearOtpFields();
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "A.S.K Registration: Error",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }

  loginUser({
    required String email,
    required String password,
  }) async {
    setLoading(true);
    //print("loginUser");

    errorMessage.value = "";
    try {
      LoginResponse? response;
      response =
      await SecureService().loginUser(
          email: email,
          password: password
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // showTopSnackBar(
        //     t: "A.S.K Login",
        //     m: "${response!.toJson().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.gold,
        //     sp: SnackPosition.TOP);

        _cachedData.saveAuthToken(response.token!);
        _cachedData.saveUserType("User");

        await _cachedData.saveProfileData(response!.userData!);


        Get.to(() => HomeView(),
            transition: Transition.fadeIn, // Built-in transition type
            duration: Duration(milliseconds: 500),
            binding: HomeBinding()
        );

        loginEmailController.clear();
        loginPasswordController.clear();

      } else {
        errorMessage.value = "A.S.K Login: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Login",
            m: errorMessage.value, //"${response.message}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.askBlue,
            sp: SnackPosition.TOP);
      }

      //clearOtpFields();
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "A.S.K Login: Error",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }

  //
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