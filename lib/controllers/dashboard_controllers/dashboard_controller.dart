// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile_ics_flutter/controllers/home_controller.dart';
import 'package:mobile_ics_flutter/core/services/boxes_service.dart';
import 'package:mobile_ics_flutter/core/services/hive_bandwidth.dart';
import 'package:mobile_ics_flutter/core/services/hive_calendar.dart';
import 'package:mobile_ics_flutter/core/services/hive_device.dart';
import 'package:mobile_ics_flutter/core/services/hive_news.dart';
import 'package:mobile_ics_flutter/core/services/hive_play_news.dart';
import 'package:mobile_ics_flutter/core/services/hive_warning.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';
import 'package:mobile_ics_flutter/models/time_bar_model.dart';

class DashboardController extends GetxController {
  final _dateTimeNow = DateTime.now();
  late String valueTime = 'day ago';
  late String valueLocation = 'Village';

  String? areaFilter;

  HiveNews hiveNews = HiveNews();
  HiveWarning hiveWarning = HiveWarning();
  HiveDevice hiveDevice = HiveDevice();
  HiveBandwidth hiveBandwidth = HiveBandwidth();
  HiveCalendar hiveCalendar = HiveCalendar();
  HivePlayNews hivePlayNews = HivePlayNews();

  var timeTag = ''.obs;
  var locationTag = ''.obs;

  RxList<TimeBarModel> timeBar = <TimeBarModel>[].obs;

  RxList<NewsHiveModel> listNews = <NewsHiveModel>[].obs;
  RxList<WarningHiveModel> listWarning = <WarningHiveModel>[].obs;
  RxList<DeviceHiveModel> listDevice = <DeviceHiveModel>[].obs;
  RxList<BandwidthHiveModel> listBandwidth = <BandwidthHiveModel>[].obs;
  RxList<CalendarHiveModel> listCalendar = <CalendarHiveModel>[].obs;
  RxList<PlayNewsHiveModel> listPlayNews = <PlayNewsHiveModel>[].obs;

  RxList<NewsHiveModel> listHisNews = <NewsHiveModel>[].obs;
  RxList<WarningHiveModel> listHisWarning = <WarningHiveModel>[].obs;

