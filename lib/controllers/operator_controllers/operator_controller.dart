// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OperatorController extends GetxController {
  late bool flag;
  String? newsSelected;
  String? repeatSelected;
  String? prioritySelected;
  String calenderFilter = '0';
  String timeFilter = '0';
  String categoriesFilter = '0';
  String deviceFilter = '0';
  @override
  void onInit() {
    flag = false;
    super.onInit();
  }

  void pressButton() {
    flag ? flag = false : flag = true;
    print('object');
    update();
  }

  void Select(name, value) {
    switch (name) {
      case 'newsSelected':
        newsSelected = value;
        break;
      case 'repeatSelected':
        repeatSelected = value;
        break;
      case 'prioritySelected':
        prioritySelected = value;
        break;
      default:
    }
    update();
  }

  void Filt(name, value) {
    switch (name) {
      case 'calenderFilter':
        calenderFilter = value;
        break;
      case 'timeFilter':
        timeFilter = value;
        break;
      case 'categoriesFilter':
        categoriesFilter = value;
        break;
      case 'deviceFilter':
        deviceFilter = value;
        break;
      default:
    }
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
