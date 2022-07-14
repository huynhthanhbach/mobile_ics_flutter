// ignore_for_file: avoid_print, unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/services/hive_bandwidth.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';
import 'package:mobile_ics_flutter/models/time_bar_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math' as math;

import 'package:uuid/uuid.dart';

class BandwidthController extends GetxController {
  final dashboardController = Get.find<DashboardController>();
  late ChartSeriesController chartSeriesController;
  late Timer _timer;
  HiveBandwidth hiveBandwidth = HiveBandwidth();

  RxList<BandwidthHiveModel> listBandwidth = <BandwidthHiveModel>[].obs;
  RxList<TimeBarModel> timeBar = <TimeBarModel>[].obs;

  List<Bandwidth> _listDataBarCharts = [];
  List<RealtimeData> _listDataCharts = [];

  RxList<LineSeries<RealtimeData, int>> seriesLive =
      <LineSeries<RealtimeData, int>>[].obs;
  RxList<charts.Series<Bandwidth, String>> seriesBarChart =
      <charts.Series<Bandwidth, String>>[].obs;

  String? _location;
  DateTime? _time;

  var timeTag = ''.obs;
  var locationTag = ''.obs;

  var timeStart = ''.obs;
  var timeEnd = ''.obs;
  var nowDataValue = 0.0.obs;
  var totalDataValue = 0.0.obs;
  var totalDataUsed = 0.0.obs;

  int time = 11;

  @override
  void onInit() {
    timeTag = dashboardController.timeTag;
    locationTag = dashboardController.locationTag;
    _location = _changeLocation(dashboardController.valueLocation);
    _time = _changeTime(dashboardController.valueTime);

    List<BandwidthHiveModel> data = dashboardController.listBandwidth.toList();
    if (data.isNotEmpty) {
      List<BandwidthHiveModel> list = [];
      for (var item in data) {
        if (item.area == _location) {
          list.add(item);
        }
      }
      var listFilter = _fillDataFormDate(list);

      listBandwidth.value = listFilter.toList();
    }

    List<TimeBarModel> timeData = dashboardController.timeBar.toList();
    if (timeData.isNotEmpty) {
      timeBar.value = timeData.toList();
    }

    _getDataCharts(listBandwidth);

    nowDataValue.value = _listDataCharts.last.value!;
    totalDataValue.value += nowDataValue.value;
    seriesLive.value = [
      LineSeries(
        dataSource: _listDataCharts,
        onRendererCreated: (ChartSeriesController controller) =>
            chartSeriesController = controller,
        color: kBackgroundTitle,
        xValueMapper: (RealtimeData data, _) => data.time,
        yValueMapper: (RealtimeData data, _) => data.value,
      ),
    ].toList();

    seriesBarChart.value = [
      charts.Series(
        id: "Bandwidth Type",
        data: _listDataBarCharts,
        domainFn: (Bandwidth bandwidth, _) => bandwidth.type!,
        measureFn: (Bandwidth bandwidth, _) =>
            double.parse(bandwidth.amount!.toStringAsFixed(3)),
        colorFn: (Bandwidth bandwidth, _) =>
            charts.ColorUtil.fromDartColor(bandwidth.barColor!),
        labelAccessorFn: (Bandwidth bandwidth, _) =>
            bandwidth.amount.toString(),
      ),
    ].toList();

    _timer = Timer.periodic(Constants.dur1000, _updateDataSource);

    super.onInit();
  }

  @override
  void onReady() {
    timeStart.value = _getTimeStart().toString();
    timeEnd.value = _getTimeEnd().toString();

    if (listBandwidth.isNotEmpty) {
      var total = 0.0;
      for (var item in listBandwidth) {
        total += item.total!;
      }
      totalDataUsed.value = total / 8;
    } else {
      totalDataUsed.value = 0.0;
    }
    super.onReady();
  }

  DateTime _getDateTimeFilter(int i) {
    final dateFormat = DateFormat('y-MM-dd');
    final now = Jiffy(DateTime.now()).subtract(days: i);
    var date = now.format('yyyy-MM-dd h:mm:ss a');

    DateTime dateChange = dateFormat.parse(date, true);

    return dateChange;
  }

