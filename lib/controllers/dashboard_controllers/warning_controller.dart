// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/models/warning_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WarningPageController extends GetxController {
  late TooltipBehavior tooltipBehavior;
  List<WarningModel> newsList = [
    WarningModel(
        type: "Thể thao",
        status: "Vừa được khởi tạo",
        amount: 200,
        barColor: const Color(0xFFD9D9D9)),
    WarningModel(
        type: "Đời sống",
        status: "Đang chờ phê duyệt",
        amount: 400,
        barColor: const Color(0xFFD9D9D9)),
    WarningModel(
        type: "Pháp luật",
        status: "Đã phê duyệt",
        amount: 250,
        barColor: const Color(0xFFD9D9D9)),
  ];

  List<CircularSeries<WarningModel, String>> seriesPie = [];
  Random random = Random();
  late int random1, random2, random3, random4, random5 = 0;

  @override
  void onInit() {
    tooltipBehavior = TooltipBehavior(enable: true);

    seriesPie = [
      PieSeries(
        dataSource: newsList,
        xValueMapper: (WarningModel news, _) => news.status,
        yValueMapper: (WarningModel news, _) => news.amount,
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
    newsList.clear();
    if (newsList.isEmpty) {
      newsList = [
        WarningModel(
            type: "Thể thao",
            status: "Vừa được khởi tạo",
            amount: random1,
            barColor: const Color(0xFFD9D9D9)),
        WarningModel(
            type: "Đời sống",
            status: "Đang chờ phê duyệt",
            amount: random2,
            barColor: const Color(0xFFD9D9D9)),
        WarningModel(
            type: "Pháp luật",
            status: "Đã phê duyệt",
            amount: random3,
            barColor: const Color(0xFFD9D9D9)),
      ].toList();

      seriesPie = [
        PieSeries(
          dataSource: newsList,
          xValueMapper: (WarningModel news, _) => news.status,
          yValueMapper: (WarningModel news, _) => news.amount,
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
