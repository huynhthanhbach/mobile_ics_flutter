// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';
import 'package:mobile_ics_flutter/models/time_bar_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DeviceController extends GetxController {
  final dashboardController = Get.find<DashboardController>();
  late TooltipBehavior tooltipBehavior1;
  late TooltipBehavior tooltipBehavior2;

  RxList<DeviceHiveModel> listDevice = <DeviceHiveModel>[].obs;
  RxList<TimeBarModel> timeBar = <TimeBarModel>[].obs;

  List<Device> _listDataBarCharts = [];
  List<Device> _listDataLocalPieCharts = [];
  List<Device> _listDataOnlinePieCharts = [];

  RxList<charts.Series<Device, String>> series =
      <charts.Series<Device, String>>[].obs;
  RxList<CircularSeries<Device, String>> seriesLocalPie =
      <CircularSeries<Device, String>>[].obs;
  RxList<CircularSeries<Device, String>> seriesOnlinePie =
      <CircularSeries<Device, String>>[].obs;

  String? _location;
  DateTime? _time;

  var timeTag = ''.obs;
  var locationTag = ''.obs;

  @override
  void onInit() {
    tooltipBehavior1 = TooltipBehavior(enable: true);
    tooltipBehavior2 = TooltipBehavior(enable: true);
    timeTag = dashboardController.timeTag;
    locationTag = dashboardController.locationTag;
    _location = _changeLocation(dashboardController.valueLocation);
    _time = _changeTime(dashboardController.valueTime);

    List<DeviceHiveModel> data = dashboardController.listDevice.toList();
    if (data.isNotEmpty) {
      List<DeviceHiveModel> list = [];
      for (var item in data) {
        if (item.area == _location) {
          list.add(item);
        }
      }
      var listFilter = _fillDataFormDate(list);

      listDevice.value = listFilter.toList();
    }

    List<TimeBarModel> timeData = dashboardController.timeBar.toList();
    if (timeData.isNotEmpty) {
      timeBar.value = timeData.toList();
    }

    _getDataCharts(listDevice);

    series.value = [
      charts.Series(
        id: "Device Type",
        data: _listDataBarCharts,
        domainFn: (Device device, _) => device.type!,
        measureFn: (Device device, _) => device.amount,
        colorFn: (Device device, _) =>
            charts.ColorUtil.fromDartColor(kBackgroundTitle),
        labelAccessorFn: (Device device, _) => device.amount.toString(),
      ),
    ].toList();

    seriesLocalPie.value = [
      PieSeries(
        dataSource: _listDataLocalPieCharts,
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
    seriesOnlinePie.value = [
      PieSeries(
        dataSource: _listDataOnlinePieCharts,
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

  DateTime _getDateTimeFilter(int i) {
    final dateFormat = DateFormat('y-MM-dd');
    final now = Jiffy(DateTime.now()).subtract(days: i);
    var date = now.format('yyyy-MM-dd h:mm:ss a');

    DateTime dateChange = dateFormat.parse(date, true);

    return dateChange;
  }

  void _getDataCharts(RxList<DeviceHiveModel> list) {
    if (list.isNotEmpty) {
      int audioBox = 0, gateway = 0;
      int localStatus1 = 0, localStatus2 = 0;
      int onlineStatus1 = 0, onlineStatus2 = 0;

      for (var item in list) {
        if (item.type == 'Audio_box') {
          audioBox++;
        }

        if (item.type == 'Gateway') {
          gateway++;
        }

        if (item.typePlay == 'Phát bản tin') {
          if (item.status == 'Đang chờ phát') {
            localStatus1++;
          }
          if (item.status == 'Đang phát') {
            localStatus2++;
          }
        }

        if (item.typePlay == 'Phát trực tuyến') {
          if (item.status == 'Đang chờ phát') {
            onlineStatus1++;
          }
          if (item.status == 'Đang phát') {
            onlineStatus2++;
          }
        }
      }

      _listDataBarCharts = [
        Device(
            type: 'DEVICE_NAME_GATE'.tr,
            status: '',
            amount: gateway,
            barColor: const Color(0xFFD9D9D9)),
        Device(
            type: 'DEVICE_NAME_AUDIO'.tr,
            status: '',
            amount: audioBox,
            barColor: const Color(0xFFD9D9D9)),
      ].toList();

      _listDataLocalPieCharts = [
        Device(
            type: '',
            status: 'DEVICE_STATUS_AWAIT'.tr,
            amount: localStatus1,
            barColor: const Color(0xFFD9D9D9)),
        Device(
            type: '',
            status: 'DEVICE_STATUS_PLAYING'.tr,
            amount: localStatus2,
            barColor: const Color(0xFFD9D9D9)),
      ].toList();
      _listDataOnlinePieCharts = [
        Device(
            type: '',
            status: 'DEVICE_STATUS_AWAIT'.tr,
            amount: onlineStatus1,
            barColor: const Color(0xFFD9D9D9)),
        Device(
            type: '',
            status: 'DEVICE_STATUS_PLAYING'.tr,
            amount: onlineStatus2,
            barColor: const Color(0xFFD9D9D9)),
      ].toList();
    } else {
      _listDataBarCharts = [
        Device(
            type: 'DEVICE_NAME_GATE'.tr,
            status: '',
            amount: 0,
            barColor: const Color(0xFFD9D9D9)),
        Device(
            type: 'DEVICE_NAME_AUDIO'.tr,
            status: '',
            amount: 0,
            barColor: const Color(0xFFD9D9D9)),
      ].toList();
      _listDataLocalPieCharts = [];
      _listDataOnlinePieCharts = [];
    }
  }

  Future<void> _changeFilter() async {
    timeTag = dashboardController.timeTag;
    locationTag = dashboardController.locationTag;
    print("$locationTag - $timeTag");
  }

  List<DeviceHiveModel> _itemsBetweenDates({
    required List<DeviceHiveModel> list,
    required DateTime dateStart,
    required DateTime dateEnd,
  }) {
    var dateFormat = DateFormat('y-MM-dd');

    var filterList = <DeviceHiveModel>[];

    for (var item in list) {
      var date = dateFormat.parse(item.createDate.toString(), true);
      if (date.compareTo(dateStart) >= 0 && date.compareTo(dateEnd) <= 0) {
        filterList.add(item);
      }
    }

    return filterList;
  }

  List<DeviceHiveModel> _fillDataFormDate(List<DeviceHiveModel> list) {
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

    List<DeviceHiveModel> data = dashboardController.listDevice.toList();
    if (data.isNotEmpty) {
      List<DeviceHiveModel> list = [];
      for (var item in data) {
        if (item.area == _location) {
          list.add(item);
        }
      }

      var listFilter = _fillDataFormDate(list);
      listDevice.value = listFilter.toList();
    }

    _getDataCharts(listDevice);

    series.value = [
      charts.Series(
        id: "Device Type",
        data: _listDataBarCharts,
        domainFn: (Device device, _) => device.type!,
        measureFn: (Device device, _) => device.amount,
        colorFn: (Device device, _) =>
            charts.ColorUtil.fromDartColor(kBackgroundTitle),
        labelAccessorFn: (Device device, _) => device.amount.toString(),
      ),
    ].toList();
    series.refresh();

    seriesLocalPie.value = [
      PieSeries(
        dataSource: _listDataLocalPieCharts,
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
    seriesLocalPie.refresh();
    seriesOnlinePie.value = [
      PieSeries(
        dataSource: _listDataOnlinePieCharts,
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

    seriesOnlinePie.refresh();
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
