// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_ics_flutter/views/operator/components/component.dart';
import 'package:mobile_ics_flutter/views/operator/components/tempdb.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:oktoast/oktoast.dart';

import '../../core/services/hive_news.dart';
import '../../models/hive_models/hive_model.dart';

class OperatorController extends GetxController {
  HiveNews hiveNews = HiveNews();
  RxBool flag = true.obs;
  RxBool checkFiler = false.obs;
  RxString newsSelected = ''.obs;
  String? repeatSelected;
  String? prioritySelected;
  RxDouble volumeSelected = 70.0.obs;
  String calenderFilter = '-1';
  String timeFilter = '-1';
  String categoriesFilter = '-1';
  String deviceFilter = '-1';
  List<String> times = ['5h - 8h30', '11h - 12h', '16h - 19h30', '21h - 23h30'];
  List<DropdownMenuItem<String>> timeList = [];
  List<MultiSelectItem<Time>> time_items = [];

  List<Time> listTimeSelected = [];
  // Map<String, String> filterValue = {
  //   'categories': '-1',
  //   'calenders': '-1',
  //   'devices': '-1',
  //   'times': '-1'
  // };
  RxList<NewsHiveModel> listNews = <NewsHiveModel>[].obs;
  List<String> selectedTime = [];
  List<String> filter = ['Tất cả', 'Tất cả', 'Tất cả', 'Tất cả'];
  var timePicker = TimeOfDay.now().obs;
  DateTimeRange? datePicker;
  RxInt deviceCounter = 0.obs;
  RxInt timeCounter = 0.obs;

  // final List<Time> Times = [
  //   Time(id: '0', name: "5h - 8h30"),
  //   Time(id: '1', name: "11h - 12h"),
  //   Time(id: '2', name: "16h - 19h30"),
  //   Time(id: '3', name: "21h - 23h30"),
  // ];
  List<Time> Times = [];

  List<Time> initTime() {
    List<Time> temp = [];
    int i = 0;
    for (var item in times) {
      temp.add(
        Time(id: '$i', name: item),
      );
    }
    return temp;
  }

  void addTime(String time) {
    List<String> temp = times.toList();
    temp.add(time);
    temp.sort();
    times = temp.toList();
    Times = initTime().toList();
    time_items =
        Times.map((time) => MultiSelectItem<Time>(time, time.name)).toList();
    update();
  }

  void countDevice() {
    deviceCounter.value = listDeviceSelected.length;
  }

  void countTime() {
    timeCounter.value = listTimeSelected.length;
  }

  // String getFilter(List list, String value) {
  //   String text = '';
  //   value == '1'
  //       ? text = 'Tất cả'
  //       : (value == '-2' ? text = 'Khác' : text = list[int.parse(value)]);
  //   return text;
  // }

  // List<String> getFilterList() {
  //   List<String> temp = [];
  //   temp.addAll([getFilter(categories, filterValue['categories']!)]);
  //   temp.addAll([getFilter(times, filterValue['times']!)]);
  //   temp.addAll([getFilter(calenders, filterValue['calenders']!)]);
  //   temp.addAll([getFilter(devices, filterValue['devices']!)]);
  //   return temp;
  // }

  //Tao filter
  void addFilter() {
    filter = ['Tất cả', 'Tất cả', 'Tất cả', 'Tất cả'];
    List<String> temp = [];
    (categoriesFilter == '-1')
        ? temp.add('Tất cả')
        : temp.add(categories[int.parse(categoriesFilter)]);
    (timeFilter == '-1')
        ? temp.add('Tất cả')
        : ((timeFilter == '-2')
            ? temp.add('Khung giờ khác')
            : temp.add(times[int.parse(timeFilter)]));
    (calenderFilter == '-1')
        ? temp.add('Tất cả')
        : temp.add(calenders[int.parse(calenderFilter)]);
    (deviceFilter == '-1')
        ? temp.add('Tất cả')
        : temp.add(devices[int.parse(deviceFilter)]);
    filter = temp.toList();
    // filter = getFilterList().toList();
    print(filter);
    update();
  }

  @override
  Future<void> onInit() async {
    Times = initTime().toList();
    time_items =
        Times.map((time) => MultiSelectItem<Time>(time, time.name)).toList();

    //Khoi tao cac dropdownbuttonitem list

    initListItem();

    //lay data news
    List<NewsHiveModel> list = await hiveNews.get();
    if (list.isNotEmpty) {
      listNews.value = list.toList();
    }

    super.onInit();
  }

  void pressButton() {
    flag.value ? flag.value = false : flag.value = true;
    update();
  }

  void printNewsPlayed() {
    var deviceSelected = <String>[];
    for (var item in listDeviceSelected) {
      deviceSelected.add(item.name.toString());
    }
    deviceSelected.sort();
    print(
        'Lịch phát: \n + Bản tin: ${newsSelected.value}\n + Thiết bị: ${deviceSelected.toString()}\n + Khung giờ: ${timePicker.toString().substring(10, 15)}\n + Độ lớn: $volumeSelected\n + Lặp: $repeatSelected $datePicker\n + Ưu tiên: $prioritySelected');
  }

  void Select(name, value) {
    switch (name) {
      case 'newsSelected':
        if (value == '0') {
          showToast('Route to News Manager!');
        } else {
          newsSelected.value = value;
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
      String tempString = timePicker.value.toString().substring(10, 15);
      String tempTime =
          '${tempString.substring(0, 2)}h${tempString.substring(3, 5)}';
      addTime(tempTime);
      print(times.toString());
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

  void checkFilter() {
    bool result = false;
    for (var item in filter) {
      if (item != 'Tất cả') {
        result = true;
      }
    }
    result ? checkFiler.value = true : checkFiler.value = false;
  }

  void deleteFilter() {
    filter = ['Tất cả', 'Tất cả', 'Tất cả', 'Tất cả'];
    calenderFilter = '-1';
    timeFilter = '-1';
    categoriesFilter = '-1';
    deviceFilter = '-1';
    update();
  }

  //init list item

  void initListItem() {
    categoriesList = initItem(categories).toList();
    timeList = initItem(times).toList();
    timeList.add(
        const DropdownMenuItem(value: '-2', child: Text('Khung giờ khác')));
    calenderList = initItem(calenders).toList();
    deviceList = initItem(devices).toList();
  }

  List<DropdownMenuItem<String>> initItem(List<String> list) {
    int i = 0;
    List<DropdownMenuItem<String>> listTemp = [];

    listTemp.add(const DropdownMenuItem(value: '-1', child: Text('Tất cả')));

    for (var item in list) {
      listTemp.add(DropdownMenuItem(value: '$i', child: Text(item)));
      i++;
    }
    return listTemp;
  }
}
