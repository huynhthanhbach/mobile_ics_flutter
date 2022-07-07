// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';
import 'package:mobile_ics_flutter/models/time_bar_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WarningController extends GetxController {
  final dashboardController = Get.find<DashboardController>();
  late TooltipBehavior tooltipBehavior;

  RxList<WarningHiveModel> listWarning = <WarningHiveModel>[].obs;
  RxList<TimeBarModel> timeBar = <TimeBarModel>[].obs;

  List<Warning> _listDataCharts = [];

  RxList<CircularSeries<Warning, String>> seriesPie =
      <CircularSeries<Warning, String>>[].obs;

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

    List<WarningHiveModel> data = dashboardController.listWarning.toList();
    if (data.isNotEmpty) {
      List<WarningHiveModel> list = [];
      for (var item in data) {
        if (item.area == _location) {
          list.add(item);
        }
      }
      var listFilter = _fillDataFormDate(list);

      listWarning.value = listFilter.toList();
    }

    List<TimeBarModel> timeData = dashboardController.timeBar.toList();
    if (timeData.isNotEmpty) {
      timeBar.value = timeData.toList();
    }
    print(timeBar.length);
    print(listWarning.length);

    _getDataCharts(listWarning);

    seriesPie.value = [
      PieSeries(
        dataSource: _listDataCharts,
        xValueMapper: (Warning warning, _) => warning.status,
        yValueMapper: (Warning warning, _) => warning.amount,
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

  DateTime _getDateTimeFilter(int i) {
    final dateFormat = DateFormat('y-MM-dd');
    final now = Jiffy(DateTime.now()).subtract(days: i);
    var date = now.format('yyyy-MM-dd h:mm:ss a');

    DateTime dateChange = dateFormat.parse(date, true);

    return dateChange;
  }

  void _getDataCharts(RxList<WarningHiveModel> list) {
    if (list.isNotEmpty) {
      int status1 = 0, status2 = 0, status3 = 0;

      for (var item in list) {
        if (item.level == 'Nhẹ') {
          status1++;
        }

        if (item.level == 'Trung bình') {
          status2++;
        }

        if (item.level == 'Nghiêm trọng') {
          status3++;
        }
      }

      _listDataCharts = [
        Warning(
            type: '',
            status: 'WARNING_LEVEL_SMALL'.tr,
            amount: status1,
            barColor: const Color(0xFFD9D9D9)),
        Warning(
            type: '',
            status: 'WARNING_LEVEL_MEDIUM'.tr,
            amount: status2,
            barColor: const Color(0xFFD9D9D9)),
        Warning(
            type: '',
            status: 'WARNING_LEVEL_HARD'.tr,
            amount: status3,
            barColor: const Color(0xFFD9D9D9)),
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

  List<WarningHiveModel> _itemsBetweenDates({
    required List<WarningHiveModel> list,
    required DateTime dateStart,
    required DateTime dateEnd,
  }) {
    var dateFormat = DateFormat('y-MM-dd');

    var filterList = <WarningHiveModel>[];

    for (var item in list) {
      var date = dateFormat.parse(item.createDate.toString(), true);
      if (date.compareTo(dateStart) >= 0 && date.compareTo(dateEnd) <= 0) {
        filterList.add(item);
      }
    }

    return filterList;
  }

  List<WarningHiveModel> _fillDataFormDate(List<WarningHiveModel> list) {
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
    listWarning.clear();
    _listDataCharts.clear();
    await _changeFilter();
    _location = _changeLocation(dashboardController.valueLocation);
    _time = _changeTime(dashboardController.valueTime);

    List<WarningHiveModel> data = dashboardController.listWarning.toList();
    if (data.isNotEmpty) {
      List<WarningHiveModel> list = [];
      for (var item in data) {
        if (item.area == _location) {
          list.add(item);
        }
      }

      var listFilter = _fillDataFormDate(list);
      listWarning.value = listFilter.toList();
    }

    _getDataCharts(listWarning);

    seriesPie.value = [
      PieSeries(
        dataSource: _listDataCharts,
        xValueMapper: (Warning warning, _) => warning.status,
        yValueMapper: (Warning warning, _) => warning.amount,
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

    seriesPie.refresh();
  }

  String _changeLocation(String value) {
    switch (value) {
      case 'District':
        return 'Đài truyền thanh cấp huyện';
      default:
        return 'Đài truyền thanh cấp xã';
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
}

class Warning {
  String? type;
  String? status;
  int? amount;
  Color? barColor;
  Warning({
    this.type,
    this.status,
    this.amount,
    this.barColor,
  });
}
