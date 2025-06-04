import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:ask_mobile/app/data/models/create_help_request/CreateHelpRequestResponse.dart';
import 'package:ask_mobile/global/screen_size.dart';
import 'package:camera/camera.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../global/app_color.dart';
import '../../../../utils/utils.dart';
import '../../../data/models/banks/BankCodeResponse.dart';
import '../../../data/models/beneficiaries/BeneficiariesResponse.dart';
import '../../../data/models/cryptos/CryptosResponse.dart';
import '../../../data/models/dnq/DnqResponse.dart';
import '../../../data/models/donations/DonationsResponse.dart';
import '../../../data/models/login/UserData.dart';
import '../../../data/models/my_requests/MyHelpRequestsResponse.dart';
import '../../../data/models/nominate/NominateResponse.dart';
import '../../../data/models/paystack_subscriptions/PaystackSubscriptionsResponse.dart';
import '../../../data/models/profile/ProfileResponse.dart';
import '../../../data/models/requests/HelpRequestsResponse.dart';
import '../../../data/models/resend_verification/ResendVerificationCodeResponse.dart';
import '../../../data/models/sponsors/SponsorsResponse.dart';
import '../../../data/models/dollar_exchange/DollarExchangeResponse.dart';
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
import '../views/donations_view.dart';
import '../views/iask_view.dart';
import '../views/profile_view.dart';
import '../views/requests_view.dart';

import '../../../data/models/my_requests/RequestData.dart' as mhrd;
import '../../../data/models/requests/Data.dart' as hrd;
import '../../../data/models/beneficiaries/Data.dart' as bd;
import '../../../data/models/sponsors/Data.dart' as sd;
import '../../../data/models/banks/Data.dart' as bc;
import '../../../data/models/donations/Data.dart' as dd;
import '../../../data/models/paystack_subscriptions/PlansData.dart' as psd;
import '../../../data/models/cryptos/Data.dart' as cd;
import '../../../data/models/dollar_exchange/Data.dart' as der;

import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:paystack/paystack.dart';


class HomeController extends GetxController {

  final CachedData _cachedData = CachedData();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   // Make it observable and nullable since it might not be set immediately
//   final selectedHelpRequestId = Rxn<hrd.Data>();
// // Call this when you have the data
//   void setSelectedHelpRequest(hrd.Data request) {
//     selectedHelpRequest.value = request;
//   }


  var showBottomNav = true.obs;
  final _navIndex = 0.obs;
  int get navIndex => _navIndex.value;
  Future<void> handleNavigation(int value) async {
    update([_navIndex.value = value]);
    if (value == 2) {
      //go and get myrequests
    await getMyHelpRequests(email: profileData.value!.emailAddress!);
  }
    // print(value);
  }
  final screens = <Widget>[
    DashboardView(),
    RequestsView(),
    IaskView(),
    DonationsView(),

  ];

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  setLoading(bool? b) {
    _isLoading.value = b!;
    update();
  }

  RxString errorMessage = "".obs;

  Rx<UserData?> profileData = Rx<UserData?>(null);



  Rx<mhrd.RequestData?> myHelpRequestsData = Rx<mhrd.RequestData?>(null);

  RxList<hrd.Data?> helpRequestsData = RxList<hrd.Data?>([]);
  final ScrollController helpScrollController = ScrollController();
  Timer? helpAutoScrollTimer;
  int helpCurrentIndex = 0;

