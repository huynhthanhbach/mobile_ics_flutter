// ignore_for_file: avoid_print, unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/models/time_bar_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math' as math;

class BandwidthController extends GetxController {
  final dashboardController = Get.find<DashboardController>();
  late ChartSeriesController chartSeriesController;
  RxList<TimeBarModel> timeBar = <TimeBarModel>[].obs;

  String? _location;
  var timeTag = ''.obs;
  var locationTag = ''.obs;

  RxList<LineSeries<Bandwidth, int>> seriesLive =
      <LineSeries<Bandwidth, int>>[].obs;

  List<Bandwidth> _listDataCharts = [];

  // int nowDataValue = 0;
  int time = 19;

  @override
  void onInit() {
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
    // nowDataValue = dataBandwidth.last.value;
    seriesLive.value = [
      LineSeries(
        dataSource: _listDataCharts,
        // color: const Color.fromRGBO(192, 108, 132, 1),
        onRendererCreated: (ChartSeriesController controller) =>
            chartSeriesController = controller,
        color: kBackgroundTitle,
        xValueMapper: (Bandwidth bandwidth, _) => bandwidth.time,
        yValueMapper: (Bandwidth bandwidth, _) => bandwidth.value,
      ),
    ].toList();

    Timer.periodic(Constants.dur1000, _updateDataSource);
    super.onInit();
  }

  Future onRefresh() async {
    await _changeFilter();
    _location = _changeLocation(dashboardController.valueLocation);
    _listDataCharts.clear();

    _listDataCharts = [
      Bandwidth(time: 0, value: 123),
      Bandwidth(time: 01, value: 12),
      Bandwidth(time: 02, value: 213),
      Bandwidth(time: 03, value: 64),
      Bandwidth(time: 04, value: 32),
      Bandwidth(time: 05, value: 43),
      Bandwidth(time: 06, value: 25),
      Bandwidth(time: 07, value: 73),
      Bandwidth(time: 08, value: 124),
      Bandwidth(time: 09, value: 54),
      Bandwidth(time: 10, value: 236),
      Bandwidth(time: 11, value: 221),
      Bandwidth(time: 12, value: 2),
      Bandwidth(time: 13, value: 12),
      Bandwidth(time: 14, value: 100),
      Bandwidth(time: 15, value: 26),
      Bandwidth(time: 16, value: 96),
      Bandwidth(time: 17, value: 23),
      Bandwidth(time: 18, value: 12),
    ].toList();

    seriesLive.value = [
      LineSeries(
        dataSource: _listDataCharts,
        // color: const Color.fromRGBO(192, 108, 132, 1),
        onRendererCreated: (ChartSeriesController controller) =>
            chartSeriesController = controller,
        color: kBackgroundTitle,
        xValueMapper: (Bandwidth bandwidth, _) => bandwidth.time,
        yValueMapper: (Bandwidth bandwidth, _) => bandwidth.value,
      ),
    ].toList();
  }

  Future changList() async {
    await onRefresh();
  }

  Future showBottomSheet(BuildContext context, Widget child) async {
    await dashboardController.showBottomSheet(context, child);
  }

  void _updateDataSource(Timer timer) {
    _listDataCharts.add(
      Bandwidth(time: time++, value: math.Random().nextInt(60) + 30),
    );
    _listDataCharts.removeAt(0);
    chartSeriesController.updateDataSource(
      addedDataIndex: _listDataCharts.length - 1,
      removedDataIndex: 0,
    );
    // nowDataValue = dataBandwidth.last.value;
    // update();
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
      Bandwidth(time: 0, value: 42),
      Bandwidth(time: 01, value: 47),
      Bandwidth(time: 02, value: 43),
      Bandwidth(time: 03, value: 49),
      Bandwidth(time: 04, value: 54),
      Bandwidth(time: 05, value: 41),
      Bandwidth(time: 06, value: 58),
      Bandwidth(time: 07, value: 51),
      Bandwidth(time: 08, value: 98),
      Bandwidth(time: 09, value: 41),
      Bandwidth(time: 10, value: 53),
      Bandwidth(time: 11, value: 72),
      Bandwidth(time: 12, value: 86),
      Bandwidth(time: 13, value: 52),
      Bandwidth(time: 14, value: 94),
      Bandwidth(time: 15, value: 92),
      Bandwidth(time: 16, value: 86),
      Bandwidth(time: 17, value: 72),
      Bandwidth(time: 18, value: 94),
    ].toList();
  }

  Future<void> _changeFilter() async {
    timeTag = dashboardController.timeTag;
    locationTag = dashboardController.locationTag;

    print(timeTag);
    print(locationTag);
  }
}

class Bandwidth {
  int? time;
  int? value;
  Bandwidth({
    this.time,
    this.value,
  });
}
