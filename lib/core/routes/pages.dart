import 'package:flutter/animation.dart';

import 'package:get/get.dart';
import 'package:mobile_ics_flutter/views/home/home_screen.dart';

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
  ];
}
