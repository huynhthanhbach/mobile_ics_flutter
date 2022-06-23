// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/models/time_bar_model.dart';

class DashboardController extends GetxController {
  final _dateTimeNow = DateTime.now();
  late String valueTime = 'day ago';
  late String valueLocation = 'Village';

  String? timeTag;
  String? locationTag;
  List<TimeBarModel> timeBar = [];

  @override
  void onInit() async {
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

    timeTag = await _changeTime();
    locationTag = await _changeLocation();

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

  void onChangeTime(String value) {
    valueTime = value;
  }

  void onChangeLocation(String value) {
    valueLocation = value;
  }

  Future<String> _changeLocation() async {
    switch (valueLocation) {
      case 'District':
        return 'Cấp Huyện';
      default:
        return 'Cấp Xã';
    }
  }

  Future<String> _changeTime() async {
    switch (valueTime) {
      case 'week ago':
        return 'Một tuần trước';
      case 'month ago':
        return 'Một tháng trước';
      case 'year ago':
        return 'Một năm trước';
      default:
        return 'Một ngày trước';
    }
  }

  Future filterData() async {
    print("Location: $valueLocation");
    print("Time: $valueTime");
    timeTag = await _changeTime();
    locationTag = await _changeLocation();

    update();

    // loc da ta o day
  }
}
