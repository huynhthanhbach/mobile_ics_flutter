// ignore_for_file: avoid_print, unused_field

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/kcolors.dart';
import 'package:mobile_ics_flutter/models/time_bar_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CalendarController extends GetxController {
  final dashboardController = Get.find<DashboardController>();
  late TooltipBehavior tooltipBehavior;
  final itemController = ItemScrollController();
  final itemListener = ItemPositionsListener.create();

  RxList<TimeBarModel> timeBar = <TimeBarModel>[].obs;
  List<Calendar> _listDataCharts = [];
  RxList<CircularSeries<Calendar, String>> seriesPie =
      <CircularSeries<Calendar, String>>[].obs;

  String? _location;
  var timeTag = ''.obs;
  var locationTag = ''.obs;

  Random random = Random();
  late int random1, random2, random3, random4 = 0;

  late CalendarModel calendarModel = CalendarModel(
      id: '7UBnjXgDaz',
      name: 'Calendar Test',
      area: 'Cấp Huyện',
      createTime: DateTime.now(),
      status: 'Đã phê duyệt');
  List<Map<String, dynamic>>? listNews;

  @override
  void onInit() {
    tooltipBehavior = TooltipBehavior(enable: true);
    _location = _changeLocation(dashboardController.valueLocation);
    timeTag = dashboardController.timeTag;
    locationTag = dashboardController.locationTag;
    List<TimeBarModel> timeData = dashboardController.timeBar.toList();
    if (timeData.isNotEmpty) {
      timeBar.value = timeData.toList();
    }
    print(timeBar.length);
    _getDataCharts();

    print(_listDataCharts.length);

    calendarModel.descNews = [
      {
        'time': '00:00 am',
        'title': 'Bản tin thời sự đài truyền hình VN',
        'slot': '00:00 - 01:00 am',
        'tlColor': kRedDark,
        'bgColor': kRedLight,
        'status': '',
      },
      {
        'time': '01:00 am',
        'title': 'Bản tin thời sự đài truyền hình VN',
        'slot': '01:00 - 02:00 am',
        'tlColor': kBlueDark,
        'bgColor': kBlueLight,
        'status': '',
      },
      {
        'time': '02:00 am',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '03:00 am',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '04:00 am',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': '',
      },
      {
        'time': '05:00 am',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '06:00 am',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '07:00 am',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': '',
      },
      {
        'time': '08:00 am',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '09:00 am',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '10:00 am',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': '',
      },
      {
        'time': '11:00 am',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '12:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '01:00 pm',
        'title': 'Bản tin thời sự đài truyền hình VN',
        'slot': '01:00 - 02:00 pm',
        'tlColor': kBlueDark,
        'bgColor': kBlueLight,
        'status': 'Đang phát',
      },
      {
        'time': '02:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '03:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '04:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': '',
      },
      {
        'time': '05:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '06:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '07:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': '',
      },
      {
        'time': '08:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '09:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '10:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': '',
      },
      {
        'time': '11:00 pm',
        'title': 'Bản tin thời sự đài truyền hình VN',
        'slot': '11:00 - 00:00 am',
        'tlColor': kYellowDark,
        'bgColor': kYellowLight,
        'status': '',
      },
    ];

    listNews = calendarModel.descNews.toList();

    seriesPie.value = [
      PieSeries(
        dataSource: _listDataCharts,
        xValueMapper: (Calendar calendar, _) => calendar.status,
        yValueMapper: (Calendar calendar, _) => calendar.amount,
        radius: '120%',
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'SourceSansPro',
          ),
        ),
        enableTooltip: true,
      )
    ].toList();

    super.onInit();
  }

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _scrollNewsPlaying(listNews!, isAnimating: true);
    });
    super.onReady();
  }

  Future onRefresh() async {
    await _changeFilter();
    _location = _changeLocation(dashboardController.valueLocation);

    random1 = random.nextInt(100);
    random2 = random.nextInt(100);
    random3 = random.nextInt(100);
    random4 = random.nextInt(100);

    _listDataCharts = [
      Calendar(
        type: '',
        status: 'CALENDAR_STATUS_INIT'.tr,
        amount: random1,
        barColor: const Color(0xFFD9D9D9),
      ),
      Calendar(
        type: '',
        status: 'CALENDAR_STATUS_AWAIT'.tr,
        amount: random2,
        barColor: const Color(0xFFD9D9D9),
      ),
      Calendar(
        type: '',
        status: 'CALENDAR_STATUS_APPROVED'.tr,
        amount: random3,
        barColor: const Color(0xFFD9D9D9),
      ),
      Calendar(
        type: '',
        status: 'CALENDAR_STATUS_PLAYED'.tr,
        amount: random4,
        barColor: const Color(0xFFD9D9D9),
      ),
    ].toList();

    seriesPie.value = [
      PieSeries(
        dataSource: _listDataCharts,
        xValueMapper: (Calendar calendar, _) => calendar.status,
        yValueMapper: (Calendar calendar, _) => calendar.amount,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'SourceSansPro',
          ),
        ),
        enableTooltip: true,
        radius: '120%',
      )
    ].toList();
  }

  Future changList() async {
    await onRefresh();
  }

  Future showBottomSheet(BuildContext context, Widget child) async {
    await dashboardController.showBottomSheet(context, child);
  }

  Future jumpNewsPlaying() async {
    await _scrollNewsPlaying(listNews!, isAnimating: false);
  }

  Future _scrollNewsPlaying(List<Map<String, dynamic>> list,
      {bool isAnimating = false}) async {
    int i = 1;
    for (var item in list) {
      if (item['status'] == 'Đang phát') {
        _scrollToItem(i - 1, isAnimating: isAnimating);
      }
      i++;
    }
  }

  Future _scrollToItem(int index, {bool isAnimating = false}) async {
    var alignment = 0.0;
    if (isAnimating) {
      await itemController.scrollTo(
        index: index,
        duration: Constants.dur1000,
        curve: Curves.fastOutSlowIn,
      );
    } else {
      itemController.jumpTo(
        index: index,
        alignment: alignment,
      );
    }
  }

  String _changeLocation(String value) {
    switch (value) {
      case 'District':
        return 'Đài truyền thanh cấp huyện';
      default:
        return 'Đài truyền thanh cấp xã';
    }
  }

  void _getDataCharts() {
    _listDataCharts = [
      Calendar(
        type: '',
        status: 'CALENDAR_STATUS_INIT'.tr,
        amount: 100,
        barColor: const Color(0xFFD9D9D9),
      ),
      Calendar(
        type: '',
        status: 'CALENDAR_STATUS_AWAIT'.tr,
        amount: 200,
        barColor: const Color(0xFFD9D9D9),
      ),
      Calendar(
        type: '',
        status: 'CALENDAR_STATUS_APPROVED'.tr,
        amount: 300,
        barColor: const Color(0xFFD9D9D9),
      ),
      Calendar(
        type: '',
        status: 'CALENDAR_STATUS_PLAYED'.tr,
        amount: 400,
        barColor: const Color(0xFFD9D9D9),
      ),
    ].toList();
  }

  Future<void> _changeFilter() async {
    timeTag = dashboardController.timeTag;
    locationTag = dashboardController.locationTag;

    print(timeTag);
    print(locationTag);
  }

  @override
  void onClose() {
    calendarModel.descNews.clear();
    listNews!.clear();
    super.onClose();
  }
}

class CalendarModel {
  String? id;
  String? name;
  String? area;
  DateTime? createTime;
  String? status;

  List<Map<String, dynamic>> descNews = [];
  CalendarModel({
    this.id,
    this.name,
    this.area,
    this.createTime,
    this.status,
  });
}

class Calendar {
  String? type;
  String? status;
  int? amount;
  Color? barColor;
  Calendar({
    this.type,
    this.status,
    this.amount,
    this.barColor,
  });
}
