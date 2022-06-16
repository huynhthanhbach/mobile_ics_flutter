import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OperatorController extends GetxController {
  late bool flag;

  @override
  void onInit() {
    flag = false;
    super.onInit();
  }

  void pressButton() {
    flag ? flag = false : flag = true;
    // ignore: avoid_print
    print('object');
    update();
  }

  Future showBottomSheet(BuildContext context, Widget child) async {
    Get.bottomSheet(
      child,
      isScrollControlled: true,
      ignoreSafeArea: true,
      barrierColor: Colors.black26,
    );
  }
}