  void _getDataCharts(RxList<BandwidthHiveModel> list) {
    if (list.isNotEmpty) {
      double sun = 0, mon = 0, tue = 0, wed = 0, thu = 0, fri = 0, sat = 0;

      for (var item in list) {
        if (item.createDate!.day.toString() == timeBar[0].day) {
          sun += item.total!;
        }
        if (item.createDate!.day.toString() == timeBar[1].day) {
          mon += item.total!;
        }
        if (item.createDate!.day.toString() == timeBar[2].day) {
          tue += item.total!;
        }
        if (item.createDate!.day.toString() == timeBar[3].day) {
          wed += item.total!;
        }
        if (item.createDate!.day.toString() == timeBar[4].day) {
          thu += item.total!;
        }
        if (item.createDate!.day.toString() == timeBar[5].day) {
          fri += item.total!;
        }
        if (item.createDate!.day.toString() == timeBar[6].day) {
          sat += item.total!;
        }
      }

      _listDataCharts = [
        RealtimeData(time: 0, value: 0),
        RealtimeData(time: 01, value: 0),
        RealtimeData(time: 02, value: 0),
        RealtimeData(time: 03, value: 0),
        RealtimeData(time: 04, value: 0),
        RealtimeData(time: 05, value: 0),
        RealtimeData(time: 06, value: 0),
        RealtimeData(time: 07, value: 0),
        RealtimeData(time: 08, value: 0),
        RealtimeData(time: 09, value: 0),
        RealtimeData(time: 10, value: 0),
      ].toList();

      _listDataBarCharts = [
        Bandwidth(
            type: '${timeBar[0].month} ${timeBar[0].day}',
            amount: double.parse(sun.toStringAsFixed(2)),
            barColor: (timeBar[0].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
        Bandwidth(
            type: '${timeBar[1].month} ${timeBar[1].day}',
            amount: double.parse(mon.toStringAsFixed(2)),
            barColor: (timeBar[1].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
        Bandwidth(
            type: '${timeBar[2].month} ${timeBar[2].day}',
            amount: double.parse(tue.toStringAsFixed(2)),
            barColor: (timeBar[2].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
        Bandwidth(
            type: '${timeBar[3].month} ${timeBar[3].day}',
            amount: double.parse(wed.toStringAsFixed(2)),
            barColor: (timeBar[3].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
        Bandwidth(
            type: '${timeBar[4].month} ${timeBar[4].day}',
            amount: double.parse(thu.toStringAsFixed(2)),
            barColor: (timeBar[4].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
        Bandwidth(
            type: '${timeBar[5].month} ${timeBar[5].day}',
            amount: double.parse(fri.toStringAsFixed(2)),
            barColor: (timeBar[5].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
        Bandwidth(
            type: '${timeBar[6].month} ${timeBar[6].day}',
            amount: double.parse(sat.toStringAsFixed(2)),
            barColor: (timeBar[6].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
      ].toList();
    } else {
      _listDataCharts = [
        RealtimeData(time: 0, value: 0),
        RealtimeData(time: 01, value: 0),
        RealtimeData(time: 02, value: 0),
        RealtimeData(time: 03, value: 0),
        RealtimeData(time: 04, value: 0),
        RealtimeData(time: 05, value: 0),
        RealtimeData(time: 06, value: 0),
        RealtimeData(time: 07, value: 0),
        RealtimeData(time: 08, value: 0),
        RealtimeData(time: 09, value: 0),
        RealtimeData(time: 10, value: 0),
      ].toList();

      _listDataBarCharts = [
        Bandwidth(
            type: '${timeBar[0].month} ${timeBar[0].day}',
            amount: 0,
            barColor: (timeBar[0].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
        Bandwidth(
            type: '${timeBar[1].month} ${timeBar[1].day}',
            amount: 0,
            barColor: (timeBar[1].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
        Bandwidth(
            type: '${timeBar[2].month} ${timeBar[2].day}',
            amount: 0,
            barColor: (timeBar[2].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
        Bandwidth(
            type: '${timeBar[3].month} ${timeBar[3].day}',
            amount: 0,
            barColor: (timeBar[3].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
        Bandwidth(
            type: '${timeBar[4].month} ${timeBar[4].day}',
            amount: 0,
            barColor: (timeBar[4].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
        Bandwidth(
            type: '${timeBar[5].month} ${timeBar[5].day}',
            amount: 0,
            barColor: (timeBar[5].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
        Bandwidth(
            type: '${timeBar[6].month} ${timeBar[6].day}',
            amount: 0,
            barColor: (timeBar[6].now) ? kBackgroundTitle : kBackgroundTag2,
            status: ''),
      ].toList();
    }
  }

  Future<void> _addBandwidthToHive(double value) async {
    final BandwidthHiveModel bandwidthHiveModel = BandwidthHiveModel(
      id: const Uuid().v1(),
      createDate: DateTime.now(),
      area: _location,
      total: value,
    );
    var flag = await hiveBandwidth.addBandwidthToHive(bandwidthHiveModel);
    if (flag) {
      print(
          '${bandwidthHiveModel.createDate} - ${bandwidthHiveModel.total} -- Success');
    } else {
      print(
          '${bandwidthHiveModel.createDate} - ${bandwidthHiveModel.total}-- Failed');
    }
  }

  Future<void> _changeFilter() async {
    timeTag = dashboardController.timeTag;
    locationTag = dashboardController.locationTag;

    print(timeTag);
    print(locationTag);
  }

  String _getTimeStart() {
    final now = DateTime.now();
    final dateFormat = DateFormat('dd/MM/y');
    var weekDay = now.weekday;
    if (weekDay == 7) {
      var timeStart = now.subtract(Duration(days: weekDay - 7));

      return dateFormat.format(timeStart);
    }
    var timeStart = now.subtract(Duration(days: weekDay - 0));
    return dateFormat.format(timeStart);
  }

  String _getTimeEnd() {
    final now = DateTime.now();
    final dateFormat = DateFormat('dd/MM/y');
    var weekDay = now.weekday;
    if (weekDay == 7) {
      var timeEnd = now.subtract(Duration(days: weekDay - 13));
      return dateFormat.format(timeEnd);
    }
    var timeEnd = now.subtract(Duration(days: weekDay - 6));
    return dateFormat.format(timeEnd);
  }

  List<BandwidthHiveModel> _itemsBetweenDates({
    required List<BandwidthHiveModel> list,
    required DateTime dateStart,
    required DateTime dateEnd,
  }) {
    var dateFormat = DateFormat('y-MM-dd');

    var filterList = <BandwidthHiveModel>[];

    for (var item in list) {
      var date = dateFormat.parse(item.createDate.toString(), true);
      if (date.compareTo(dateStart) >= 0 && date.compareTo(dateEnd) <= 0) {
        filterList.add(item);
      }
    }

    return filterList;
  }

  List<BandwidthHiveModel> _fillDataFormDate(List<BandwidthHiveModel> list) {
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

    List<BandwidthHiveModel> data = dashboardController.listBandwidth.toList();
    if (data.isNotEmpty) {
      List<BandwidthHiveModel> list = [];
      for (var item in data) {
        if (item.area == _location) {
          list.add(item);
        }
      }

      var listFilter = _fillDataFormDate(list);
      listBandwidth.value = listFilter.toList();
    }

    _getDataCharts(listBandwidth);

    if (listBandwidth.isNotEmpty) {
      var total = 0.0;
      for (var item in listBandwidth) {
        total += item.total!;
      }
      totalDataUsed.value = total / 8;
    } else {
      totalDataUsed.value = 0.0;
    }

    nowDataValue.value = _listDataCharts.last.value!;
    totalDataValue.value = nowDataValue.value;
    time = 11;

    seriesLive.value = [
      LineSeries(
        dataSource: _listDataCharts,
        // color: const Color.fromRGBO(192, 108, 132, 1),
        onRendererCreated: (ChartSeriesController controller) =>
            chartSeriesController = controller,
        color: kBackgroundTitle,
        xValueMapper: (RealtimeData data, _) => data.time,
        yValueMapper: (RealtimeData data, _) => data.value,
      ),
    ].toList();

    seriesLive.refresh();

    seriesBarChart.value = [
      charts.Series(
        id: "Bandwidth Type",
        data: _listDataBarCharts,
        domainFn: (Bandwidth bandwidth, _) => bandwidth.type!,
        measureFn: (Bandwidth bandwidth, _) =>
            double.parse(bandwidth.amount!.toStringAsFixed(3)),
        colorFn: (Bandwidth bandwidth, _) =>
            charts.ColorUtil.fromDartColor(bandwidth.barColor!),
        labelAccessorFn: (Bandwidth bandwidth, _) =>
            bandwidth.amount.toString(),
      ),
    ].toList();

    seriesBarChart.refresh();
  }

  void _updateDataSource(Timer timer) {
    _listDataCharts.add(
      RealtimeData(time: time++, value: math.Random().nextDouble() * 10),
    );
    _listDataCharts.removeAt(0);
    chartSeriesController.updateDataSource(
      addedDataIndex: _listDataCharts.length - 1,
      removedDataIndex: 0,
    );
    _addBandwidthToHive(_listDataCharts.last.value!);
    nowDataValue.value = _listDataCharts.last.value!;
    totalDataValue.value += nowDataValue.value;
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

  @override
  void onClose() async {
    _timer.cancel();
    await dashboardController.onRefresh();
    super.onClose();
  }
}

class RealtimeData {
  int? time;
  double? value;
  RealtimeData({
    this.time,
    this.value,
  });
}

class Bandwidth {
  String? type;
  String? status;
  double? amount;
  Color? barColor;

  Bandwidth({
    this.type,
    this.status,
    this.amount,
    this.barColor,
  });
}
