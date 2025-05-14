import 'dart:async';
import 'dart:io';

import 'package:ask_mobile/global/screen_size.dart';
import 'package:camera/camera.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/app_color.dart';
import '../../../../utils/utils.dart';
import '../../../data/models/banks/BankCodeResponse.dart';
import '../../../data/models/beneficiaries/BeneficiariesResponse.dart';
import '../../../data/models/donations/DonationsResponse.dart';
import '../../../data/models/login/UserData.dart';
import '../../../data/models/profile/ProfileResponse.dart';
import '../../../data/models/requests/HelpRequestsResponse.dart';
import '../../../data/models/resend_verification/ResendVerificationCodeResponse.dart';
import '../../../data/models/sponsors/SponsorsResponse.dart';
import '../../../data/models/status_message/StatusMessageResponse.dart';
import '../../../data/models/verify_email/VerifyEmailResponse.dart';
import '../../../data/network/dio_error.dart';
import '../../../data/services/secure_service.dart';
import '../../../data/storage/cached_data.dart';
import '../../auth/bindings/auth_binding.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/views/login_view.dart';
import '../views/beneficiaries_view.dart';
import '../views/dashboard_view.dart';
import '../views/iask_view.dart';
import '../views/profile_view.dart';
import '../views/requests_view.dart';

