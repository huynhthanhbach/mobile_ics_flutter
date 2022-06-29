// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile_ics_flutter/core/services/boxes_service.dart';
import 'package:mobile_ics_flutter/core/services/hive_news.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';
import 'package:mobile_ics_flutter/models/time_bar_model.dart';

class DashboardController extends GetxController {
  final _dateTimeNow = DateTime.now();
  late String valueTime = 'day ago';
  late String valueLocation = 'Village';

  HiveNews hiveNews = HiveNews();

  String? timeTag;
  String? locationTag;
  List<TimeBarModel> timeBar = [];

  List<NewsHiveModel> listNews = [];

  @override
  void onInit() async {
    List<NewsHiveModel> list = await hiveNews.get();
    if (list.isNotEmpty) {
      listNews = list.toList();
      update(['HISTORY_NEWS']);
    }
    print('News length: ${list.length}');

    if (timeBar.isEmpty) {
      var weekDay = _dateTimeNow.weekday;
      if (weekDay == 7) {
        for (var i = 7; i <= 13; i++) {
          var firstDayOfWeek =
              _dateTimeNow.subtract(Duration(days: weekDay - i));
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
      } else {
        for (var i = 0; i <= 6; i++) {
          var firstDayOfWeek =
              _dateTimeNow.subtract(Duration(days: weekDay - i));
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
      }

      update();
    }

    super.onInit();
  }

  @override
  void onReady() async {
    timeTag = await _changeTime();
    locationTag = await _changeLocation();
    super.onReady();
  }

  Future onRefreshNews() async {
    listNews.clear();
    List<NewsHiveModel> list = await hiveNews.get();
    if (list.isNotEmpty) {
      listNews.addAll(list);
    }
    update(['HISTORY_NEWS']);
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

  // String _getRandomString(int length) {
  //   const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  //   Random rnd = Random();

  //   return String.fromCharCodes(
  //     Iterable.generate(
  //       length,
  //       (_) => chars.codeUnitAt(
  //         rnd.nextInt(chars.length),
  //       ),
  //     ),
  //   );
  // }

  Future onFilter() async {
    print("Location: $valueLocation");
    print("Time: $valueTime");
    timeTag = await _changeTime();
    locationTag = await _changeLocation();

    update();
  }

  @override
  void onClose() async {
    timeBar.clear();
    await BoxesService().closeBox();
    super.onClose();
  }
}
