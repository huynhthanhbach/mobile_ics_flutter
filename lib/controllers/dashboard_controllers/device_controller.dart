import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/widget.dart';
import 'package:mobile_ics_flutter/models/device_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';

class DeviceController extends GetxController {
  late TooltipBehavior tooltipBehavior1;
  late TooltipBehavior tooltipBehavior2;

  List<charts.Series<DeviceModel, String>> series = [];
  List<CircularSeries<DeviceModel, String>> seriesPie = [];

  Random random = Random();
  late int random1, random2, random3, random4, random5 = 0;

  List<DeviceModel> deviceList = [
    DeviceModel(
        type: "Gateway",
        status: "Đang chờ phát",
        amount: 200,
        barColor: const Color(0xFFD9D9D9)),
    DeviceModel(
        type: "Audio box",
        status: "Đang phát",
        amount: 400,
        barColor: const Color(0xFFD9D9D9)),
  ];

  @override
  void onInit() {
    tooltipBehavior1 = TooltipBehavior(enable: true);
    tooltipBehavior2 = TooltipBehavior(enable: true);
    series = [
      charts.Series(
        id: "Device Type",
        data: deviceList,
        domainFn: (DeviceModel pops, _) => pops.type,
        measureFn: (DeviceModel pops, _) => pops.amount,
        colorFn: (DeviceModel pops, _) =>
            charts.ColorUtil.fromDartColor(kBackgroundTitle),
        labelAccessorFn: (DeviceModel pops, _) => pops.amount.toString(),
      ),
    ];
    seriesPie = [
      PieSeries(
        dataSource: deviceList,
        xValueMapper: (DeviceModel news, _) => news.status,
        yValueMapper: (DeviceModel news, _) => news.amount,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: Constants.kRegular,
            fontFamily: 'SourceSansPro',
          ),
        ),
        radius: '140%',
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
    deviceList.clear();
    if (deviceList.isEmpty) {
      series.clear();
      deviceList = [
        DeviceModel(
            type: "Gateway",
            status: "Đang chờ phát",
            amount: random1,
            barColor: const Color(0xFFD9D9D9)),
        DeviceModel(
            type: "Audio box",
            status: "Đang phát",
            amount: random2,
            barColor: const Color(0xFFD9D9D9)),
      ].toList();

      series = [
        charts.Series(
          id: "Device Type",
          data: deviceList,
          domainFn: (DeviceModel pops, _) => pops.type,
          measureFn: (DeviceModel pops, _) => pops.amount,
          colorFn: (DeviceModel pops, _) =>
              charts.ColorUtil.fromDartColor(kBackgroundTitle),
          labelAccessorFn: (DeviceModel pops, _) => pops.amount.toString(),
        ),
      ];
      seriesPie = [
        PieSeries(
          dataSource: deviceList,
          xValueMapper: (DeviceModel news, _) => news.status,
          yValueMapper: (DeviceModel news, _) => news.amount,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: Constants.kRegular,
              fontFamily: 'SourceSansPro',
            ),
          ),
          enableTooltip: true,
          radius: '140%',
        )
      ].toList();
    }
    update();
  }
}
