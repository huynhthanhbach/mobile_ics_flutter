// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/models/news_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

class NewsPageController extends GetxController {
  late TooltipBehavior tooltipBehavior;
  List<NewsModel> newsList = [
    NewsModel(
        type: "Thể thao",
        status: "Vừa được khởi tạo",
        amount: 200,
        barColor: const Color(0xFFD9D9D9)),
    NewsModel(
        type: "Đời sống",
        status: "Đang chờ phê duyệt",
        amount: 400,
        barColor: const Color(0xFFD9D9D9)),
    NewsModel(
        type: "Pháp luật",
        status: "Đã phê duyệt",
        amount: 250,
        barColor: const Color(0xFFD9D9D9)),
    NewsModel(
        type: "Cảnh báo",
        status: "Đã phát",
        amount: 50,
        barColor: const Color(0xFFD9D9D9)),
    NewsModel(
        type: "Thông tin",
        status: "Đã phát",
        amount: 100,
        barColor: const Color(0xFFD9D9D9)),
  ];
  List<NewsModel> newsListPie = [
    NewsModel(
        type: "Thể thao",
        status: "Vừa được khởi tạo",
        amount: 200,
        barColor: const Color(0xFFD9D9D9)),
    NewsModel(
        type: "Đời sống",
        status: "Đang chờ phê duyệt",
        amount: 400,
        barColor: const Color(0xFFD9D9D9)),
    NewsModel(
        type: "Pháp luật",
        status: "Đã phê duyệt",
        amount: 250,
        barColor: const Color(0xFFD9D9D9)),
    NewsModel(
        type: "Cảnh báo",
        status: "Đã phát",
        amount: 50,
        barColor: const Color(0xFFD9D9D9)),
  ];

  List<charts.Series<NewsModel, String>> series = [];
  List<CircularSeries<NewsModel, String>> seriesPie = [];

  Random random = Random();
  late int random1, random2, random3, random4, random5 = 0;

  @override
  void onInit() {
    tooltipBehavior = TooltipBehavior(enable: true);
    series = [
      charts.Series(
        id: "News Type",
        data: newsList,
        domainFn: (NewsModel pops, _) => pops.type,
        measureFn: (NewsModel pops, _) => pops.amount,
        colorFn: (NewsModel pops, _) =>
            charts.ColorUtil.fromDartColor(kBackgroundTitle),
        labelAccessorFn: (NewsModel pops, _) => pops.amount.toString(),
      ),
    ];

    seriesPie = [
      PieSeries(
        dataSource: newsListPie,
        xValueMapper: (NewsModel news, _) => news.status,
        yValueMapper: (NewsModel news, _) => news.amount,
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

  Future changList() async {
    random1 = random.nextInt(100);
    random2 = random.nextInt(100);
    random3 = random.nextInt(100);
    random4 = random.nextInt(100);
    random5 = random.nextInt(100);
    newsList.clear();
    newsListPie.clear();
    print(newsList.length);
    if (newsList.isEmpty) {
      series.clear();
      newsList = [
        NewsModel(
            type: "Thể thao",
            status: "Vừa được khởi tạo",
            amount: random1,
            barColor: const Color(0xFFD9D9D9)),
        NewsModel(
            type: "Đời sống",
            status: "Đang chờ phê duyệt",
            amount: random2,
            barColor: const Color(0xFFD9D9D9)),
        NewsModel(
            type: "Pháp luật",
            status: "Đã phê duyệt",
            amount: random3,
            barColor: const Color(0xFFD9D9D9)),
        NewsModel(
            type: "Cảnh báo",
            status: "Đã phát",
            amount: random4,
            barColor: const Color(0xFFD9D9D9)),
        NewsModel(
            type: "Thông tin",
            status: "Đã phát",
            amount: random5,
            barColor: const Color(0xFFD9D9D9)),
      ].toList();
      List<NewsModel> newsListPie = [
        NewsModel(
            type: "Thể thao",
            status: "Vừa được khởi tạo",
            amount: random1,
            barColor: const Color(0xFFD9D9D9)),
        NewsModel(
            type: "Đời sống",
            status: "Đang chờ phê duyệt",
            amount: random2,
            barColor: const Color(0xFFD9D9D9)),
        NewsModel(
            type: "Pháp luật",
            status: "Đã phê duyệt",
            amount: random3,
            barColor: const Color(0xFFD9D9D9)),
        NewsModel(
            type: "Cảnh báo",
            status: "Đã phát",
            amount: random4,
            barColor: const Color(0xFFD9D9D9)),
      ].toList();
      series = [
        charts.Series(
          id: "News Type",
          data: newsList,
          domainFn: (NewsModel pops, _) => pops.type,
          measureFn: (NewsModel pops, _) => pops.amount,
          colorFn: (NewsModel pops, _) =>
              charts.ColorUtil.fromDartColor(kBackgroundTitle),
          labelAccessorFn: (NewsModel pops, _) => pops.amount.toString(),
        ),
      ];
      seriesPie = [
        PieSeries(
          dataSource: newsListPie,
          xValueMapper: (NewsModel news, _) => news.status,
          yValueMapper: (NewsModel news, _) => news.amount,
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
    }
    update();
  }
}