  RxList<bd.Data?> beneficiariesData = RxList<bd.Data?>([]);
  final ScrollController beneficiariesScrollController = ScrollController();
  Timer? beneficiariesAutoScrollTimer;
  int beneficiariesCurrentIndex = 0;
  final bd.Data defaultBeneficiaries = bd.Data.fromJson({
  "id": "1",
  "emailAddress": "ask@askfoundations.org",
  "date": "2025-04-15 12:32:00",
  "amount": "50000",
  "status": "approved",
  "dateResolved": "2025-04-15 12:32:00",
  "nominationCount": "0",
  "remark": "Financial Support",
  "user": {
  "id": "1",
  "fullname": "Ashabi Shobande Kokumo",
  "emailAddress": "ask@askfoundations.org",
  "phone": "08000000001",
  "kycStatus": "verified",
  "accountNumber": "0987654321",
  "accountName": "Ask Shobande",
  "bankName": "A.S.K Bank",
  "gender": "Female",
  "state": "Lagos",
  "profilePicture": "../../../../images/help-requests-images/ask-logox.png",
  "emailVerified": "true",
  "registrationDate": "2025-04-15 12:32:00",
  "userType": "user",
  "eligibility": "true",
  "isCheat": "false",
  "openedWelcomeMsg": "false"
  }
});

  RxList<sd.Data?> sponsorsData = RxList<sd.Data?>([]);
  final ScrollController sponsorsScrollController = ScrollController();
  Timer? sponsorsAutoScrollTimer;
  int sponsorsCurrentIndex = 0;

