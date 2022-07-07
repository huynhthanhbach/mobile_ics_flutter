export 'app_const.dart';
export 'extension.dart';
export 'kdialog_utils.dart';

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants {
  static const Color splashPageBgc = Color(0xF21C2F54);

  // 主题颜色
  static const Color defaultColor = Color(0xFFFE5767);

  // 浅色主题颜色
  static const Color defaultLightColor = Color(0xFFFFABB8);

  static final MediaQueryData mediaQueryData =
      MediaQueryData.fromWindow(window);

  static final Size screenSize = mediaQueryData.size;

  static final double screenWidth = screenSize.width;

  static final double screenHeight = screenSize.height;

  static const Duration dur100 = Duration(milliseconds: 100);
  static const Duration dur200 = Duration(milliseconds: 200);
  static const Duration dur300 = Duration(milliseconds: 300);
  static const Duration dur400 = Duration(milliseconds: 400);
  static const Duration dur500 = Duration(milliseconds: 500);
  static const Duration dur600 = Duration(milliseconds: 600);
  static const Duration dur700 = Duration(milliseconds: 700);
  static const Duration dur800 = Duration(milliseconds: 800);
  static const Duration dur900 = Duration(milliseconds: 900);
  static const Duration dur1000 = Duration(milliseconds: 1000);

  static Widget boxPadding({double width = 0, double height = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static bool isMobile() {
    bool kisweb;
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        kisweb = false;
      } else {
        kisweb = true;
      }
    } catch (e) {
      kisweb = true;
    }
    return !kisweb;
  }

  static BuildContext? buildContext;

  static void hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(buildContext!);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  static Future<dynamic> showModel(
    Widget child, {
    double? height,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    EdgeInsetsGeometry? padding,
  }) {
    return Get.bottomSheet(
      Container(
        height: height ?? Get.mediaQuery.size.height / 2,
        padding: padding,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(padding20),
                topRight: Radius.circular(padding20))),
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            boxPadding(height: 5),
            Center(
              child: Container(
                  height: 3,
                  width: 25,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(5))),
            ),
            boxPadding(height: 5),
            Expanded(child: child),
          ],
        ),
      ),
      barrierColor: Colors.black26,
      ignoreSafeArea: true,
      isScrollControlled: true,
    );
  }

  //default SizedBox
  static const SizedBox sizedBoxH5 = SizedBox(height: 5);
  static const SizedBox sizedBoxH10 = SizedBox(height: 10);
  static const SizedBox sizedBoxH15 = SizedBox(height: 15);
  static const SizedBox sizedBoxH20 = SizedBox(height: 20);
  static const SizedBox sizedBoxH25 = SizedBox(height: 25);
  static const SizedBox sizedBoxH30 = SizedBox(height: 30);

  //default padding
  static const double padding5 = 5.0;
  static const double padding10 = 10.0;
  static const double padding15 = 15.0;
  static const double padding20 = 20.0;
  static const double padding25 = 25.0;
  static const double padding30 = 30.0;
  static const double padding35 = 35.0;

  //default radius
  static const Radius radCir5 = Radius.circular(5);
  static const Radius radCir10 = Radius.circular(10);
  static const Radius radCir15 = Radius.circular(15);
  static const Radius radCir20 = Radius.circular(20);
  static const Radius radCir25 = Radius.circular(25);
  static const Radius radCir30 = Radius.circular(30);
  static const Radius radCir35 = Radius.circular(35);
  static const Radius radCir40 = Radius.circular(40);

  //default border radius
  static BorderRadius borRadCir5 = BorderRadius.circular(5);
  static BorderRadius borRadCir10 = BorderRadius.circular(10);
  static BorderRadius borRadCir15 = BorderRadius.circular(15);
  static BorderRadius borRadCir20 = BorderRadius.circular(20);
  static BorderRadius borRadCir25 = BorderRadius.circular(25);
  static BorderRadius borRadCir30 = BorderRadius.circular(30);
  static BorderRadius borRadCir35 = BorderRadius.circular(35);
  static BorderRadius borRadCir40 = BorderRadius.circular(40);

  const Constants._();
}
