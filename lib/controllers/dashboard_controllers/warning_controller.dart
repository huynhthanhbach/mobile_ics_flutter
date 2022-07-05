// ignore_for_file: avoid_print
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/models/time_bar_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WarningController extends GetxController {
  final dashboardController = Get.find<DashboardController>();
  late TooltipBehavior tooltipBehavior;

  RxList<TimeBarModel> timeBar = <TimeBarModel>[].obs;

  List<Warning> _listDataCharts = [];

  String? _location;
  var timeTag = ''.obs;
  var locationTag = ''.obs;

  RxList<CircularSeries<Warning, String>> seriesPie =
      <CircularSeries<Warning, String>>[].obs;
  Random random = Random();
  late int random1, random2, random3 = 0;

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

  Future changList() async {
    await onRefresh();
  }

  Future showBottomSheet(BuildContext context, Widget child) async {
    await dashboardController.showBottomSheet(context, child);
  }

  Future onRefresh() async {
    await _changeFilter();
    _location = _changeLocation(dashboardController.valueLocation);

    random1 = random.nextInt(100);
    random2 = random.nextInt(100);
    random3 = random.nextInt(100);

    _listDataCharts = [
      Warning(
          type: '',
          status: 'WARNING_LEVEL_SMALL'.tr,
          amount: random1,
          barColor: const Color(0xFFD9D9D9)),
      Warning(
          type: '',
          status: 'WARNING_LEVEL_MEDIUM'.tr,
          amount: random2,
          barColor: const Color(0xFFD9D9D9)),
      Warning(
          type: '',
          status: 'WARNING_LEVEL_HARD'.tr,
          amount: random3,
          barColor: const Color(0xFFD9D9D9)),
    ].toList();

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
      Warning(
          type: '',
          status: 'WARNING_LEVEL_SMALL'.tr,
          amount: 200,
          barColor: const Color(0xFFD9D9D9)),
      Warning(
          type: '',
          status: 'WARNING_LEVEL_MEDIUM'.tr,
          amount: 400,
          barColor: const Color(0xFFD9D9D9)),
      Warning(
          type: '',
          status: 'WARNING_LEVEL_HARD'.tr,
          amount: 250,
          barColor: const Color(0xFFD9D9D9)),
    ].toList();
  }

  Future<void> _changeFilter() async {
    timeTag = dashboardController.timeTag;
    locationTag = dashboardController.locationTag;

    print(timeTag);
    print(locationTag);
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
