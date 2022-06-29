// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_ics_flutter/controllers/dashboard_controllers/dashboard_controller.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';

import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

class NewsPageController extends GetxController {
  late TooltipBehavior tooltipBehavior;

  List<NewsHiveModel> listNews = [];
  List<NewsHiveModel> listNewsType = [];
  List<NewsHiveModel> listNewsStatus = [];

  List<News> _listBarChart = [];
  List<News> _listPieChart = [];

  List<charts.Series<News, String>> seriesBarChart = [];
  List<CircularSeries<News, String>> seriesPie = [];

  String? location;

  final _controller = Get.find<DashboardController>();

  @override
  void onInit() async {
    tooltipBehavior = TooltipBehavior(enable: true);

    location = _changeLocation(_controller.valueLocation);
    List<NewsHiveModel> list = _controller.listNews.toList();
    if (list.isNotEmpty) {
      for (var item in list) {
        if (item.area == location) {
          listNews.add(item);
        }
      }
    }

    if (listNews.isNotEmpty) {
      int sport = 0, life = 0, law = 0, warning = 0, info = 0;
      int status1 = 0, status2 = 0, status3 = 0, status4 = 0;

      for (var item in listNews) {
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

      _listBarChart = [
        News(
            type: 'Thể thao',
            amount: sport,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Đời sống',
            amount: life,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Pháp luật',
            amount: law,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Cảnh báo',
            amount: warning,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Thông tin',
            amount: info,
            barColor: kBackgroundTitle,
            status: ''),
      ];
      _listPieChart = [
        News(
            type: '',
            status: 'Vừa được khởi tạo',
            amount: status1,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'Đang chờ phê duyệt',
            amount: status2,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'Đã phê duyệt',
            amount: status3,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'Đã phát',
            amount: status4,
            barColor: const Color(0xFFD9D9D9)),
      ];
      update();
    }

    seriesBarChart = [
      charts.Series(
        id: "News Type",
        data: _listBarChart,
        domainFn: (News news, _) => news.type!,
        measureFn: (News news, _) => news.amount,
        colorFn: (News news, _) =>
            charts.ColorUtil.fromDartColor(kBackgroundTitle),
        labelAccessorFn: (News news, _) => news.amount.toString(),
      ),
    ];

    seriesPie = [
      PieSeries(
        dataSource: _listPieChart,
        xValueMapper: (News news, _) => news.status,
        yValueMapper: (News news, _) => news.amount,
        radius: '120%',
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: Constants.kRegular,
            fontFamily: 'SourceSansPro',
          ),
        ),
        enableTooltip: true,
      )
    ];

    super.onInit();
  }

  String _changeLocation(String value) {
    switch (value) {
      case 'District':
        return 'Đài truyền thanh cấp huyện';
      default:
        return 'Đài truyền thanh cấp xã';
    }
  }

  // String _changeTime(String value) {
  //   switch (value) {
  //     case 'week ago':
  //       return 'Một tuần trước';
  //     case 'month ago':
  //       return 'Một tháng trước';
  //     case 'year ago':
  //       return 'Một năm trước';
  //     default:
  //       return 'Một ngày trước';
  //   }
  // }

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

  Future<void> _fillDataFormDate(
      List<NewsHiveModel> list, DateTime dateStart, DateTime dateEnd) async {
    var dateFormat = DateFormat('y-MM-dd');
    var start = dateFormat.parse(dateStart.toString(), true);
    var end = dateFormat.parse(dateEnd.toString(), true);

    final listTemp =
        _itemsBetweenDates(list: list, dateStart: start, dateEnd: end.toUtc());
    print('Date start: $start');
    print('Date end: $end');
    print('List filter length: ${listTemp.length}');
  }

  Future onRefresh() async {
    listNews.clear();
    location = _changeLocation(_controller.valueLocation);
    List<NewsHiveModel> list = _controller.listNews.toList();
    if (list.isNotEmpty) {
      for (var item in list) {
        if (item.area == location) {
          listNews.add(item);
        }
      }
      update();
    }

    if (listNews.isNotEmpty) {
      int sport = 0, life = 0, law = 0, warning = 0, info = 0;
      int status1 = 0, status2 = 0, status3 = 0, status4 = 0;

      for (var item in listNews) {
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

      _listBarChart = [
        News(
            type: 'Thể thao',
            amount: sport,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Đời sống',
            amount: life,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Pháp luật',
            amount: law,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Cảnh báo',
            amount: warning,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Thông tin',
            amount: info,
            barColor: kBackgroundTitle,
            status: ''),
      ].toList();
      _listPieChart = [
        News(
            type: '',
            status: 'Vừa được khởi tạo',
            amount: status1,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'Đang chờ phê duyệt',
            amount: status2,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'Đã phê duyệt',
            amount: status3,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'Đã phát',
            amount: status4,
            barColor: const Color(0xFFD9D9D9)),
      ].toList();

      seriesBarChart = [
        charts.Series(
          id: "News Type",
          data: _listBarChart,
          domainFn: (News news, _) => news.type!,
          measureFn: (News news, _) => news.amount,
          colorFn: (News news, _) =>
              charts.ColorUtil.fromDartColor(kBackgroundTitle),
          labelAccessorFn: (News news, _) => news.amount.toString(),
        ),
      ].toList();

      seriesPie = [
        PieSeries(
          dataSource: _listPieChart,
          xValueMapper: (News news, _) => news.status,
          yValueMapper: (News news, _) => news.amount,
          radius: '120%',
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: Constants.kRegular,
              fontFamily: 'SourceSansPro',
            ),
          ),
          enableTooltip: true,
        )
      ].toList();
      update();
    }
  }

  Future changList() async {
    await onRefresh();
    await _fillDataFormDate(listNews, listNews[0].createDate!, DateTime.now());
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
