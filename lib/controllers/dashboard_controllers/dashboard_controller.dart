// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile_ics_flutter/controllers/home_controller.dart';
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

  var timeTag = ''.obs;
  var locationTag = ''.obs;

  RxList<TimeBarModel> timeBar = <TimeBarModel>[].obs;
  RxList<NewsHiveModel> listNews = <NewsHiveModel>[].obs;

  @override
  void onInit() async {
    List<NewsHiveModel> list = await hiveNews.get();
    if (list.isNotEmpty) {
      listNews.value = list.toList();
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
    }
    print(timeBar);

    super.onInit();
  }

  @override
  void onReady() {
    timeTag.value = _changeTime();
    locationTag.value = _changeLocation();
    super.onReady();
  }

  Future onRefreshNews() async {
    List<NewsHiveModel> list = await hiveNews.get();
    if (list.isNotEmpty) {
      listNews.value = list.toList();
    }
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

  void changIndexPage(int index) {
    Get.find<HomeController>().changeIndex(index);
  }

  String _changeLocation() {
    switch (valueLocation) {
      case 'District':
        return 'FILTER_AREA_DISTRICT'.tr;
      default:
        return 'FILTER_AREA_VILLAGE'.tr;
    }
  }

  String _changeTime() {
    switch (valueTime) {
      case 'week ago':
        return 'FILTER_TIME_WEEK'.tr;
      case 'month ago':
        return 'FILTER_TIME_MONTH'.tr;
      case 'year ago':
        return 'FILTER_TIME_YEAR'.tr;
      default:
        return 'FILTER_TIME_DAY'.tr;
    }
  }

  Future onFilter() async {
    print("Location: $valueLocation");
    print("Time: $valueTime");
    timeTag.value = _changeTime();
    locationTag.value = _changeLocation();
  }

  @override
  void onClose() async {
    timeBar.clear();
    await BoxesService().closeBox();
    super.onClose();
  }
}
