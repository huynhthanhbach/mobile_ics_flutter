import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsManagementController extends GetxController {
  Future showBottomSheet(BuildContext context, Widget child) async {
    Get.bottomSheet(
      child,
      isScrollControlled: true,
      ignoreSafeArea: true,
      barrierColor: Colors.black26,
    );
  }
}
