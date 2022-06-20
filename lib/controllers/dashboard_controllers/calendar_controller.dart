// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/kcolors.dart';
import 'package:mobile_ics_flutter/models/calendar_model.dart';
import 'package:mobile_ics_flutter/models/news_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CalendarPageController extends GetxController {
  late TooltipBehavior tooltipBehavior;
  final itemController = ItemScrollController();
  final itemListener = ItemPositionsListener.create();

  Random random = Random();
  late int random1, random2, random3, random4 = 0;

  late CalendarModel calendarModel = CalendarModel(
      id: '7UBnjXgDaz',
      name: 'Calendar Test',
      level: 'Cấp Huyện',
      createTime: DateTime.now(),
      status: 'Đã phê duyệt');
  List<Map<String, dynamic>>? listNews;

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

  List<CircularSeries<NewsModel, String>> seriesPie = [];

  @override
  void onInit() {
    tooltipBehavior = TooltipBehavior(enable: true);

    calendarModel.descNews = [
      {
        'time': '00:00 am',
        'title': 'Bản tin thời sự đài truyền hình VN',
        'slot': '00:00 - 01:00 am',
        'tlColor': kRedDark,
        'bgColor': kRedLight,
        'status': '',
      },
      {
        'time': '01:00 am',
        'title': 'Bản tin thời sự đài truyền hình VN',
        'slot': '01:00 - 02:00 am',
        'tlColor': kBlueDark,
        'bgColor': kBlueLight,
        'status': '',
      },
      {
        'time': '02:00 am',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '03:00 am',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '04:00 am',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': '',
      },
      {
        'time': '05:00 am',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '06:00 am',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '07:00 am',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': '',
      },
      {
        'time': '08:00 am',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '09:00 am',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '10:00 am',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': '',
      },
      {
        'time': '11:00 am',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '12:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '01:00 pm',
        'title': 'Bản tin thời sự đài truyền hình VN',
        'slot': '01:00 - 02:00 pm',
        'tlColor': kBlueDark,
        'bgColor': kBlueLight,
        'status': 'Đang phát',
      },
      {
        'time': '02:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '03:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '04:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': '',
      },
      {
        'time': '05:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '06:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '07:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': '',
      },
      {
        'time': '08:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kYellowDark,
        'status': '',
      },
      {
        'time': '09:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kRedDark,
        'status': '',
      },
      {
        'time': '10:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': '',
      },
      {
        'time': '11:00 pm',
        'title': 'Bản tin thời sự đài truyền hình VN',
        'slot': '11:00 - 00:00 am',
        'tlColor': kYellowDark,
        'bgColor': kYellowLight,
        'status': '',
      },
    ];

    listNews = calendarModel.descNews.toList();

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

    print(calendarModel);
    print(" news length: ${listNews!.length}");

    super.onInit();
  }

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      scrollNewsPlaying(listNews!, isAnimating: true);
    });
    super.onReady();
  }

  Future _scrollToItem(int index, {bool isAnimating = false}) async {
    var alignment = 0.0;
    if (isAnimating) {
      await itemController.scrollTo(
        index: index,
        duration: Constants.dur1000,
        curve: Curves.fastOutSlowIn,
      );
    } else {
      itemController.jumpTo(
        index: index,
        alignment: alignment,
      );
    }
  }

  Future jumpNewsPlaying() async {
    await scrollNewsPlaying(listNews!, isAnimating: false);
  }

  Future scrollNewsPlaying(List<Map<String, dynamic>> list,
      {bool isAnimating = false}) async {
    int i = 1;
    for (var item in list) {
      if (item['status'] == 'Đang phát') {
        _scrollToItem(i - 1, isAnimating: isAnimating);
      }
      i++;
    }
  }

  Future changList() async {
    random1 = random.nextInt(100);
    random2 = random.nextInt(100);
    random3 = random.nextInt(100);
    random4 = random.nextInt(100);

    newsListPie.clear();

    if (newsListPie.isEmpty) {
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

  @override
  void onClose() {
    calendarModel.descNews.clear();
    listNews!.clear();
    print(listNews);
    super.onClose();
  }
}
