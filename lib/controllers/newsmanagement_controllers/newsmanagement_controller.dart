import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsManagementController extends GetxController {
  bool isFbVisible = false;

  @override
  void onInit() {
    
  }

  void updateIsFbVisible(bool check) {
    isFbVisible = check;
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
