import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

import '../../../data/models/login/UserData.dart';

class AuthController extends GetxController {

  final CachedData _cachedData = CachedData();

  late TextEditingController registerEmailController;
  late TextEditingController registerPasswordController;
  late TextEditingController registerConfirmPasswordController;

  late TextEditingController resetCodeController;
  late TextEditingController loginEmailController;
  late TextEditingController loginPasswordController;

  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

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

    resetCodeController = TextEditingController();

    loginEmailController = TextEditingController();
    loginPasswordController = TextEditingController();

    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
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

        Utils.showInformationDialog(
            status: true,
            title: 'A.S.K Registration',
            message: "${response!.message.toString()}"
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

        Utils.showInformationDialog(
            status: false,
            title: 'A.S.K Registration',
            message: errorMessage.value, //"${response.message}",
        );
      }

      //clearOtpFields();
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "A.S.K Registration: Attention",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);

      Utils.showInformationDialog(
        status: false,
        title: "A.S.K Registration: Attention",
        message: "$message",
      );
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

        await _cachedData.saveProfileData(response.userData!);


        Get.to(() => HomeView(),
            transition: Transition.fadeIn, // Built-in transition type
            duration: Duration(milliseconds: 500),
            binding: HomeBinding()
        );

        resetCodeController.clear();

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
          t: "A.S.K Login: Attention",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }


  Future<LoginResponse?> sendMobileResetPasswordCode({
    required String email
  }) async {
    setLoading(true);
    //print("loginUser");

    errorMessage.value = "";
    try {
      LoginResponse? response;
      response =
      await SecureService().sendMobileResetPassordCode(
          email: email
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K Reset Password",
        //     m: "${response!.toJson().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        // Utils.showInformationDialog(status: null, title: 'A.S.K Reset Password', message: "${response!.message.toString()}");


        // Get.to(() => HomeView(),
        //     transition: Transition.fadeIn, // Built-in transition type
        //     duration: Duration(milliseconds: 500),
        //     binding: HomeBinding()
        // );

        // resetCodeController.clear();


      } else {
        errorMessage.value = "A.S.K Reset Password: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Reset Password",
            m: errorMessage.value, //"${response.message}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.askBlue,
            sp: SnackPosition.TOP);
      }

      //clearOtpFields();
      return response;
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "A.S.K Reset Password: Attention",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);

      return null;
    }
  }

  Future<LoginResponse?> validateMobileResetPasswordCode({
    required String email,
    required String emailCode,
  }) async {
    setLoading(true);
    //print("loginUser");

    errorMessage.value = "";
    try {
      LoginResponse? response;
      response =
      await SecureService().validateMobileResetPasswordCode(
          email: email, emailCode: emailCode
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K Reset Password",
        //     m: "${response!.toJson().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        // Utils.showInformationDialog(status: null, title: 'A.S.K Reset Password', message: "${response!.message.toString()}");


        // Get.to(() => HomeView(),
        //     transition: Transition.fadeIn, // Built-in transition type
        //     duration: Duration(milliseconds: 500),
        //     binding: HomeBinding()
        // );

        resetCodeController.clear();


      } else {
        errorMessage.value = "A.S.K Validate Password Reset Code: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Validate Password Reset Code",
            m: errorMessage.value, //"${response.message}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.askBlue,
            sp: SnackPosition.TOP);
      }

      //clearOtpFields();
      return response;
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "A.S.K Validate Password Reset Code: Attention",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);

      return null;
    }
  }

  Future<LoginResponse?> resetPassword({
    required String email,
    required String newPassword
  }) async {
    setLoading(true);
    //print("loginUser");

    errorMessage.value = "";
    try {
      LoginResponse? response;
      response =
      await SecureService().resetPassword(
          email: email, newPassword: newPassword
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K Reset Password",
        //     m: "${response!.toJson().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        // Utils.showInformationDialog(status: null, title: 'A.S.K Reset Password', message: "${response!.message.toString()}");


        // Get.to(() => HomeView(),
        //     transition: Transition.fadeIn, // Built-in transition type
        //     duration: Duration(milliseconds: 500),
        //     binding: HomeBinding()
        // );

        // resetCodeController.clear();


      } else {
        errorMessage.value = "A.S.K Reset Password: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Reset Password",
            m: errorMessage.value, //"${response.message}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.askBlue,
            sp: SnackPosition.TOP);
      }

      //clearOtpFields();
      return response;
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "A.S.K Reset Password: Attention",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);

      return null;
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
        // clientId: '29695971301-m4taf9mpgcicjifuf6fp466ka5f9bjtu.apps.googleusercontent.com', // Optional for some platforms
      );

      // // Check if a user is currently signed in
      // if (await googleSignIn.isSignedIn()) {
      //   await googleSignIn.signOut();  // Sign out from Google
      //   await googleSignIn.disconnect(); // Optional: Revoke permissions (if needed)
      //
      //   print("User signed out successfully");
      //   return;
      // } else {
      //   print("No user is currently signed in");
      //   return;
      // }

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        // Get authentication details
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

        // You now have direct access to:
        // - googleAuth.idToken (JWT containing user info)
        // - googleAuth.accessToken (for API calls)
        // - googleUser (contains email, display name, photo, etc.)

        // print('User Email: ${googleUser.email}');
        // print('User Name: ${googleUser.displayName}');
        // print('User Photo: ${googleUser.photoUrl}');
        // print('ID Token: ${googleAuth.idToken}');
        // print('Access Token: ${googleAuth.accessToken}');

        // You can use these tokens directly in your app
        // For example, store them in shared preferences
        // or use them to make API calls to Google services

        // If you need to verify the ID token on client side only:
        // You can decode the JWT (but note client-side verification isn't secure)
        // final jwtParts = googleAuth.idToken!.split('.');
        // final payload = json.decode(utf8.decode(base64Url.decode(jwtParts[1])));

        // Proceed with your app flow
        // controller.finalStep();
        // controller.skipToBegin();

        await loginUserGoogleDirect(email: googleUser.email);

      }
    } catch (e) {
      print('Google Sign-In Error: $e');
      if (e is PlatformException) {
        print('Detailed error: ${e.message}');
        print('Error code: ${e.code}');
        print('Error details: ${e.details}');
      }
    }
  }

  registerWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
        // clientId: '29695971301-m4taf9mpgcicjifuf6fp466ka5f9bjtu.apps.googleusercontent.com', // Optional for some platforms
      );

      // // Check if a user is currently signed in
      // if (await googleSignIn.isSignedIn()) {
      //   await googleSignIn.signOut();  // Sign out from Google
      //   await googleSignIn.disconnect(); // Optional: Revoke permissions (if needed)
      //
      //   print("User signed out successfully");
      //   return;
      // } else {
      //   print("No user is currently signed in");
      //   return;
      // }

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        // Get authentication details
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

        // You now have direct access to:
        // - googleAuth.idToken (JWT containing user info)
        // - googleAuth.accessToken (for API calls)
        // - googleUser (contains email, display name, photo, etc.)

        // print('User Email: ${googleUser.email}');
        // print('User Name: ${googleUser.displayName}');
        // print('User Photo: ${googleUser.photoUrl}');
        // print('ID Token: ${googleAuth.idToken}');
        // print('Access Token: ${googleAuth.accessToken}');

        // You can use these tokens directly in your app
        // For example, store them in shared preferences
        // or use them to make API calls to Google services

        // If you need to verify the ID token on client side only:
        // You can decode the JWT (but note client-side verification isn't secure)
        // final jwtParts = googleAuth.idToken!.split('.');
        // final payload = json.decode(utf8.decode(base64Url.decode(jwtParts[1])));

        // Proceed with your app flow
        // controller.finalStep();
        // controller.skipToBegin();

        await registerUserGoogleDirect(email: googleUser.email);

      }
    } catch (e) {
      print('Google Sign-In Error: $e');
      if (e is PlatformException) {
        print('Detailed error: ${e.message}');
        print('Error code: ${e.code}');
        print('Error details: ${e.details}');
      }
    }
  }

  loginUserGoogleDirect({
    required String email,
    // required String password,
  }) async {
    setLoading(true);
    //print("loginUser");

    errorMessage.value = "";
    try {
      LoginResponse? response;
      response =
      await SecureService().loginUserGoogleDirect(
          email: email,
          // password: password
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

        await _cachedData.saveProfileData(response.userData!);


        Get.to(() => HomeView(),
            transition: Transition.fadeIn, // Built-in transition type
            duration: Duration(milliseconds: 500),
            binding: HomeBinding()
        );

        resetCodeController.clear();

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
          t: "A.S.K Login: Attention",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);

      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await googleSignIn.disconnect();
    }
  }

  registerUserGoogleDirect({
    required String email,
    // required String password,
  }) async {
    setLoading(true);
    //print("loginUser");

    errorMessage.value = "";
    try {
      LoginResponse? response;
      response =
      await SecureService().registerUserGoogleDirect(
        email: email,
        // password: password
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // showTopSnackBar(
        //     t: "A.S.K Register",
        //     m: "${response!.toJson().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.gold,
        //     sp: SnackPosition.TOP);

        _cachedData.saveAuthToken(response.token!);
        _cachedData.saveUserType("User");

        await _cachedData.saveProfileData(response.userData!);


        Get.to(() => HomeView(),
            transition: Transition.fadeIn, // Built-in transition type
            duration: Duration(milliseconds: 500),
            binding: HomeBinding()
        );

        resetCodeController.clear();

        loginEmailController.clear();
        loginPasswordController.clear();

      } else {
        errorMessage.value = "A.S.K Register: Something wrong happened. Try again";//response.message!;

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
      String message = DioExceptions.fromDioError(e).toString();
      //
      // Utils.showTopSnackBar(
      //     t: "A.S.K Register: Attention",
      //     m: "$message",
      //     tc: AppColors.black,
      //     d: 3,
      //     bc: AppColors.red,
      //     sp: SnackPosition.TOP);

      if (message == "Registration failed. Email already exists.") {
        message += " Please login to proceed.";
      }
      Utils.showInformationDialog(status: null, title: 'A.S.K Register', message: "$message", meta: email);

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