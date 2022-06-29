// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  Random random = Random();
  late int random1, random2, random3, random4, random5 = 0;

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
      List<NewsHiveModel> listSport = [];
      List<NewsHiveModel> listLife = [];
      List<NewsHiveModel> listLaw = [];
      List<NewsHiveModel> listWarning = [];
      List<NewsHiveModel> listInfo = [];

      List<NewsHiveModel> listStatus1 = [];
      List<NewsHiveModel> listStatus2 = [];
      List<NewsHiveModel> listStatus3 = [];
      List<NewsHiveModel> listStatus4 = [];

      for (var item in listNews) {
        if (item.type == 'Thể thao') {
          listSport.add(item);
        }

        if (item.type == 'Đời sống') {
          listLife.add(item);
        }

        if (item.type == 'Pháp luật') {
          listLaw.add(item);
        }

        if (item.type == 'Cảnh báo') {
          listWarning.add(item);
        }

        if (item.type == 'Thông tin') {
          listInfo.add(item);
        }

        if (item.status == 'Vừa được khởi tạo') {
          listStatus1.add(item);
        }

        if (item.status == 'Đang chờ phê duyệt') {
          listStatus2.add(item);
        }

        if (item.status == 'Đã phê duyệt') {
          listStatus3.add(item);
        }

        if (item.status == 'Đã phát') {
          listStatus4.add(item);
        }
      }

      _listBarChart = [
        News(
            type: 'Thể thao',
            amount: listSport.length,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Đời sống',
            amount: listLife.length,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Pháp luật',
            amount: listLaw.length,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Cảnh báo',
            amount: listWarning.length,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Thông tin',
            amount: listInfo.length,
            barColor: kBackgroundTitle,
            status: ''),
      ];
      _listPieChart = [
        News(
            type: '',
            status: 'Vừa được khởi tạo',
            amount: listStatus1.length,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'Đang chờ phê duyệt',
            amount: listStatus2.length,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'Đã phê duyệt',
            amount: listStatus3.length,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'Đã phát',
            amount: listStatus4.length,
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
      List<NewsHiveModel> listSport = [];
      List<NewsHiveModel> listLife = [];
      List<NewsHiveModel> listLaw = [];
      List<NewsHiveModel> listWarning = [];
      List<NewsHiveModel> listInfo = [];

      List<NewsHiveModel> listStatus1 = [];
      List<NewsHiveModel> listStatus2 = [];
      List<NewsHiveModel> listStatus3 = [];
      List<NewsHiveModel> listStatus4 = [];

      for (var item in listNews) {
        if (item.type == 'Thể thao') {
          listSport.add(item);
        }

        if (item.type == 'Đời sống') {
          listLife.add(item);
        }

        if (item.type == 'Pháp luật') {
          listLaw.add(item);
        }

        if (item.type == 'Cảnh báo') {
          listWarning.add(item);
        }

        if (item.type == 'Thông tin') {
          listInfo.add(item);
        }

        if (item.status == 'Vừa được khởi tạo') {
          listStatus1.add(item);
        }

        if (item.status == 'Đang chờ phê duyệt') {
          listStatus2.add(item);
        }

        if (item.status == 'Đã phê duyệt') {
          listStatus3.add(item);
        }

        if (item.status == 'Đã phát') {
          listStatus4.add(item);
        }
      }

      _listBarChart = [
        News(
            type: 'Thể thao',
            amount: listSport.length,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Đời sống',
            amount: listLife.length,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Pháp luật',
            amount: listLaw.length,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Cảnh báo',
            amount: listWarning.length,
            barColor: kBackgroundTitle,
            status: ''),
        News(
            type: 'Thông tin',
            amount: listInfo.length,
            barColor: kBackgroundTitle,
            status: ''),
      ].toList();
      _listPieChart = [
        News(
            type: '',
            status: 'Vừa được khởi tạo',
            amount: listStatus1.length,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'Đang chờ phê duyệt',
            amount: listStatus2.length,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'Đã phê duyệt',
            amount: listStatus3.length,
            barColor: const Color(0xFFD9D9D9)),
        News(
            type: '',
            status: 'Đã phát',
            amount: listStatus4.length,
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
