import 'package:dnn_core/all_exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class NavigationTabs {
  static const int home = 0;
  static const int helpers = 1;
  static const int login = 2;

  static const int meusPlanos = 2;
  static const int profile = 3;
  static const int sellUncompleted = 1;
  static const int comissions = 2;
  static const int sellCompleted = 3;
  static const int partnerProfile = 4;

  static const int myAppointmentsLogged = 0;
  static const int homeLogged = 1;
  static const int myPlansLogged = 2;
}

class NavigationController extends GetxController {
  late PageController _pageController;
  late RxInt _currentIndex;

  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex.value;
  late AnimationController animationController;

  RxBool isUserLogged = false.obs;
  RxBool isSidebarOpen = false.obs;

  bool get isLogged => isUserLogged.value;

  @override
  void onInit() {
    super.onInit();
    _initNavigation(
      pageController: PageController(initialPage: NavigationTabs.home),
      currentIndex: NavigationTabs.home,
    );
  }

  void setIndex(int value) {
    _currentIndex = value.obs;
    update();
  }

  void setIsUserLogged(bool state) {
    isUserLogged.value = state;
    update();
  }

  void setAnimationController(AnimationController ctrl) {
    animationController = ctrl;
  }

  void _initNavigation(
      {required PageController pageController, required int currentIndex}) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
    update();
  }

  void navigatePageView(int page) {
    if (_currentIndex.value == page) return;
    _pageController.jumpToPage(page);
    _currentIndex.value = page;
    update();
  }

  Future<void> getUserLogged() async {
    try {
      if (await storage.getToken() != null) {
        setIsUserLogged(true);
        if (isUserLogged.value == true) {
          navigatePageView(NavigationTabs.homeLogged);
        }
      } else {
        setIsUserLogged(false);
        navigatePageView(NavigationTabs.home);
      }
    } catch (e) {
      setIsUserLogged(false);
    } finally {
      update();
    }
  }

  void closeMenu() {
    if (Get.currentRoute == Routes.basePage) {
      if (animationController.value == 0) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      isSidebarOpen.value = !isSidebarOpen.value;
      update();
    }
  }

  void updateDrawerBar(bool value) {
    isSidebarOpen.value = value;
    update();
  }
}
