import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/home_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