  @override
  void onInit() async {
    areaFilter = _changeArea();
    List<NewsHiveModel> list = await hiveNews.get();
    if (list.isNotEmpty) {
      listNews.value = list.toList();
    }
    print('News length: ${list.length}');

    List<WarningHiveModel> listW = await hiveWarning.get();
    if (listW.isNotEmpty) {
      listWarning.value = listW.toList();
    }
    print('Warning length: ${listW.length}');

    List<DeviceHiveModel> listD = await hiveDevice.get();
    if (listD.isNotEmpty) {
      listDevice.value = listD.toList();
    }
    print('Device length: ${listD.length}');

    List<BandwidthHiveModel> listB = await hiveBandwidth.get();
    if (listB.isNotEmpty) {
      listBandwidth.value = listB.toList();
    }
    print('Bandwidth length: ${listB.length}');

    List<CalendarHiveModel> listC = await hiveCalendar.get();
    if (listC.isNotEmpty) {
      listCalendar.value = listC.toList();
    }
    print('Calendar length: ${listC.length}');

    List<PlayNewsHiveModel> listP = await hivePlayNews.get();
    if (listP.isNotEmpty) {
      listPlayNews.value = listP.toList();
    }
    print('PlayNews length: ${listP.length}');

    if (timeBar.isEmpty) {
      var weekDay = _dateTimeNow.weekday;
      if (weekDay == 7) {
        for (var i = 7; i <= 13; i++) {
          var firstDayOfWeek =
              _dateTimeNow.subtract(Duration(days: weekDay - i));

          var changeDateToString = Jiffy(firstDayOfWeek).format("EEE");
          var changeMonthToString = Jiffy(firstDayOfWeek).format("MMM");
          final timeBarModel = TimeBarModel(
            date: changeDateToString,
            day: firstDayOfWeek.day.toString(),
            month: changeMonthToString,
            year: firstDayOfWeek.year.toString(),
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
          var changeMonthToString = Jiffy(firstDayOfWeek).format("MMM");
          final timeBarModel = TimeBarModel(
            date: changeDateToString,
            day: firstDayOfWeek.day.toString(),
            month: changeMonthToString,
            year: firstDayOfWeek.year.toString(),
          );
          if (firstDayOfWeek.day == _dateTimeNow.day) {
            timeBarModel.now = true;
          }
          timeBar.add(timeBarModel);
        }
      }
    }

    super.onInit();
  }

  @override
  void onReady() {
    timeTag.value = _changeTime();
    locationTag.value = _changeLocation();

    if (listNews.isNotEmpty) {
      List<NewsHiveModel> listNewsFilterArea = [];
      for (var news in listNews) {
        if (news.area == areaFilter && news.status == 'Đã phát') {
          listNewsFilterArea.add(news);
        }
      }

      listNewsFilterArea.sort((a, b) {
        return b.createDate!.compareTo(a.createDate!);
      });

      listHisNews.value = listNewsFilterArea.toList();
    }

    if (listWarning.isNotEmpty) {
      List<WarningHiveModel> listWarningFilterArea = [];
      for (var warning in listWarning) {
        if (warning.area == areaFilter && warning.status == 'Đã xử lý') {
          listWarningFilterArea.add(warning);
        }
      }

      listWarningFilterArea.sort((a, b) {
        return b.createDate!.compareTo(a.createDate!);
      });

      listHisWarning.value = listWarningFilterArea.toList();
    }

    super.onReady();
  }

  Future onRefresh() async {
    List<NewsHiveModel> list = await hiveNews.get();
    if (list.isNotEmpty) {
      listNews.value = list.toList();
    }

    List<CalendarHiveModel> listC = await hiveCalendar.get();
    if (listC.isNotEmpty) {
      listCalendar.value = listC.toList();
    }

    List<DeviceHiveModel> listD = await hiveDevice.get();
    if (listD.isNotEmpty) {
      listDevice.value = listD.toList();
    }

    List<WarningHiveModel> listW = await hiveWarning.get();
    if (listW.isNotEmpty) {
      listWarning.value = listW.toList();
    }

    List<BandwidthHiveModel> listB = await hiveBandwidth.get();
    if (listB.isNotEmpty) {
      listBandwidth.value = listB.toList();
    }

    List<PlayNewsHiveModel> listP = await hivePlayNews.get();
    if (listP.isNotEmpty) {
      listPlayNews.value = listP.toList();
    }

    if (listNews.isNotEmpty) {
      List<NewsHiveModel> listNewsFilterArea = [];
      for (var news in listNews) {
        if (news.area == areaFilter && news.status == 'Đã phát') {
          listNewsFilterArea.add(news);
        }
      }

      listNewsFilterArea.sort((a, b) {
        return b.createDate!.compareTo(a.createDate!);
      });

      listHisNews.value = listNewsFilterArea.toList();
    }

    if (listWarning.isNotEmpty) {
      List<WarningHiveModel> listWarningFilterArea = [];
      for (var warning in listWarning) {
        if (warning.area == areaFilter && warning.status == 'Đã xử lý') {
          listWarningFilterArea.add(warning);
        }
      }

      listWarningFilterArea.sort((a, b) {
        return b.createDate!.compareTo(a.createDate!);
      });

      listHisWarning.value = listWarningFilterArea.toList();
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

  String _changeArea() {
    switch (valueLocation) {
      case 'District':
        return 'AREA_CHANGE_DISTRICT'.tr;
      default:
        return 'AREA_CHANGE_VILLAGE'.tr;
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
    timeTag.value = _changeTime();
    locationTag.value = _changeLocation();
    areaFilter = _changeArea();
    await onRefresh();
  }

  @override
  void onClose() async {
    timeBar.clear();
    await BoxesService().closeBox();
    super.onClose();
  }
}
