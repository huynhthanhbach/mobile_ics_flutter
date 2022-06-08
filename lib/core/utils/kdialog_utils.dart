import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class KDialogUtils {
  KDialogUtils._privateContructer();
  static final KDialogUtils _instance = KDialogUtils._privateContructer();

  factory KDialogUtils() => _instance;

  Future<dynamic> chooseNationList() {
    return Get.dialog(Container());
  }
}
