import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/controllers/home_controller.dart';
import 'package:mobile_ics_flutter/controllers/newsmanagement_controllers/newsmanagement_controller.dart';
import 'package:mobile_ics_flutter/controllers/operator_controllers/operator_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => OperatorController());
    Get.lazyPut(() => NewsManagementController());
  }
}