import '../../../data/models/requests/Data.dart' as hrd;
import '../../../data/models/beneficiaries/Data.dart' as bd;
import '../../../data/models/sponsors/Data.dart' as sd;
import '../../../data/models/banks/Data.dart' as bc;
import '../../../data/models/donations/Data.dart' as dd;

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
    // ProfileView(),
    BeneficiariesView(),
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

  RxList<sd.Data?> sponsorsData = RxList<sd.Data?>([]);
  final ScrollController sponsorsScrollController = ScrollController();
  Timer? sponsorsAutoScrollTimer;
  int sponsorsCurrentIndex = 0;

  RxList<dd.Data?> donationsData = RxList<dd.Data?>([]);
  final ScrollController donationsScrollController = ScrollController();
  Timer? donationsAutoScrollTimer;
  int donationsCurrentIndex = 0;


  final ScrollController singleRequestScrollController = ScrollController();
  final RxInt currentRequestIndex = 0.obs;
  final RxString searchText = ''.obs;
  late TextEditingController searchRequestsController;
  RxList<hrd.Data?> filteredRequestsData = RxList<hrd.Data?>([]);


  RxList<bc.Data?> bankCodeData = RxList<bc.Data?>([]);

  late TextEditingController emailVerificationController;

  late TextEditingController kycPhoneNumberController;
  late TextEditingController kycAccountNumberController;
  late TextEditingController kycBankNameController;
  late TextEditingController kycGenderController;
  late TextEditingController kycStateOfResidenceController;


  final _selectedBankName = 'Select'.obs;
  String get selectedBankName => _selectedBankName.value;
  void setSelectedBankName(String s) {
    _selectedBankName.value = s;
    update();
  }
  final _selectedBankCode = ''.obs;
  String get selectedBankCode => _selectedBankCode.value;
  void setSelectedBankCode(String s) {
    _selectedBankCode.value = s;
    update();
  }

  final _selectedGender = 'Select'.obs;
  String get selectedGender => _selectedGender.value;
  void setSelectedGender(String s) {
    _selectedGender.value = s;
    update();
  }

  final _selectedStateOfResidence = 'Select'.obs;
  String get selectedStateOfResidence => _selectedStateOfResidence.value;
  void setSelectedStateOfResidence(String s) {
    _selectedStateOfResidence.value = s;
    update();
  }


  final _donationType = 'naira'.obs;
  String get donationType => _donationType.value;
  void setDonationType(String s) {
    _donationType.value = s;
    update();
  }
  var selectedOption = 'onetime'.obs;
  void selectOption(String value) {
    selectedOption.value = value;
  }



  final List<Map<String, String>> gender = [
    // {"label": "Select Gender", "value": "Select"},
    {"label": "Male", "value": "Male"},
    {"label": "Female", "value": "Female"},
  ];

  final List<Map<String, String>> statesOfResidence = [
    // {"label": "Select Residence", "value": "Select"},
    {"label": "Non Nigerian", "value": "Non Nigerian"},
    {"label": "Abia", "value": "Abia"},
    {"label": "Adamawa", "value": "Adamawa"},
    {"label": "Akwa Ibom", "value": "Akwa Ibom"},
    {"label": "Anambra", "value": "Anambra"},
    {"label": "Bauchi", "value": "Bauchi"},
    {"label": "Bayelsa", "value": "Bayelsa"},
    {"label": "Benue", "value": "Benue"},
    {"label": "Borno", "value": "Borno"},
    {"label": "Cross River", "value": "Cross River"},
    {"label": "Delta", "value": "Delta"},
    {"label": "Ebonyi", "value": "Ebonyi"},
    {"label": "Edo", "value": "Edo"},
    {"label": "Ekiti", "value": "Ekiti"},
    {"label": "Enugu", "value": "Enugu"},
    {"label": "FCT", "value": "Federal Capital Territory"},
    {"label": "Gombe", "value": "Gombe"},
    {"label": "Imo", "value": "Imo"},
    {"label": "Jigawa", "value": "Jigawa"},
    {"label": "Kaduna", "value": "Kaduna"},
    {"label": "Kano", "value": "Kano"},
    {"label": "Katsina", "value": "Katsina"},
    {"label": "Kebbi", "value": "Kebbi"},
    {"label": "Kogi", "value": "Kogi"},
    {"label": "Kwara", "value": "Kwara"},
    {"label": "Lagos", "value": "Lagos"},
    {"label": "Nasarawa", "value": "Nasarawa"},
    {"label": "Niger", "value": "Niger"},
    {"label": "Ogun", "value": "Ogun"},
    {"label": "Ondo", "value": "Ondo"},
    {"label": "Osun", "value": "Osun"},
    {"label": "Oyo", "value": "Oyo"},
    {"label": "Plateau", "value": "Plateau"},
    {"label": "Rivers", "value": "Rivers"},
    {"label": "Sokoto", "value": "Sokoto"},
    {"label": "Taraba", "value": "Taraba"},
    {"label": "Yobe", "value": "Yobe"},
    {"label": "Zamfara", "value": "Zamfara"},
  ];


  //
  final _countryName = 'Nigeria'.obs;
  String get countryName => _countryName.value;
  final _countryCode = '+234'.obs;
  String get countryCode => _countryCode.value;
  final _countryFlagUri = 'flags/ng.png'.obs;
  String get countryFlagUri => _countryFlagUri.value;
  void onCountryChanged(CountryCode value) {
    update([
      _countryFlagUri.value = value.flagUri!,
      _countryName.value = value.name!,
      _countryCode.value = value.dialCode!
    ]);
  }
  //


  // Camera variables
  Rx<CameraController?> cameraController = Rx<CameraController?>(null);
  RxBool isCameraInitialized = false.obs;
  RxString imagePath = ''.obs;
  // RxBool isCamersLoading = false.obs;

  Future<void> initializeCamera() async {
    try {
      // setLoad ing(true);

      // Dispose previous camera if exists
      if (cameraController.value != null) {
        await cameraController.value!.dispose();
      }

      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController.value = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await cameraController.value!.initialize();
      isCameraInitialized(true);

    } catch (e) {
      Get.snackbar('Error', 'Camera initialization failed: $e');
      isCameraInitialized(false);
    } finally {
      // setLoading(false);
    }
  }

  Future<void> takePicture() async {

    if (!isCameraInitialized.value || cameraController.value == null) {
      Utils.showTopSnackBar(
          t: "A.S.K KYC",
          m: "Camera not ready",
          tc: AppColors.white,
          d: 3,
          bc: AppColors.askBlue,
          sp: SnackPosition.TOP);
      Utils.showInformationDialog(status: null, title: 'A.S.K KYC', message: "Camera not ready");
      return;
    }


    isCameraInitialized(false);
    try {
      // setLoading(true);
      final XFile file = await cameraController.value!.takePicture();
      imagePath.value = file.path;
    } catch (e) {
      // Get.snackbar('Error', 'Failed to take picture: $e');
      Utils.showTopSnackBar(
          t: "A.S.K KYC",
          m: 'Failed to take picture: $e',
          tc: AppColors.white,
          d: 3,
          bc: AppColors.askBlue,
          sp: SnackPosition.TOP);
    } finally {
      // setLoading(false);
    }
  }




  Future<void> _initializeProfileData() async {

    setLoading(true);
    await getUserProfile();
    await getRequests();
    await getBeneficiaries();
    await getSponsors();
    await getDonations();
    await getBanks();


    // await getUserNotifications();
    // await getUserTransactionsHistory();
    // await getMyBudgets();
    setLoading(false);
  }
  _initializeControllers() {
    emailVerificationController = TextEditingController();


    kycPhoneNumberController = TextEditingController();
    kycAccountNumberController = TextEditingController();
    kycBankNameController = TextEditingController();
    kycGenderController = TextEditingController();
    kycStateOfResidenceController = TextEditingController();


    searchRequestsController = TextEditingController();
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

  String formatNominationCount(String count) {
    final int value = int.tryParse(count) ?? 0;
    return value >= 1000 ? '${(value / 1000).toStringAsFixed(1)}K' : value.toString();
  }

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

  void goToNextItem() {
    if (currentRequestIndex.value < helpRequestsData.length - 1) {
      currentRequestIndex.value++;
      scrollToIndex(currentRequestIndex.value);
    }
  }
  void goToPreviousItem() {
    if (currentRequestIndex.value > 0) {
      currentRequestIndex.value--;
      scrollToIndex(currentRequestIndex.value);
    }
  }
  void scrollToIndex(int index) {
    final double screenWidth = Get.context!.size!.width * .8 + 8;
    singleRequestScrollController.animateTo(
      index * screenWidth,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void filterHelpRequests() {
    final query = searchText.value.toLowerCase().trim();

    if (query.isEmpty) {
      filteredRequestsData.assignAll(helpRequestsData);
    } else {
      filteredRequestsData.assignAll(helpRequestsData.where((request) {
        final userName = request?.user?.fullname?.toLowerCase() ?? '';
        final description = request?.description?.toLowerCase() ?? '';
        return userName.contains(query) || description.contains(query);
      }).toList());
    }

    // Optionally reset scroll to first item
    currentRequestIndex.value = 0;
    scrollToIndex(0);
  }



  @override
  void onInit() {
    _initializeControllers();
    _initializeProfileData();

    // startAutoScroll();
    debounce(searchText, (_) => filterHelpRequests(), time: const Duration(milliseconds: 500));

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {

    cameraController.value?.dispose();
    cameraController.value = null;
    isCameraInitialized.value = false;
    imagePath.value = '';

    super.onClose();
  }

  @override
  void dispose() {
    helpAutoScrollTimer?.cancel();
    helpScrollController.dispose();

    cameraController.value?.dispose();
    cameraController.value = null;
    isCameraInitialized.value = false;
    imagePath.value = '';

    super.dispose();
  }

  void startAutoScroll() {
    helpAutoScrollTimer = Timer.periodic(const Duration(seconds: 7), (timer) {
      if (helpCurrentIndex < helpRequestsData.length - 1) {
        helpCurrentIndex++;
      } else {
        helpCurrentIndex = 0; // Loop back to first item
      }

      // Animate to the next item
      helpScrollController.animateTo(
        helpCurrentIndex * 160.0, // 144 width + 8 margin on each side
        duration: const Duration(milliseconds: 500),
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
        // Utils.showTopSnackBar(
        //     t: "A.S.K Help Requests",
        //     m: "${response.data!.length.toString().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        helpRequestsData.value = response.data!;
        filteredRequestsData.assignAll(helpRequestsData);


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
        // Utils.showTopSnackBar(
        //     t: "A.S.K Beneficiaries",
        //     m: "${response.data!.length.toString().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

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

  getSponsors() async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      SponsorsResponse? response;
      response =
      await SecureService().readSponsors();

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K Sponsors",
        //     m: "${response.data!.length.toString().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        sponsorsData.value = response.data!;


      } else {
        errorMessage.value = "A.S.K Sponsors: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Sponsors",
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
          t: "A.S.K Sponsors: Error",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }

  getDonations() async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      DonationsResponse? response;
      response =
      await SecureService().readDonations();

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K Sponsors",
        //     m: "${response.data!.length.toString().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        donationsData.value = response.data!;


      } else {
        errorMessage.value = "A.S.K Donations: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Donations",
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
          t: "A.S.K Donations: Error",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }

  getBanks() async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      BankCodeResponse? response;
      response =
      await SecureService().readBankCodes();

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K Bank Codes",
        //     m: "${response.data!.length.toString().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        bankCodeData.value = response.data!;


      } else {
        errorMessage.value = "A.S.K Banks: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Bank Codes",
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
          t: "A.S.K Bank Codes: Error",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }


  resendVerificationCode({
    required String email
  }) async {
    setLoading(true);
    //print("loginUser");

    errorMessage.value = "";
    try {
      ResendVerificationCodeResponse? response;
      response =
      await SecureService().resendVerificationCode(
          email: email
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K Resend Verification Code",
        //     m: "${response!.message.toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        Utils.showInformationDialog(status: null, title: 'A.S.K Resend Verification Code', message: "${response!.message.toString()}");



      } else {
        errorMessage.value = "A.S.K Resend Verification Code: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Resend Verification Code",
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
          t: "A.S.K Resend Verification Code: Error",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }

  verifyEmail({
    required String email,
    required String verificationCode,
  }) async {
    setLoading(true);
    //print("loginUser");

    errorMessage.value = "";
    try {
      VerifyEmailResponse? response;
      response =
      await SecureService().verifyEmail(
          email: email,
          verificationCode: verificationCode
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K Verify Email",
        //     m: "${response!.message.toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        // await homeGetUserProfileFromServer();

        Utils.showInformationDialog(status: true, title: 'A.S.K Verify Email', message: "${response!.message.toString()}");

      } else {
        errorMessage.value = "A.S.K Verify Email: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Verify Email",
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
          t: "A.S.K Verify Email: Error",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }

  updateUserKyc({
    required String email,
    required String phoneNumber,
    required String accountNumber,
    required String bankName,
    required String bankCode,
    required String gender,
    required String residence,
    required String imagePath,
  }) async {
    setLoading(true);
    //print("loginUser");

    errorMessage.value = "";
    try {
      StatusMessageResponse? response;
      response =
      await SecureService().updateUserKyc(
          email: email,
        phoneNumber: phoneNumber,
        accountNumber: accountNumber,
        bankName: bankName,
        bankCode: bankCode,
        gender: gender,
        residence: residence,

      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K Update User Kyc",
        //     m: "${response!.message.toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);
        // Utils.showInformationDialog(status: true, title: 'A.S.K Update Kyc', message: "${response!.message.toString()}");
        //
        // await homeGetUserProfileFromServer();

        await updateUserKycSelfie(email: email, imagePath: imagePath);

      } else {
        errorMessage.value = "A.S.K Update Kyc: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Update Kyc",
            m: errorMessage.value, //"${response.message}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.askBlue,
            sp: SnackPosition.TOP);
        Utils.showInformationDialog(status: false, title: 'A.S.K Update Kyc', message: errorMessage.value);

      }



      //clearOtpFields();
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "A.S.K Update Kyc: Error",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
      Utils.showInformationDialog(status: false, title: 'A.S.K Update Kyc: Error', message: "$message");

    }
  }


  updateUserKycSelfie({
    required String email,
    required String imagePath,
  }) async {
    setLoading(true);
    //print("loginUser");

    errorMessage.value = "";
    try {

      // Create File object from path
      File imageFile = File(imagePath);
      String userId = profileData.value!.id!;



      StatusMessageResponse? response;
      response =
      await SecureService().updateUserKycSelfie(
        email: email,
        selfieImage: imageFile,
        userId: userId,
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        Utils.showTopSnackBar(
            t: "A.S.K Update Kyc Selfie",
            m: "${response!.message.toString()}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.askBlue,
            sp: SnackPosition.TOP);
        Utils.showInformationDialog(status: true, title: 'A.S.K Update Kyc Selfie', message: "${response!.message.toString()}");

      } else {
        errorMessage.value = "A.S.K Update Kyc Selfie: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Update Kyc",
            m: errorMessage.value, //"${response.message}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.askBlue,
            sp: SnackPosition.TOP);
        Utils.showInformationDialog(status: false, title: 'A.S.K Update Kyc Selfie', message: errorMessage.value);

      }



      //clearOtpFields();
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "A.S.K Update User Kyc Selfie: Error",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
      Utils.showInformationDialog(status: false, title: 'A.S.K Update Kyc Selfie', message: "$message");

    }
  }



  showBanksDialog() async {
    final searchController = TextEditingController();
    final filteredBanks = RxList<bc.Data?>(bankCodeData.value!.toList());

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          // contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //   "Select Bank",
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w600,
                //     fontFamily: "LatoRegular",
                //     // letterSpacing: .2,
                //     color: AppColors.askText,
                //   ),
                // ),
                // const SizedBox(height: 12),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search Bank",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: "LatoRegular",
                    ),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.askGray),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  onChanged: (value) {
                    filteredBanks.value = bankCodeData.value!
                        .where((bank) => bank!.bankName!
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                        .toList();
                  },
                ),
              ],
            ),
          ),
          content: Container(
            width: double.maxFinite,
            height: ScreenSize.height(context) * .7,
            padding: EdgeInsets.only(bottom: 20),
            child: Obx(() => ListView.separated(
              shrinkWrap: true,
              itemCount: filteredBanks.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8);
              },
              itemBuilder: (BuildContext context, int index) {
                final bank = filteredBanks[index]!;
                return Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: AppColors.askGray, width: 1),
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColors.askSoftTheme
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0,),
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      bank.bankName!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: "LatoRegular",
                      ),
                    ),
                    onTap: () {
                      kycBankNameController.text = bank.bankName!;
                      setSelectedBankName(bank.bankName ?? '');
                      setSelectedBankCode(bank.bankCode ?? '');
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            )),
          ),
        );
      },
    );
  }

  showGenderDialog() async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          // contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: const Text(
            "Select Gender",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: "LatoRegular",
              color: AppColors.askText,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            height: ScreenSize.height(context) * .2,
            padding: EdgeInsets.only(bottom: 20),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: gender.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8);
              },
              itemBuilder: (BuildContext context, int index) {
                final genderItem = gender[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColors.askSoftTheme,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      genderItem["label"]!, // Access the label from the map
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: "LatoRegular",
                      ),
                    ),
                    onTap: () {
                      // Update with your actual controller and selection logic
                      // For example:
                      // genderController.text = genderItem["value"]!;
                      // setSelectedGender(genderItem["value"]!);

                      kycGenderController.text = genderItem["value"]!;
                      setSelectedGender(genderItem["value"]!);

                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  showStateOfResidenceDialog() async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          // contentPadding: EdgeInsets.symmetric(horizontal: 20),
          title: const Text(
            "Select State of Residence",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: "LatoRegular",
              color: AppColors.askText,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            height: ScreenSize.height(context) * .7,
            padding: EdgeInsets.only(bottom: 20),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: statesOfResidence.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8);
              },
              itemBuilder: (BuildContext context, int index) {
                final statesOfResidenceItem = statesOfResidence[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: AppColors.askSoftTheme,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      statesOfResidenceItem["label"]!, // Access the label from the map
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: "LatoRegular",
                      ),
                    ),
                    onTap: () {
                      // Update with your actual controller and selection logic
                      // For example:
                      // genderController.text = genderItem["value"]!;
                      // setSelectedGender(genderItem["value"]!);

                      kycStateOfResidenceController.text = statesOfResidenceItem["value"]!;
                      setSelectedStateOfResidence(statesOfResidenceItem["value"]!);

                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

}
