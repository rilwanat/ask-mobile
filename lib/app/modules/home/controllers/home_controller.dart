import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/dashboard_view.dart';
import '../views/iask_view.dart';
import '../views/profile_view.dart';
import '../views/requests_view.dart';

class HomeController extends GetxController {

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

  Future<void> _initializeProfileData() async {
    setLoading(true);
    // await getUserProfile();
    // await getUserNotifications();
    // await getUserTransactionsHistory();
    // await getContacts();
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


  @override
  void onInit() {
    _initializeControllers();
    _initializeProfileData();

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
