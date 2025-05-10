import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../utils/utils.dart';
import '../../../data/models/beneficiaries/BeneficiariesResponse.dart';
import '../../../data/models/login/UserData.dart';
import '../../../data/models/profile/ProfileResponse.dart';
import '../../../data/models/requests/HelpRequestsResponse.dart';
import '../../../data/network/dio_error.dart';
import '../../../data/services/secure_service.dart';
import '../../../data/storage/cached_data.dart';
import '../../auth/bindings/auth_binding.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/views/login_view.dart';
import '../views/dashboard_view.dart';
import '../views/iask_view.dart';
import '../views/profile_view.dart';
import '../views/requests_view.dart';

import '../../../data/models/requests/Data.dart' as hrd;
import '../../../data/models/beneficiaries/Data.dart' as bd;

class HomeController extends GetxController {

  final CachedData _cachedData = CachedData();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var showBottomNav = true.obs;
  final _navIndex = 0.obs;
  int get navIndex => _navIndex.value;
  void handleNavigation(int value) {
    update([_navIndex.value = value]);
    // if (value == 2) showBottomNav.value = false;
    // print(value);
  }
  final screens = <Widget>[
    DashboardView(),
    RequestsView(),
    IaskView(),
    ProfileView(),
  ];

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  setLoading(bool? b) {
    _isLoading.value = b!;
    update();
  }

  RxString errorMessage = "".obs;

  Rx<UserData?> profileData = Rx<UserData?>(null);

  RxList<hrd.Data?> helpRequestsData = RxList<hrd.Data?>([]);
  final ScrollController helpScrollController = ScrollController();
  Timer? helpAutoScrollTimer;
  int helpCurrentIndex = 0;

  RxList<bd.Data?> beneficiariesData = RxList<bd.Data?>([]);
  final ScrollController beneficiariesScrollController = ScrollController();
  Timer? beneficiariesAutoScrollTimer;
  int beneficiariesCurrentIndex = 0;


  Future<void> _initializeProfileData() async {
    setLoading(true);
    await getUserProfile();
    await getRequests();
    await getBeneficiaries();


    // await getUserNotifications();
    // await getUserTransactionsHistory();
    // await getMyBudgets();
    setLoading(false);
  }
  _initializeControllers() {
    // searchPhoneUsersController = TextEditingController();
  }
  // _initializeFocusNodes() {
  //   xippTransferNumberFocusNode.addListener(_handleFocusChange);
  //
  //   // // Listen for keyboard visibility changes
  //   // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   //   ever(_showContinue, (_) => update()); // Ensure UI updates when `_showContinue` changes
  //   //   WidgetsBinding.instance!.addObserver(KeyboardVisibilityObserverHome());
  //   // });
  // }

  homeGetUserProfileFromServer() async {
    setLoading(true);
    // print("homeGetUserProfileFromServer");

    errorMessage.value = "";
    try {
      ProfileResponse? response;
      response =
      await SecureService().getUserProfile(email: profileData.value!.emailAddress!);

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "homeGetUserProfileFromServer-h",
        //     m: "${response!.toJson().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        await _cachedData.saveProfileData(UserData.fromJson(response.profileUserData!.toJson()));
        // print("Saved from H");
        profileData.value = await _cachedData.getProfileData();



      } else {
        errorMessage.value = "homeGetUserProfileFromServer: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "homeGetUserProfileFromServer-h",
            m: errorMessage.value, //"${response.message}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.red,
            sp: SnackPosition.TOP);
      }

      //clearOtpFields();
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "Error",
          m: "$message",
          tc: AppColors.white,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }

  Future<void> getUserProfile() async {



    try {
      profileData.value = await _cachedData.getProfileData();
      // print("_cachedData profileData");
      // print(profileData.value!.toJson().toString());

      await homeGetUserProfileFromServer();

      update();
    } catch (e) {
      profileData.value = null;
    }
  }

  @override
  void onInit() {
    _initializeControllers();
    _initializeProfileData();

    // startAutoScroll();

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

  @override
  void dispose() {
    helpAutoScrollTimer?.cancel();
    helpScrollController.dispose();
    super.dispose();
  }

  void startAutoScroll() {
    helpAutoScrollTimer = Timer.periodic(Duration(seconds: 7), (timer) {
      if (helpCurrentIndex < helpRequestsData.length - 1) {
        helpCurrentIndex++;
      } else {
        helpCurrentIndex = 0; // Loop back to first item
      }

      // Animate to the next item
      helpScrollController.animateTo(
        helpCurrentIndex * 160.0, // 144 width + 8 margin on each side
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  final _currentSlide = 1.obs;
  int get currentSlide => _currentSlide.value;
  setCurrentSlide(int val) {
    _currentSlide.value = val;
  }

  logoutUser() async {
    setLoading(true);
    //print("loginPatient");

    //int.tryParse(
    //

    errorMessage.value = "";
    try {

      // Force remove the controller
      Get.delete<AuthController>(force: true);
      // Optional: Force recreate the controller
      // Get.put(AuthController());

      _cachedData.clearAllSavedDetails(userType: '');
      setLoading(false);


      Get.to(() => LoginView(),
          transition: Transition.fadeIn, // Built-in transition type
          duration: Duration(milliseconds: 500),
          binding: AuthBinding()
      );



    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "Error",
          m: message,
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }


  getRequests() async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      HelpRequestsResponse? response;
      response =
      await SecureService().readRequests();

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        Utils.showTopSnackBar(
            t: "A.S.K Help Requests",
            m: "${response.data!.length.toString().toString()}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.askBlue,
            sp: SnackPosition.TOP);

        helpRequestsData.value = response.data!;


      } else {
        errorMessage.value = "A.S.K Help Requests: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Help Requests",
            m: errorMessage.value, //"${response.message}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.red,
            sp: SnackPosition.TOP);
      }

      //clearOtpFields();
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "A.S.K Help Requests: Error",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }

  getBeneficiaries() async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      BeneficiariesResponse? response;
      response =
      await SecureService().readBeneficiaries();

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        Utils.showTopSnackBar(
            t: "A.S.K Beneficiaries",
            m: "${response.data!.length.toString().toString()}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.askBlue,
            sp: SnackPosition.TOP);

        beneficiariesData.value = response.data!;


      } else {
        errorMessage.value = "A.S.K Beneficiaries: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Beneficiaries",
            m: errorMessage.value, //"${response.message}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.red,
            sp: SnackPosition.TOP);
      }

      //clearOtpFields();
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "A.S.K Beneficiaries: Error",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }

}
