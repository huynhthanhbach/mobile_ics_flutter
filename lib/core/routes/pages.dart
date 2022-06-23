import 'package:flutter/animation.dart';

import 'package:get/get.dart';
import 'package:mobile_ics_flutter/views/dashboard/dashboard_screen.dart';
import 'package:mobile_ics_flutter/views/home/home_screen.dart';
import 'package:mobile_ics_flutter/views/operator/operator_screen.dart';

part 'routes.dart';

// ignore: avoid_classes_with_only_static_members
class Pages {
  // ignore: constant_identifier_names
  static const initial = Routes.home;
  static const _timeAnimation = Duration(milliseconds: 700);
  static final routes = [
    GetPage(
        name: Routes.home,
        page: () => const HomeScreen(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
        transitionDuration: _timeAnimation),
    GetPage(
        name: Routes.dashboard,
        page: () => const DashboardScreen(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
        transitionDuration: _timeAnimation),
    GetPage(
        name: Routes.operator,
        page: () => const OperatorScreen(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
        transitionDuration: _timeAnimation),
  ];
}
