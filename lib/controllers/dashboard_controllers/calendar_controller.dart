// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_print, unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/kcolors.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';
import 'package:mobile_ics_flutter/models/time_bar_model.dart';

class CalendarController extends GetxController {
  final dashboardController = Get.find<DashboardController>();
  late TooltipBehavior tooltipBehavior;
  final itemController = ItemScrollController();
  final itemListener = ItemPositionsListener.create();

  RxList<CalendarHiveModel> listCalendar = <CalendarHiveModel>[].obs;
  RxList<TimeBarModel> timeBar = <TimeBarModel>[].obs;

  List<Calendar> _listDataCharts = [];
  RxList<Map<String, dynamic>> listTimeLine = <Map<String, dynamic>>[].obs;

  RxList<CircularSeries<Calendar, String>> seriesPie =
      <CircularSeries<Calendar, String>>[].obs;

  String? _location;
  DateTime? _time;

  var timeTag = ''.obs;
  var locationTag = ''.obs;

  @override
  void onInit() {
    tooltipBehavior = TooltipBehavior(enable: true);
    timeTag = dashboardController.timeTag;
    locationTag = dashboardController.locationTag;
    _location = _changeLocation(dashboardController.valueLocation);
    _time = _changeTime(dashboardController.valueTime);

    List<CalendarHiveModel> data = dashboardController.listCalendar.toList();
    if (data.isNotEmpty) {
      List<CalendarHiveModel> list = [];
      for (var item in data) {
        if (item.area == _location) {
          list.add(item);
        }
      }
      var listFilter = _fillDataFormDate(list);

      listCalendar.value = listFilter.toList();
    }

    List<TimeBarModel> timeData = dashboardController.timeBar.toList();
    if (timeData.isNotEmpty) {
      timeBar.value = timeData.toList();
    }
    print(timeBar.length);
    _getDataCharts(listCalendar);
    if (listCalendar.isNotEmpty) {
      listCalendar.last.descNews = DataDesc().desc.toList();
      if (listCalendar.last.descNews.isNotEmpty) {
        listTimeLine.value = listCalendar.last.descNews.toList();
      }
    }

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
      _scrollNewsPlaying(listTimeLine, isAnimating: true);
    });
    super.onReady();
  }

  Future jumpNewsPlaying() async {
    await _scrollNewsPlaying(listTimeLine, isAnimating: false);
  }

  Future _scrollNewsPlaying(List<Map<String, dynamic>> list,
      {bool isAnimating = false}) async {
    int i = 1;
    for (var item in list) {
      if (item['status'] == '??ang ph??t') {
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

  DateTime _getDateTimeFilter(int i) {
    final dateFormat = DateFormat('y-MM-dd');
    final now = Jiffy(DateTime.now()).subtract(days: i);
    var date = now.format('yyyy-MM-dd h:mm:ss a');

    DateTime dateChange = dateFormat.parse(date, true);

    return dateChange;
  }

  void _getDataCharts(RxList<CalendarHiveModel> list) {
    if (list.isNotEmpty) {
      int status1 = 0, status2 = 0, status3 = 0, status4 = 0;

      for (var item in list) {
        if (item.status == '???????c kh???i t???o') {
          status1++;
        }

        if (item.status == '??ang ch??? ph?? duy???t') {
          status2++;
        }

        if (item.status == '???? duy???t') {
          status3++;
        }

        if (item.status == '???? ph??t') {
          status4++;
        }
      }

      _listDataCharts = [
        Calendar(
          type: '',
          status: 'CALENDAR_STATUS_INIT'.tr,
          amount: status1,
          barColor: const Color(0xFFD9D9D9),
        ),
        Calendar(
          type: '',
          status: 'CALENDAR_STATUS_AWAIT'.tr,
          amount: status2,
          barColor: const Color(0xFFD9D9D9),
        ),
        Calendar(
          type: '',
          status: 'CALENDAR_STATUS_APPROVED'.tr,
          amount: status3,
          barColor: const Color(0xFFD9D9D9),
        ),
        Calendar(
          type: '',
          status: 'CALENDAR_STATUS_PLAYED'.tr,
          amount: status4,
          barColor: const Color(0xFFD9D9D9),
        ),
      ].toList();
    } else {
      _listDataCharts = [];
    }
  }

  Future<void> _changeFilter() async {
    timeTag = dashboardController.timeTag;
    locationTag = dashboardController.locationTag;

    print(timeTag);
    print(locationTag);
  }

  List<CalendarHiveModel> _itemsBetweenDates({
    required List<CalendarHiveModel> list,
    required DateTime dateStart,
    required DateTime dateEnd,
  }) {
    var dateFormat = DateFormat('y-MM-dd');

    var filterList = <CalendarHiveModel>[];

    for (var item in list) {
      var date = dateFormat.parse(item.createDate.toString(), true);
      if (date.compareTo(dateStart) >= 0 && date.compareTo(dateEnd) <= 0) {
        filterList.add(item);
      }
    }

    return filterList;
  }

  List<CalendarHiveModel> _fillDataFormDate(List<CalendarHiveModel> list) {
    var dateFormat = DateFormat('y-MM-dd');
    var start = dateFormat.parse(_time.toString(), true);
    var end = dateFormat.parse(DateTime.now().toString(), true);

    final listTemp =
        _itemsBetweenDates(list: list, dateStart: start, dateEnd: end);
    print('Date start: $start');
    print('Date end: $end');
    print('List filter length: ${listTemp.length}');

    return listTemp;
  }

  Future onRefresh() async {
    await _changeFilter();
    _location = _changeLocation(dashboardController.valueLocation);
    _time = _changeTime(dashboardController.valueTime);

    for (var item in listCalendar) {
      item.descNews.clear();
    }
    listTimeLine.clear();

    List<CalendarHiveModel> data = dashboardController.listCalendar.toList();
    if (data.isNotEmpty) {
      List<CalendarHiveModel> list = [];
      for (var item in data) {
        if (item.area == _location) {
          list.add(item);
        }
      }

      var listFilter = _fillDataFormDate(list);
      listCalendar.value = listFilter.toList();
    }

    _getDataCharts(listCalendar);

    listCalendar.last.descNews = DataDesc().desc.toList();
    if (listCalendar.last.descNews.isNotEmpty) {
      listTimeLine.value = listCalendar.last.descNews.toList();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _scrollNewsPlaying(listTimeLine, isAnimating: true);
    });

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

    seriesPie.refresh();
  }

  String _changeLocation(String value) {
    switch (value) {
      case 'District':
        return '????i truy???n thanh c???p huy???n';
      default:
        return '????i truy???n thanh c???p x??';
    }
  }

  DateTime _changeTime(String value) {
    switch (value) {
      case 'week ago':
        return _getDateTimeFilter(7);
      case 'month ago':
        return _getDateTimeFilter(30);
      case 'year ago':
        return _getDateTimeFilter(365);
      default:
        return _getDateTimeFilter(1);
    }
  }

  Future changList() async {
    await onRefresh();
  }

  Future showBottomSheet(BuildContext context, Widget child) async {
    await dashboardController.showBottomSheet(context, child);
  }

  @override
  void onClose() {
    for (var item in listCalendar) {
      item.descNews.clear();
    }
    listTimeLine.clear();
    super.onClose();
  }
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

class DataDesc {
  List<Map<String, dynamic>> desc = [
    {
      'time': '00:00 am',
      'title': 'B???n tin th??? thao ????i truy???n h??nh VN',
      'slot': '00:00 - 01:00 am',
      'tlColor': kRedDark,
      'bgColor': kRedLight,
      'status': '',
    },
    {
      'time': '01:00 am',
      'title': 'B???n tin th??ng tin ????i truy???n h??nh VN',
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
      'title': 'B???n tin th???i s??? ????i truy???n h??nh VN',
      'slot': '01:00 - 02:00 pm',
      'tlColor': kBlueDark,
      'bgColor': kBlueLight,
      'status': '??ang ph??t',
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
      'title': 'B???n tin ph??p lu???t ????i truy???n h??nh VN',
      'slot': '11:00 - 00:00 am',
      'tlColor': kYellowDark,
      'bgColor': kYellowLight,
      'status': '',
    },
  ];
}
