// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_ics_flutter/models/time_bar_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NewsController extends GetxController {
  final dashboardController = Get.find<DashboardController>();
  late TooltipBehavior tooltipBehavior;

  RxList<NewsHiveModel> listNews = <NewsHiveModel>[].obs;
  RxList<TimeBarModel> timeBar = <TimeBarModel>[].obs;

  List<News> _listDataBarChart = [];
  List<News> _listDataPieChart = [];

  RxList<charts.Series<News, String>> seriesBarChart =
      <charts.Series<News, String>>[].obs;
  RxList<CircularSeries<News, String>> seriesPie =
      <CircularSeries<News, String>>[].obs;

  String? _location;
  DateTime? _time;

  var timeTag = ''.obs;
  var locationTag = ''.obs;

  @override
  void onInit() async {
    tooltipBehavior = TooltipBehavior(enable: true);
    timeTag = dashboardController.timeTag;
    locationTag = dashboardController.locationTag;
    _location = _changeLocation(dashboardController.valueLocation);
    _time = _changeTime(dashboardController.valueTime);

    List<NewsHiveModel> data = dashboardController.listNews.toList();
    if (data.isNotEmpty) {
      List<NewsHiveModel> list = [];
      for (var item in data) {
        if (item.area == _location) {
          list.add(item);
        }
      }
      var listFilter = _fillDataFormDate(list);

      listNews.value = listFilter.toList();
    }

    List<TimeBarModel> timeData = dashboardController.timeBar.toList();
    if (timeData.isNotEmpty) {
      timeBar.value = timeData.toList();
    }
    print(listNews.length);
    print(timeBar.length);

    _getDataCharts(listNews);

    seriesBarChart.value = [
      charts.Series(
        id: "News Type",
        data: _listDataBarChart,
        domainFn: (News news, _) => news.type!,
        measureFn: (News news, _) => news.amount,
        colorFn: (News news, _) =>
            charts.ColorUtil.fromDartColor(kBackgroundTitle),
        labelAccessorFn: (News news, _) => news.amount.toString(),
      ),
    ].toList();

    seriesPie.value = [
      PieSeries(
        dataSource: _listDataPieChart,
        xValueMapper: (News news, _) => news.status,
        yValueMapper: (News news, _) => news.amount,
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

  void _getDataCharts(RxList<NewsHiveModel> list) {
    if (list.isNotEmpty) {
      int sport = 0, life = 0, law = 0, warning = 0, info = 0;
      int status1 = 0, status2 = 0, status3 = 0, status4 = 0;

      for (var item in list) {
        if (item.type == 'Thể thao') {
          sport++;
        }

        if (item.type == 'Đời sống') {
          life++;
        }

        if (item.type == 'Pháp luật') {
          law++;
        }

        if (item.type == 'Cảnh báo') {
          warning++;
        }

        if (item.type == 'Thông tin') {
          info++;
        }

        if (item.status == 'Vừa được khởi tạo') {
          status1++;
        }

        if (item.status == 'Đang chờ phê duyệt') {
          status2++;
        }

        if (item.status == 'Đã phê duyệt') {
          status3++;
        }

        if (item.status == 'Đã phát') {
          status4++;
        }
      }

      _listDataBarChart = [
        News(
            type: 'NEWS_NAME_SPORT'.tr,
            amount: sport,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'NEWS_NAME_LIFE'.tr,
            amount: life,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'NEWS_NAME_LAW'.tr,
            amount: law,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'NEWS_NAME_WARN'.tr,
            amount: warning,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'NEWS_NAME_INFO'.tr,
            amount: info,
            barColor: kBackgroundTitle,
            status: ''),
      ].toList();
      _listDataPieChart = [
        News(
            type: '',
            status: 'NEWS_STATUS_JUST'.tr,
            amount: status1,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'NEWS_STATUS_AWAIT'.tr,
            amount: status2,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'NEWS_STATUS_APPROVED'.tr,
            amount: status3,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'NEWS_STATUS_PLAYED'.tr,
            amount: status4,
            barColor: const Color(0xFFD9D9D9)),
      ].toList();
    } else {
      _listDataBarChart = [
        News(
            type: 'NEWS_NAME_SPORT'.tr,
            amount: 0,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'NEWS_NAME_LIFE'.tr,
            amount: 0,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'NEWS_NAME_LAW'.tr,
            amount: 0,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'NEWS_NAME_WARN'.tr,
            amount: 0,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'NEWS_NAME_INFO'.tr,
            amount: 0,
            barColor: kBackgroundTitle,
            status: ''),
      ];

      _listDataPieChart = [];
    }
  }

  Future<void> _changeFilter() async {
    timeTag = dashboardController.timeTag;
    locationTag = dashboardController.locationTag;

    print(timeTag);
    print(locationTag);
  }

  List<NewsHiveModel> _itemsBetweenDates({
    required List<NewsHiveModel> list,
    required DateTime dateStart,
    required DateTime dateEnd,
  }) {
    var dateFormat = DateFormat('y-MM-dd');

    var filterList = <NewsHiveModel>[];

    for (var item in list) {
      var date = dateFormat.parse(item.createDate.toString(), true);
      if (date.compareTo(dateStart) >= 0 && date.compareTo(dateEnd) <= 0) {
        filterList.add(item);
      }
    }

    return filterList;
  }

  List<NewsHiveModel> _fillDataFormDate(List<NewsHiveModel> list) {
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
    listNews.clear();
    _listDataBarChart.clear();
    _listDataPieChart.clear();
    await _changeFilter();
    _location = _changeLocation(dashboardController.valueLocation);
    _time = _changeTime(dashboardController.valueTime);

    List<NewsHiveModel> data = dashboardController.listNews.toList();
    if (data.isNotEmpty) {
      List<NewsHiveModel> list = [];
      for (var item in data) {
        if (item.area == _location) {
          list.add(item);
        }
      }

      var listFilter = _fillDataFormDate(list);
      listNews.value = listFilter.toList();
    }

    _getDataCharts(listNews);

    seriesBarChart.value = [
      charts.Series(
        id: "News Type",
        data: _listDataBarChart,
        domainFn: (News news, _) => news.type!,
        measureFn: (News news, _) => news.amount,
        colorFn: (News news, _) =>
            charts.ColorUtil.fromDartColor(kBackgroundTitle),
        labelAccessorFn: (News news, _) => news.amount.toString(),
      ),
    ].toList();

    seriesBarChart.refresh();

    seriesPie.value = [
      PieSeries(
        dataSource: _listDataPieChart,
        xValueMapper: (News news, _) => news.status,
        yValueMapper: (News news, _) => news.amount,
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

class News {
  String? type;
  String? status;
  int? amount;
  Color? barColor;
  News({
    this.type,
    this.status,
    this.amount,
    this.barColor,
  });
}
