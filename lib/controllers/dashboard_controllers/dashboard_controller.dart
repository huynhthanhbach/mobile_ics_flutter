// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/models/time_bar_model.dart';

class DashboardController extends GetxController {
  final _dateTimeNow = DateTime.now();
  List<TimeBarModel> timeBar = [];

  late bool checkSize;
  String valueTime = '1';

  @override
  void onInit() {
    if (timeBar.isEmpty) {
      var weekDay = _dateTimeNow.weekday;
      for (var i = 0; i <= 6; i++) {
        var firstDayOfWeek = _dateTimeNow.subtract(Duration(days: weekDay - i));
        var changeDateToString = Jiffy(firstDayOfWeek).format("EEE");
        final timeBarModel = TimeBarModel(
          text: changeDateToString,
          num: firstDayOfWeek.day.toString(),
        );
        if (firstDayOfWeek.day == _dateTimeNow.day) {
          timeBarModel.now = true;
        }
        timeBar.add(timeBarModel);
      }
      update();
    }

    checkSize = false;

    super.onInit();
  }

  Future showBottomSheet(BuildContext context, Widget child) async {
    Get.bottomSheet(
      child,
      isScrollControlled: true,
      ignoreSafeArea: true,
      barrierColor: Colors.black26,
      exitBottomSheetDuration: Constants.dur300,
      enterBottomSheetDuration: Constants.dur300,
    );
  }

  void updateCheckSize() {
    if (checkSize) {
      checkSize = false;
    } else {
      checkSize = true;
    }

    update();

    print(checkSize);
    print(valueTime);
  }
}
