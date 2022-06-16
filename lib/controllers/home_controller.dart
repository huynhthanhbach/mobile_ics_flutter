import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/core/widgets/kcolors.dart';
import 'package:mobile_ics_flutter/views/dashboard/dashboard_screen.dart';
import 'package:mobile_ics_flutter/views/news_management/news_management_screen.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../views/operator/operator_pages/operator_screen.dart';

class HomeController extends GetxController {
  late PersistentTabController tabController;

  @override
  void onInit() {
    tabController = PersistentTabController(initialIndex: 0);
    super.onInit();
  }

  void changeIndex(int index) {
    if (tabController.index != index) {
      tabController.index = index;
      update();
    }
  }

  List<PersistentBottomNavBarItem> navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.folder_copy_rounded),
        title: 'Quản lý bản tin',
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        activeColorPrimary: kGradientFirst,
        inactiveColorPrimary: kGradientSecond,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.newspaper_rounded),
        title: 'Điều hành phát',
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        activeColorPrimary: kGradientFirst,
        inactiveColorPrimary: kGradientSecond,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.dashboard_rounded),
        title: 'Dashboard',
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        activeColorPrimary: kGradientFirst,
        inactiveColorPrimary: kGradientSecond,
      ),
    ];
  }

  List<Widget> buildPages() {
    return const [
      NewsManagementScreen(),
      OperatorScreen(),
      DashboardScreen(),
    ];
  }
}
