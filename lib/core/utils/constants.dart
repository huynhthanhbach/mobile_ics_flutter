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
                topLeft: Radius.circular(dkp), topRight: Radius.circular(dkp))),
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

  //default padding
  static const double dkp = 20.0;
  const Constants._();

  //default font weight
  static const FontWeight kExtraLight = FontWeight.w100;
  static const FontWeight kLight = FontWeight.w300;
  static const FontWeight kRegular = FontWeight.w400;
  static const FontWeight kSemiBold = FontWeight.w600;
  static const FontWeight kBold = FontWeight.w700;
  static const FontWeight kBlack = FontWeight.w900;
}
