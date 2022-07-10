import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_ics_flutter/models/time_bar_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DeviceController extends GetxController {
  final dashboardController = Get.find<DashboardController>();
  late TooltipBehavior tooltipBehavior1;
  late TooltipBehavior tooltipBehavior2;

  RxList<TimeBarModel> timeBar = <TimeBarModel>[].obs;

  String? _location;
  var timeTag = ''.obs;
  var locationTag = ''.obs;

  RxList<charts.Series<Device, String>> series =
      <charts.Series<Device, String>>[].obs;
  RxList<CircularSeries<Device, String>> seriesPie =
      <CircularSeries<Device, String>>[].obs;

  Random random = Random();
  late int random1, random2, random3, random4, random5 = 0;

  List<Device> _listDataCharts = [];

  @override
  void onInit() {
    tooltipBehavior1 = TooltipBehavior(enable: true);
    tooltipBehavior2 = TooltipBehavior(enable: true);

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

    series.value = [
      charts.Series(
        id: "Device Type",
        data: _listDataCharts,
        domainFn: (Device device, _) => device.type!,
        measureFn: (Device device, _) => device.amount,
        colorFn: (Device device, _) =>
            charts.ColorUtil.fromDartColor(kBackgroundTitle),
        labelAccessorFn: (Device device, _) => device.amount.toString(),
      ),
    ].toList();

    seriesPie.value = [
      PieSeries(
        dataSource: _listDataCharts,
        xValueMapper: (Device device, _) => device.status,
        yValueMapper: (Device device, _) => device.amount,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'SourceSansPro',
          ),
        ),
        radius: '140%',
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
    random4 = random.nextInt(100);
    random5 = random.nextInt(100);

    _listDataCharts = [
      Device(
          type: 'DEVICE_NAME_GATE'.tr,
          status: 'DEVICE_STATUS_AWAIT'.tr,
          amount: random1,
          barColor: const Color(0xFFD9D9D9)),
      Device(
          type: 'DEVICE_NAME_AUDIO'.tr,
          status: 'DEVICE_STATUS_PLAYING'.tr,
          amount: random2,
          barColor: const Color(0xFFD9D9D9)),
    ].toList();

    series.value = [
      charts.Series(
        id: "Device Type",
        data: _listDataCharts,
        domainFn: (Device device, _) => device.type!,
        measureFn: (Device device, _) => device.amount,
        colorFn: (Device device, _) =>
            charts.ColorUtil.fromDartColor(kBackgroundTitle),
        labelAccessorFn: (Device device, _) => device.amount.toString(),
      ),
    ].toList();

    seriesPie.value = [
      PieSeries(
        dataSource: _listDataCharts,
        xValueMapper: (Device device, _) => device.status,
        yValueMapper: (Device device, _) => device.amount,
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
      Device(
          type: 'DEVICE_NAME_GATE'.tr,
          status: 'DEVICE_STATUS_AWAIT'.tr,
          amount: 200,
          barColor: const Color(0xFFD9D9D9)),
      Device(
          type: 'DEVICE_NAME_AUDIO'.tr,
          status: 'DEVICE_STATUS_PLAYING'.tr,
          amount: 400,
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

class Device {
  String? type;
  String? status;
  int? amount;
  Color? barColor;
  Device({
    this.type,
    this.status,
    this.amount,
    this.barColor,
  });
}
