// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/core/utils/constants.dart';
import 'package:mobile_ics_flutter/core/widgets/kcolors.dart';
import 'package:mobile_ics_flutter/models/calendar_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CalendarPageController extends GetxController {
  final itemController = ItemScrollController();

  late CalendarModel calendarModel = CalendarModel(
      id: '7UBnjXgDaz',
      name: 'Calendar Test',
      level: 'Cấp Huyện',
      createTime: DateTime.now(),
      status: 'Đã phê duyệt');
  List<Map<String, dynamic>>? listNews;

  @override
  void onInit() {
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
        'time': '03:00 am',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': '',
      },
      {
        'time': '04:00 am',
        'title': '',
        'slot': '',
        'tlColor': Colors.grey.withOpacity(.3),
        'status': '',
      },
      {
        'time': '01:00 pm',
        'title': 'Bản tin thời sự đài truyền hình VN',
        'slot': '01:00 - 02:00 pm',
        'tlColor': kYellowDark,
        'bgColor': kYellowLight,
        'status': '',
      },
      {
        'time': '02:00 pm',
        'title': '',
        'slot': '',
        'tlColor': kBlueDark,
        'status': 'Đang phát',
      },
      {
        'time': '03:00 pm',
        'title': '',
        'slot': '',
        'tlColor': Colors.grey.withOpacity(.3),
        'status': '',
      },
    ];

    listNews = calendarModel.descNews.toList();

    print(calendarModel);
    print(" news length: ${listNews!.length} ---- $listNews");

    super.onInit();
  }

  @override
  void onReady() {
    int i = 1;
    for (var item in listNews!) {
      if (i < listNews!.length && item['status'] == 'Đang phát') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 500), () {
            scrollToItem(i);
          });
        });
      }
      i++;
    }
    super.onReady();
  }

  Future changeStatus(int index) async {
    if (index < listNews!.length - 1) {
      if (listNews![index]['status'] == 'Đang phát') {
        listNews![index]['status'] = '';
        listNews![index + 1]['status'] = 'Đang phát';
        update();
      }
      print(index);
      print(listNews![index]['status']);
      print(index + 1);
      print(listNews![index + 1]['status']);
    }
  }

  Future scrollToItem(int index) async {
    itemController.scrollTo(
      index: index,
      duration: Constants.dur500,
    );
  }

  // List<Widget> buildListNews(List<Map<String, dynamic>> details) {
  //   int i = 1;
  //   List<Widget> list = [];
  //   for (var item in details) {
  //     list.add(NewsTimeLine(
  //       details: item,
  //     ));

  //     i++;
  //   }
  //   return list;
  // }

  @override
  void onClose() {
    calendarModel.descNews.clear();
    listNews!.clear();
    print(listNews);
    super.onClose();
  }
}
