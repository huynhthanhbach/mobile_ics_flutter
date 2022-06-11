// ignore_for_file: avoid_print

import 'package:get/get.dart';

class DashboardController extends GetxController {
  late bool checkSize;

  @override
  void onInit() {
    checkSize = false;
    super.onInit();
  }

  void updateCheckSize() {
    if (checkSize) {
      checkSize = false;
    } else {
      checkSize = true;
    }

    update();

    print(checkSize);
  }
}