  RxList<dd.Data?> donationsData = RxList<dd.Data?>([]);
  final ScrollController donationsScrollController = ScrollController();
  List<dd.Data?> filterDonationsByType(List<dd.Data?> donations, String donateType) {
    return donations.where((item) => item!.type == donateType).toList();
  }
  String formatPrice(String price) {
    int numericPrice = int.tryParse(price) ?? 0;
    if (numericPrice >= 1000000) {
      double millions = numericPrice / 1000000;
      return millions % 1 == 0 ? '${millions.toInt()}m' : '${millions.toStringAsFixed(1)}m';
    } else {
      // Format with thousand separators
      return numericPrice.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
            (match) => ',',
      );
    }
  }



  RxList<der.Data?> dollarExchangeData = RxList<der.Data?>([]);

  RxList<cd.Data?> cryptosData = RxList<cd.Data?>([]);
  Rx<cd.Data?> selectedAsset = Rx<cd.Data?>(null);
  late final cd.Data defaultCrypto;


  RxList<psd.PlansData?> paystackSubscriptionsData = RxList<psd.PlansData?>([]);
  final ScrollController paystackSubscriptionsScrollController = ScrollController();
  Map<String, List<psd.PlansData>> groupPlansByInterval(List<psd.PlansData?> plans) {
    final Map<String, List<psd.PlansData>> groupedPlans = {};
    for (var plan in plans) {
      if (plan == null || plan.interval == null) continue;
      final interval = plan.interval!.toLowerCase();
      groupedPlans.putIfAbsent(interval, () => []).add(plan);
    }
    return groupedPlans;
  }





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

  late TextEditingController helpRequestDescriptionController;
  Rx<File?> helpRequestImage = Rx<File?>(null);

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




  Future<void> initializeProfileData() async {

    setLoading(true);
    try {
      // Run all independent requests in parallel
      await Future.wait<void>([
        getUserProfile(),
        getRequests(),
        getBeneficiaries(),
        // getMyHelpRequests(email: profileData.value!.emailAddress!),
        getSponsors(),

        getDonations(),
        getCryptos(),

        getDollarExchange(),
        getPaystackSubscriptions(),
        getBanks(),

      ]);
      getMyHelpRequests(email: profileData.value!.emailAddress!);

      defaultCrypto = cd.Data(
        id: "default",
        network: "Select",
        address: "A.S.K",
        image: "/images/ask-cryptos/ask-logox.png",
      );
      selectedAsset.value = defaultCrypto;




    } catch (e) {
      // Handle errors appropriately
      debugPrint('Error initializing profile data: $e');
      // Consider showing an error to the user
    } finally {
      setLoading(false);
    }
  }
  _initializeControllers() {
    emailVerificationController = TextEditingController();


    kycPhoneNumberController = TextEditingController();
    kycAccountNumberController = TextEditingController();
    kycBankNameController = TextEditingController();
    kycGenderController = TextEditingController();
    kycStateOfResidenceController = TextEditingController();


    searchRequestsController = TextEditingController();


    helpRequestDescriptionController = TextEditingController();
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
  // Future<void> scrollToNewRequest(int requestId) async {
  //   final double screenWidth = Get.context!.size!.width * .8 + 8;
  //   final index = filteredRequestsData.indexWhere((e) => e?.id == requestId);
  //   if (index != -1) {
  //     await Future.delayed(Duration(milliseconds: 300)); // Wait for widget build
  //     singleRequestScrollController.animateTo(
  //       index * screenWidth,
  //       duration: Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }
  Future<void> scrollToNewRequest(int requestId) async {
    try {
      if (Get.context == null) return;

      final double screenWidth = Get.context!.size!.width * .8 + 8;
      final index = filteredRequestsData.indexWhere((e) => e?.id == requestId.toString());

      if (index != -1) {
        await Future.delayed(Duration(milliseconds: 300));

        if (!singleRequestScrollController.hasClients) return;

        final targetPosition = index * screenWidth;
        final maxScrollExtent = singleRequestScrollController.position.maxScrollExtent;

        await singleRequestScrollController.animateTo(
          targetPosition.clamp(0.0, maxScrollExtent),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    } catch (e) {
      // Optional: Add error handling if needed
    }
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
    initializeProfileData();

    _initializeNotifications();

    // startAutoScroll();
    debounce(searchText, (_) => filterHelpRequests(), time: const Duration(milliseconds: 500));

    super.onInit();
  }

  //
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> _initializeNotifications() async {
    // await requestExactAlarmPermission();
    await requestNotificationPermission();
    await initNotifications();
    await testImmediateNotification();
  }
  // Future<void> requestExactAlarmPermission() async {
  //   if (await Permission.scheduleExactAlarm.request().isDenied) {
  //     print("Exact alarm permission is required!");
  //   }
  // }
  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.request().isDenied) {
      print("Notification permission denied!");
    } else {
      print("Notification permission granted!");
    }
  }
  Future<void> initNotifications() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // const AndroidInitializationSettings androidSettings =
    // AndroidInitializationSettings('custom_icon');


    final InitializationSettings initSettings = InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("Notification clicked: ${response.payload}");
      },
    );
  }
  Future<void> testImmediateNotification() async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails('test_channel', 'Test Notifications');

    const NotificationDetails generalNotificationDetails =
    NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'A.S.K Notification',
      'This is a test notification.',
      generalNotificationDetails,
    );
  }
  //


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

      // Get.delete<AuthController>(force: true);
      // Get.delete<HomeController>(force: true);

      // Optional: Force recreate the controller
      // Get.put(AuthController());
      // Get.put(HomeController());

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
          t: "A.S.K Help Requests: Attention",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }

  getMyHelpRequests({
    required String email,
  }) async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      MyHelpRequestsResponse? response;
      response =
      await SecureService().readMyHelpRequests(email: email);

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K My Help Requests",
        //     m: "${response.data!.length.toString().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        myHelpRequestsData.value = response!.requestData;

        helpRequestDescriptionController.text = response!.requestData!.description!;
        helpRequestImage.value = null;


      } else {
        errorMessage.value = "A.S.K My Help Requests: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K My Help Requests",
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
          t: "A.S.K My Help Requests: Attention",
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

        beneficiariesData.value = [defaultBeneficiaries];
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
          t: "A.S.K Beneficiaries: Attention",
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
          t: "A.S.K Sponsors: Attention",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }

  getCryptos() async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      CryptosResponse? response;
      response =
      await SecureService().readCryptos();

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K Cryptos",
        //     m: "${response.data!.length.toString().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        cryptosData.value = response.data!;


      } else {
        errorMessage.value = "A.S.K Crypto Donations: Something wrong happened. Try again";//response.message!;

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
          t: "A.S.K Crypto Donations: Attention",
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
        //     t: "A.S.K Donations",
        //     m: "${response.data!.length.toString().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        donationsData.value = response.data!;
        setDonationType("naira");

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
          t: "A.S.K Donations: Attention",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }

  getDollarExchange() async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      DollarExchangeResponse? response;
      response =
      await SecureService().readDollarExchange();

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K Dollar Exchange",
        //     m: "${response.data!.length.toString().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        dollarExchangeData.value = response.data!;


      } else {
        errorMessage.value = "A.S.K Dollar Exchange: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Dollar Exchange",
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
          t: "A.S.K Dollar Exchange: Attention",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
    }
  }

  getPaystackSubscriptions() async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      PaystackSubscriptionsResponse? response;
      response =
      await SecureService().readPaystackSubscriptions();

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K Paystack Subscriptions",
        //     m: "${response.data!.length.toString().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        paystackSubscriptionsData.value = response.data!.plansData!;


      } else {
        errorMessage.value = "A.S.K Paystack Subscriptions: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Paystack Subscriptions",
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
          t: "A.S.K Paystack Subscriptions: Attention",
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
          t: "A.S.K Bank Codes: Attention",
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
          t: "A.S.K Resend Verification Code: Attention",
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
          t: "A.S.K Verify Email: Attention",
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

        // Utils.showTopSnackBar(
        //     t: "A.S.K Update Kyc",
        //     m: errorMessage.value, //"${response.message}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);
        Utils.showInformationDialog(status: false, title: 'A.S.K Update Kyc', message: errorMessage.value);

      }



      //clearOtpFields();
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      // Utils.showTopSnackBar(
      //     t: "A.S.K Update Kyc: Attention",
      //     m: "$message",
      //     tc: AppColors.black,
      //     d: 3,
      //     bc: AppColors.red,
      //     sp: SnackPosition.TOP);
      Utils.showInformationDialog(status: false, title: 'A.S.K Update Kyc: Attention', message: "$message");

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
        // Utils.showTopSnackBar(
        //     t: "A.S.K Update KYC Selfie",
        //     m: "${response!.message.toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);

        // Level 2 Verification (KYC) Successful!
        // Utils.showInformationDialog(status: true, title: 'A.S.K Update KYC Selfie', message: "${response!.message.toString()}");
        Utils.showInformationDialog(status: true, title: 'A.S.K Update KYC & Selfie', message: "Level 2 Verification (KYC) Successful!");

      } else {
        errorMessage.value = "A.S.K Update KYC Selfie: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Update Kyc",
            m: errorMessage.value, //"${response.message}",
            tc: AppColors.white,
            d: 3,
            bc: AppColors.askBlue,
            sp: SnackPosition.TOP);
        Utils.showInformationDialog(status: false, title: 'A.S.K Update KYC Selfie', message: errorMessage.value);

      }



      //clearOtpFields();
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "A.S.K Update User KYC Selfie: Attention",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
      Utils.showInformationDialog(status: false, title: 'A.S.K Update KYC Selfie', message: "$message");

    }
  }

  createHelpRequest({
    required String email,
    required String description,
    required String fullname,
    required File image,
  }) async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      CreateHelpRequestResponse? response;
      response =
      await SecureService().createHelpRequest(
          email: email,
          description: description,
          fullname: fullname,
          image: image
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // showTopSnackBar(
        //     t: "A.S.K Create Help Request",
        //     m: "${response!.toJson().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.gold,
        //     sp: SnackPosition.TOP);

        helpRequestDescriptionController.clear();
        helpRequestImage.value = null;

        Utils.showInformationDialog(status: true,
            title: 'A.S.K Help Request',
            message: "${response!.message}",
            meta: response!.id
        );







      } else {
        errorMessage.value = "A.S.K Create Help Request: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Create Help Request",
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
      // Utils.showTopSnackBar(
      //     t: "A.S.K Create Help Request: Attention",
      //     m: "$message",
      //     tc: AppColors.black,
      //     d: 3,
      //     bc: AppColors.red,
      //     sp: SnackPosition.TOP);

      await initializeProfileData();

      Utils.showInformationDialog(status: false,
          title: 'A.S.K Create Help Request: Attention',
          message: "$message");
    }
  }

  updateHelpRequestImage({
    required String email,
    required File image,
  }) async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      CreateHelpRequestResponse? response;
      response =
      await SecureService().updateHelpRequestImage(
          email: email,
          image: image
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // showTopSnackBar(
        //     t: "A.S.K Create Help Request",
        //     m: "${response!.toJson().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.gold,
        //     sp: SnackPosition.TOP);

        // helpRequestDescriptionController.clear();
        // helpRequestImage.value = null;

        Utils.showInformationDialog(status: true,
            title: 'A.S.K Update Help Request Image',
            message: "${response!.message}",
            // meta: response!.id
        );







      } else {
        errorMessage.value = "A.S.K Update Help Request Image: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Update Help Request Image",
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
      // Utils.showTopSnackBar(
      //     t: "A.S.K Update Help Request: Attention",
      //     m: "$message",
      //     tc: AppColors.black,
      //     d: 3,
      //     bc: AppColors.red,
      //     sp: SnackPosition.TOP);
      Utils.showInformationDialog(status: false,
          title: 'A.S.K Update Help Request Image: Attention',
          message: "$message");
    }
  }

  updateHelpRequest({
    required String email,
    required String description,
    required String helpToken
  }) async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      CreateHelpRequestResponse? response;
      response =
      await SecureService().updateHelpRequest(
          email: email,
          description: description,
          helpToken: helpToken
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // showTopSnackBar(
        //     t: "A.S.K Update Help Request",
        //     m: "${response!.toJson().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.gold,
        //     sp: SnackPosition.TOP);
        //
        // helpRequestDescriptionController.clear();
        // helpRequestImage.value = null;

        Utils.showInformationDialog(status: true,
            title: 'A.S.K Update Help Request',
            message: "${response!.message}",
            meta: response!.id
        );







      } else {
        errorMessage.value = "A.S.K Update Help Request: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Update Help Request",
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
      // Utils.showTopSnackBar(
      //     t: "A.S.K Update Help Request: Attention",
      //     m: "$message",
      //     tc: AppColors.black,
      //     d: 3,
      //     bc: AppColors.red,
      //     sp: SnackPosition.TOP);
      Utils.showInformationDialog(status: false,
          title: 'A.S.K Update Help Request: Attention',
          message: "$message");
    }
  }


  deleteHelpRequest({
    required String email,
    required String helpToken
  }) async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      CreateHelpRequestResponse? response;
      response =
      await SecureService().deleteHelpRequest(
          email: email,
          helpToken: helpToken
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // showTopSnackBar(
        //     t: "A.S.K Delete Help Request",
        //     m: "${response!.toJson().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.gold,
        //     sp: SnackPosition.TOP);


        Utils.showInformationDialog(status: true,
            title: 'A.S.K Delete Help Request',
            message: "${response!.message}",
            meta: response!.id
        );







      } else {
        errorMessage.value = "A.S.K Delete Help Request: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Delete Help Request",
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
      // Utils.showTopSnackBar(
      //     t: "A.S.K Create Help Request: Attention",
      //     m: "$message",
      //     tc: AppColors.black,
      //     d: 3,
      //     bc: AppColors.red,
      //     sp: SnackPosition.TOP);
      Utils.showInformationDialog(status: false,
          title: 'A.S.K Delete Help Request: Attention',
          message: "$message");
    }
  }

  handleNominate({
    required String email,
    required String helpToken,
    required String fingerPrint
  }) async {
    setLoading(true);
    //print("registerUser");

    errorMessage.value = "";
    try {
      NominateResponse? response;
      response =
      await SecureService().handleNominate(
          email: email,
          helpToken: helpToken,
          fingerPrint: fingerPrint
      );

      print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // showTopSnackBar(
        //     t: "A.S.K Create Help Request",
        //     m: "${response!.toJson().toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.gold,
        //     sp: SnackPosition.TOP);

        await initializeProfileData();

        Utils.showInformationDialog(status: true,
            title: 'A.S.K Nominate',
            message: "${response!.message!.toUpperCase()}# Increase your influence to decide beneficiary by boosting your DNQ.",
            // meta: response!.id
        );





      } else {
        errorMessage.value = "A.S.K Nominate: Something wrong happened. Try again";//response.message!;

        Utils.showTopSnackBar(
            t: "A.S.K Nominate",
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
      // Utils.showTopSnackBar(
      //     t: "A.S.K Create Help Request: Attention",
      //     m: "$message",
      //     tc: AppColors.black,
      //     d: 3,
      //     bc: AppColors.red,
      //     sp: SnackPosition.TOP);
      Utils.showInformationDialog(status: false,
          title: 'A.S.K Nominate: Attention',
          message: "$message");
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



  String generateTimestampedReference() {
    // Get the current timestamp in milliseconds
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    // Generate a random alphanumeric string
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();
    String randomString = String.fromCharCodes(Iterable.generate(
        4, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    // Combine the timestamp and the random string
    return '$timestamp$randomString';
  }
  Future<void> makePaymentToFundAccount({
    required BuildContext context,
    required num toPay,
    required String currency,

    required bool isSubscription,

    String? planName,
    String? planCode,
    String? interval,
    String? email,
  }
      ) async {

    String secretKey = 'sk_test_0e36f2a36881d8953d673c3e41b465569b105f0b';

    final client = PaystackClient(secretKey: secretKey);

    setLoading(true);
    final uniqueTransRef =  generateTimestampedReference();
    String email = profileData.value!.emailAddress!;

    num priceToPay = toPay;
    if (currency == "DOL") {
      priceToPay = num.parse(dollarExchangeData.value[0]!.rate!) * toPay;
    }

    bool isAlreadySubscribed = false;
    if (isSubscription) {
      try {
        final response = await client.subscriptions.all(
            customer: email,
            plan: planCode
        );

        if (response.data.length > 0) {
          // return response.data['data']; // List of subscriptions
          isAlreadySubscribed = true;
        } else {
          throw Exception('Failed to fetch subscriptions: ');
        }
      } catch (e) {
        throw Exception('Error fetching subscriptions: $e');
      }

    }







    // print("#1");
    try {

      if (isAlreadySubscribed == false)
      {
        PayWithPayStack().now(
            context: context,
            secretKey: secretKey,
            customerEmail: email,
            reference: uniqueTransRef,
            callbackUrl: "https://google.com",
            currency: "NGN",
            paymentChannel:["mobile_money", "card"],
            amount: double.parse(priceToPay.toString()),
            transactionCompleted: (paymentData) async {
              setLoading(false);

              print("Transaction Successful: " + paymentData.toJson().toString());
              // Get.back();

              // Navigator.of(context).pop();


              // showAnimatedTopupDialog(status: "Success", message: "");

              // setLoading(true);
              // await homeCtrl.getUserProfile();
              // setLoading(false);

              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   Utils.showInformationDialog(
              //       status: true, title: "Success", message: "Transaction Successful");
              //
              //   // showAnimatedTopupDialog(
              //   //     status: "Success",
              //   //     message: "",
              //   //     context: context
              //   // );
              // });

              if (isSubscription) {
                //hit subscribe endpoint with authtoken
                final authCode = paymentData.authorization!.authorizationCode;
                if (authCode == null) {
                  throw Exception('Authorization code not found in payment data');
                }
                // 5. Create subscription with the authorization code
                final subscriptionResponse = await client.subscriptions.create(
                  email,
                  planCode!,
                  authCode,
                  startDate: DateTime.now().toIso8601String(),
                );

                if (!subscriptionResponse.data['status']) {
                  Utils.showInformationDialog(status: false, title: 'THANK YOU FOR YOUR DONATION !',
                      message: 'Subscription creation failed!: ${subscriptionResponse.data['message']}'

                  );
                  throw Exception('Subscription creation failed: ${subscriptionResponse.data['message']}');
                }

                Utils.showInformationDialog(status: true, title: 'THANK YOU FOR YOUR DONATION !',
                    message: 'Subscription activated successfully!'

                );
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('Subscription activated successfully!')),
                // );


              } else {

                if (currency == "NGN") {
                  await incrementDNQ(email: email, price: toPay.toString(), type: "naira", reference: uniqueTransRef);
                } else {
                  await incrementDNQ(email: email, price: toPay.toString(), type: "dollar", reference: uniqueTransRef);
                }
              }






            },
            transactionNotCompleted: (reason) async {
              setLoading(false);
              print("Transaction Not Successful!" + reason.toString());
              // Get.back();


              // Close the current screen or take user to an error page
              // Navigator.of(context).pop();
              // showAnimatedTopupDialog(status: "Failed", message: "");

              // setLoading(true);
              // await homeCtrl.getUserProfile();
              // setLoading(false);

              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   showAnimatedTopupDialog(
              //       status: "Failed",
              //       message: "",
              //       context: context
              //   );
              // });

            });
      } else {
        Utils.showInformationDialog(status: null, title: 'Oops !',
            message: 'You are already subscribed to this plan.'

        );
      }

      // print("#2");

      setLoading(false);

    } catch (e) {
      // print("#3");
      setLoading(false);
      print("Error during payment: $e"); // Log the error for debugging

      Utils.showTopSnackBar(
        t: "Payment Error",
        m: "An error occurred during payment!",
        tc: AppColors.white,
        d: 3,
        bc: AppColors.red,
        sp: SnackPosition.TOP,
      );
    }
  }



  incrementDNQ({
    required String email,
    required String price,
    required String type,
    required String reference,
  }) async {
    setLoading(true);
    //print("loginUser");

    errorMessage.value = "";
    try {




      DnqResponse? response;
      response =
      await SecureService().incrementDNQ(
        email: email,
        price: price,
        type: type,
        reference: reference,
      );

      // print(response!.toJson().toString());
      //
      setLoading(false);
      if (response!.status == true) {
        // Utils.showTopSnackBar(
        //     t: "A.S.K incrementDNQ",
        //     m: "${response!.message.toString()}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);
        Utils.showInformationDialog(status: true, title: 'THANK YOU FOR YOUR DONATION !', message: "${response!.message.toString()}"
            + ", DNQ: " + response.dnq!.toString()
            + ", NewDNQ: " + response.newVoteWeight!.toString()
        );

      } else {
        errorMessage.value = "A.S.K Donation DNQ: Something wrong happened. Try again";//response.message!;

        // Utils.showTopSnackBar(
        //     t: "A.S.K incrementDNQ",
        //     m: errorMessage.value, //"${response.message}",
        //     tc: AppColors.white,
        //     d: 3,
        //     bc: AppColors.askBlue,
        //     sp: SnackPosition.TOP);
        Utils.showInformationDialog(status: false, title: 'A.S.K Donation DNQ', message: errorMessage.value);

      }



      //clearOtpFields();
    } on DioException catch (e) {
      setLoading(false);
      //print(e.toString());
      final message = DioExceptions.fromDioError(e).toString();
      //
      Utils.showTopSnackBar(
          t: "A.S.K incrementDNQ: Attention",
          m: "$message",
          tc: AppColors.black,
          d: 3,
          bc: AppColors.red,
          sp: SnackPosition.TOP);
      Utils.showInformationDialog(status: false, title: 'A.S.K incrementDNQ', message: "$message");

    }
  }

}
