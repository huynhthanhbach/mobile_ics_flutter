// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/views/operator/components/component.dart';
import 'package:mobile_ics_flutter/views/operator/components/tempdb.dart';
import 'package:oktoast/oktoast.dart';

class OperatorController extends GetxController {
  late bool flag;
  String? newsSelected;
  String? repeatSelected;
  String? prioritySelected;
  RxDouble volumeSelected = 70.0.obs;
  String calenderFilter = '-1';
  String timeFilter = '-1';
  String categoriesFilter = '-1';
  String deviceFilter = '-1';
  List<String> selectedTime = [];
  List<String> filter = ['Tất cả', 'Tất cả', 'Tất cả', 'Tất cả'];
  var timePicker = TimeOfDay.now().obs;
  DateTimeRange? datePicker;
  RxInt deviceCounter = 0.obs;

  void countDevice() {
    deviceCounter.value = listDeviceSelected.length;
  }

  //Tao filter
  void addFilter() {
    filter = ['Tất cả', 'Tất cả', 'Tất cả', 'Tất cả'];
    List<String> temp = [];
    (categoriesFilter == '-1')
        ? temp.add('Tất cả')
        : temp.add(categories[int.parse(categoriesFilter)]);
    (timeFilter == '-1')
        ? temp.add('Tất cả')
        : temp.add(times[int.parse(timeFilter)]);
    (deviceFilter == '-1')
        ? temp.add('Tất cả')
        : temp.add(calenders[int.parse(calenderFilter)]);
    (deviceFilter == '-1')
        ? temp.add('Tất cả')
        : temp.add(devices[int.parse(deviceFilter)]);
    filter = temp.toList();
    print(filter);
    update();
  }

  @override
  void onInit() {
    flag = true;

    //Khoi tao cac dropdownbuttonitem list
    initItem();

    super.onInit();
  }

  void pressButton() {
    flag ? flag = false : flag = true;
    update();
  }

  void printNewsPlayed() {
    var deviceSelected = <String>[];
    for (var item in listDeviceSelected) {
      deviceSelected.add(item.name.toString());
    }
    deviceSelected.sort();
    print(
        'Lịch phát: \n + Bản tin: $newsSelected\n + Thiết bị: ${deviceSelected.toString()}\n + Khung giờ: ${timePicker.toString().substring(10, 15)}\n + Độ lớn: $volumeSelected\n + Lặp: $repeatSelected $datePicker\n + Ưu tiên: $prioritySelected');
  }

  void Select(name, value) {
    switch (name) {
      case 'newsSelected':
        if (value == '0') {
          showToast('Route to News Manager!');
        } else {
          newsSelected = value;
        }
        break;
      case 'repeatSelected':
        value == '-1' ? chooseDateRange() : repeatSelected = value;
        break;
      case 'prioritySelected':
        prioritySelected = value;
        break;
      default:
    }
    update();
  }

  void Filt(name, value) {
    switch (name) {
      case 'calenderFilter':
        calenderFilter = value;
        break;
      case 'timeFilter':
        timeFilter = value;
        break;
      case 'categoriesFilter':
        categoriesFilter = value;
        break;
      case 'deviceFilter':
        deviceFilter = value;
        break;
      default:
    }
    update();
  }

  //Hien bottomsheet
  Future showBottomSheet(BuildContext context, Widget child) async {
    Get.bottomSheet(
      child,
      isScrollControlled: true,
      ignoreSafeArea: true,
      barrierColor: Colors.black26,
    );
  }

  //Chon gio
  chooseTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: timePicker.value,
        helpText: 'THÊM KHUNG GIỜ PHÁT',
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child!);
        });
    if (pickedTime != null && pickedTime != timePicker.value) {
      timePicker.value = pickedTime;
    }
  }

  //chon khoang ngay
  void chooseDateRange() async {
    final DateTimeRange? pickedDate = await showDateRangePicker(
        context: Get.context!,
        firstDate: DateTime.now(),
        lastDate: (DateTime.now()).add(const Duration(days: 365)),
        currentDate: DateTime.now(),
        initialDateRange: datePicker,
        saveText: 'Done',
        builder: (context, child) {
          return Theme(data: ThemeData.light(), child: child!);
        });

    if (pickedDate != null) {
      // Rebuild the UI
      // print(pickedDate.start.toString());
      // print(pickedDate.end.toString());
      datePicker = pickedDate;
      repeatSelected = '-1';
    }
  }
}
