// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:math';

import 'package:get/get.dart';
import 'package:mobile_ics_flutter/core/services/hive_calendar.dart';
import 'package:mobile_ics_flutter/core/services/hive_device.dart';
import 'package:mobile_ics_flutter/core/services/hive_play_news.dart';
import 'package:mobile_ics_flutter/views/operator/components/component.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:oktoast/oktoast.dart';
import 'package:uuid/uuid.dart';
import '../../core/services/hive_news.dart';
import '../../models/hive_models/hive_model.dart';

class OperatorController extends GetxController {
  bool choosingNews = false;
  HiveNews hiveNews = HiveNews();
  HiveDevice hiveDevice = HiveDevice();
  HiveCalendar hiveCalender = HiveCalendar();
  HivePlayNews hivePlayNews = HivePlayNews();
  PlayNewsHiveModel? playNewsCalender;
  RxBool flag = true.obs;
  RxBool checkFiler = false.obs;
  NewsHiveModel? newsHiveSelected;
  RxString newsSelected = ''.obs;
  String? repeatSelected;
  String? prioritySelected;
  String? timeRepeat;
  List<String> timeSelected = [];
  RxDouble volumeSelected = 70.0.obs;
  String calenderFilter = '-1';
  String timeFilter = '-1';
  String categoriesFilter = '-1';
  String deviceFilter = '-1';
  List<String> times = [
    '05h00 - 08h30',
    '11h00 - 12h00',
    '16h00 - 19h30',
    '21h00 - 23h30'
  ];
  List<DropdownMenuItem<String>> priorityList = const [
    DropdownMenuItem(value: '0', child: Text('Khẩn cấp')),
    DropdownMenuItem(value: '1', child: Text('Ưu tiên cao')),
    DropdownMenuItem(value: '2', child: Text('Ưu tiên thấp')),
  ];
  var categories = [
    'Thể thao',
    'Đời sống',
    'Pháp luật',
    'Cảnh báo',
    'Thời sự',
    'Thông tin',
  ];
  var calenders = ['Hôm qua', 'Hôm nay', 'Trong tuần', 'Trong tháng'];
  List<DropdownMenuItem<String>> categoriesList = [];
  List<DropdownMenuItem<String>> calenderList = [];
  List<DropdownMenuItem<String>> deviceList = [];

  List<DropdownMenuItem<String>> repeatList = [
    const DropdownMenuItem(value: '-1', child: Text('Tự thiết lập')),
    const DropdownMenuItem(value: '0', child: Text('Một lần hôm nay')),
    const DropdownMenuItem(value: '1', child: Text('Một lần ngày mai')),
    const DropdownMenuItem(value: '2', child: Text('Trong 1 tuần')),
    const DropdownMenuItem(value: '3', child: Text('Trong 1 tháng')),
  ];
  List<DropdownMenuItem<String>> timeList = [];
  List<MultiSelectItem<Time>> time_items = [];
  List<MultiSelectItem<DeviceHiveModel>> deviceItem = [];
  List<MultiSelectItem<DeviceHiveModel>> filtDeviceItem = [];
  List<DeviceHiveModel> listDeviceSelected = [];
  List<DeviceHiveModel> listFiltDeviceSelected = [];

  List<Time> listTimeSelected = [];

  RxList<NewsHiveModel> listNews = <NewsHiveModel>[].obs;
  List<DeviceHiveModel> listDevice = <DeviceHiveModel>[];
  RxList<PlayNewsHiveModel> listPlayNews = <PlayNewsHiveModel>[].obs;
  RxList<PlayNewsHiveModel> listPlayNewsToday = <PlayNewsHiveModel>[].obs;
  RxList<PlayNewsHiveModel> listPlayNewsFilted = <PlayNewsHiveModel>[].obs;
  //RxList<PlayNewsHiveModel> filtedPlayNews = <PlayNewsHiveModel>[].obs;
  bool filted = false;
  List<String> selectedTime = <String>[];
  List<String> filter = ['Tất cả', 'Tất cả', 'Tất cả', 'Tất cả'];
  var timePicker = TimeOfDay.now().obs;
  DateTimeRange? datePicker;
  RxInt deviceCounter = 0.obs;
  RxInt filtDeviceCounter = 0.obs;
  RxInt timeCounter = 0.obs;

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

    times = temp.toList();
    Times = initTime().toList();
    time_items =
        Times.map((time) => MultiSelectItem<Time>(time, time.name)).toList();
    update();
  }

  void countDevice() {
    deviceCounter.value = listDeviceSelected.length;
  }

  void countFiltDevice() {
    filtDeviceCounter.value = listFiltDeviceSelected.length;
  }

  void countTime() {
    timeCounter.value = listTimeSelected.length;
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
        : ((timeFilter == '-2')
            ? temp.add('Khung giờ khác')
            : temp.add(times[int.parse(timeFilter)]));
    (calenderFilter == '-1')
        ? temp.add('Tất cả')
        : temp.add(calenders[int.parse(calenderFilter)]);
    (filtDeviceCounter.value == 0)
        ? temp.add('Tất cả')
        : temp.add('Thiết bị: ${listFiltDeviceSelected.length}');
    filter = temp.toList();
    // filter = getFilterList().toList();
    //print(filter);
    //print(listFiltDeviceSelected);

    listPlayNewsFilted.value = getListPlayNewsFilted().toList();
    update();
    //print(listPlayNewsFilted);
  }

  @override
  Future<void> onInit() async {
    //lay data news
    List<NewsHiveModel> listN = await hiveNews.get();
    if (listN.isNotEmpty) {
      listNews.value = listN.toList();
    }
    //lay data device
    List<DeviceHiveModel> listD = await hiveDevice.get();
    if (listD.isNotEmpty) {
      listDevice = listD.toList();
    }
    //lay data play news
    List<PlayNewsHiveModel> listP = await hivePlayNews.get();
    if (listP.isNotEmpty) {
      listPlayNews.value = listP.toList();
    }
    listPlayNewsToday.value = getListPlayNewsToday();
    Times = initTime().toList();
    time_items =
        Times.map((time) => MultiSelectItem<Time>(time, time.name)).toList();

    //Khoi tao cac dropdownbuttonitem list
    initListItem();
    //khoi tao multiselect item

    deviceItem = getDeviceList().toList();
    filtDeviceItem = getDeviceList().toList();

    //tao play news list today
    listPlayNewsToday.value = getListPlayNewsToday();
    listPlayNewsFilted.value = listPlayNews.toList();
    super.onInit();
  }

  void pressButton() {
    flag.value ? flag.value = false : flag.value = true;
    // update();
  }

  void addPlayNewsData() async {
    var flag = await hivePlayNews.addPlayNewsToHive(playNewsCalender!);
    if (flag) {
      clearSelect();
      print('${playNewsCalender!.id} -- thanh cong');
      print('list device length: ${playNewsCalender!.listDevice.length}');
      print('----------------------');
      print('');
    } else {
      print('${playNewsCalender!.id} -- that bai');
    }
  }

  bool checkPlayNews() {
    bool check = true;
    if (newsHiveSelected == null) check = false;
    if (newsSelected.value == '') check = false;
    if (deviceCounter.value == 0) check = false;
    if (listDeviceSelected == []) check = false;
    if (repeatSelected == null) check = false;
    if (prioritySelected == null) check = false;
    if (timeRepeat == null) check = false;
    if (timeSelected.isEmpty) check = false;

    return check;
  }

  void clearSelect() {
    // newsHiveSelected = null;
    // newsSelected = ''.obs;
  }

  void printNewsPlayed() {
    var deviceSelected = <String>[];
    for (var item in listDeviceSelected) {
      deviceSelected.add(item.name.toString());
    }
    deviceSelected.sort();
    // print(
    //     'Lịch phát: \n + Bản tin: ${newsSelected.value}\n + Thiết bị: ${deviceSelected.toString()}\n + Khung giờ: ${timeSelected.toString()}\n + Độ lớn: $volumeSelected\n + Lặp: $repeatSelected $datePicker\n + Ưu tiên: $prioritySelected');
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
        value == '-1' ? chooseDateRange() : addRepeatTime(value);
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
      // print(times.toString());
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
      datePicker = pickedDate;
      addRepeatTime('-1');
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
    filted = false;
    listPlayNewsFilted.value = listPlayNews;
    update();
  }

  //init list item

  void initListItem() {
    categoriesList = initItem(categories).toList();
    timeList = initItem(times).toList();
    timeList.add(const DropdownMenuItem(
        value: '-2',
        child: Text(
          'Khác',
          style: textStyle4,
        )));
    calenderList = initItem(calenders).toList();
  }

  List<DropdownMenuItem<String>> initItem(List<String> list) {
    int i = 0;
    List<DropdownMenuItem<String>> listTemp = [];

    listTemp.add(const DropdownMenuItem(
        value: '-1',
        child: Text(
          'Tất cả',
          style: textStyle4,
        )));

    for (var item in list) {
      listTemp.add(DropdownMenuItem(
          value: '$i',
          child: Text(
            item,
            style: textStyle4,
          )));
      i++;
    }
    return listTemp;
  }

  //tao list multi select
  List<MultiSelectItem<DeviceHiveModel>> getDeviceList() {
    List<MultiSelectItem<DeviceHiveModel>> temp = [];
    for (var item in listDevice) {
      temp.add(MultiSelectItem(item, item.name!));
    }
    return temp;
  }

  void addPlayNews() {
    playNewsCalender = _addPlayNews(
        newsHiveSelected!.id!,
        volumeSelected.value,
        timeSelected.toString(),
        timeRepeat!,
        prioritySelected!,
        listDeviceSelected);
    // print(playNewsCalender);
    // print(playNewsCalender!.listDevice);
  }

  PlayNewsHiveModel _addPlayNews(String newsId, double volume, String time,
      String repeat, String priority, List<DeviceHiveModel> device) {
    const uid = Uuid();
    var i = Random().nextBool();
    var obj = PlayNewsHiveModel(
      id: uid.v1(),
      idNews: newsId,
      timeTitle: time,
      status: 'Chưa phát',
      volume: volume.round().toString(),
      repeatMode: repeat,
      prioritized: priority == '0'
          ? 'Khẩn cấp'
          : (priority == '1' ? 'Ưu tiên cao' : 'Ưu tiên thấp'),
      area: i ? 'Cấp xã' : 'Cấp huyện',
      createDate: DateTime.now(),
    );
    obj.listDevice = device.toList();
    return obj;
  }

  void addRepeatTime(value) {
    timeRepeat = '';
    switch (value) {
      case '-1':
        timeRepeat = '';
        var star = datePicker!.start;
        var end = datePicker!.end;
        timeRepeat =
            '${star.toString().substring(0, 10)} - ${end.toString().substring(0, 10)}';
        repeatSelected = value;
        // print(timeRepeat);
        break;
      case '0':
        timeRepeat = '';
        var star = DateTime.now();
        var end = DateTime.now();
        timeRepeat =
            '${star.toString().substring(0, 10)} - ${end.toString().substring(0, 10)}';
        repeatSelected = value;
        // print(timeRepeat);
        break;
      case '1':
        timeRepeat = '';
        var star = DateTime.now().add(const Duration(days: 1));
        var end = DateTime.now().add(const Duration(days: 1));
        timeRepeat =
            '${star.toString().substring(0, 10)} - ${end.toString().substring(0, 10)}';
        repeatSelected = value;
        // print(timeRepeat);
        break;
      case '2':
        timeRepeat = '';
        var star = DateTime.now();
        var end = DateTime.now().add(const Duration(days: 7));
        timeRepeat =
            '${star.toString().substring(0, 10)} - ${end.toString().substring(0, 10)}';
        repeatSelected = value;
        // print(timeRepeat);
        break;
      case '3':
        timeRepeat = '';
        var star = DateTime.now();
        var end = DateTime.now().add(const Duration(days: 30));
        timeRepeat =
            '${star.toString().substring(0, 10)} - ${end.toString().substring(0, 10)}';
        repeatSelected = value;
        // print(timeRepeat);
        break;
      default:
    }
  }

  NewsHiveModel getNews(String id) {
    NewsHiveModel news = NewsHiveModel();
    for (var item in listNews) {
      if (item.id == id) news = item;
    }
    return news;
  }

  List<PlayNewsHiveModel> getListPlayNewsToday() {
    List<PlayNewsHiveModel> temp = [];
    DateTime today = DateTime.parse(
        '${DateTime.now().toString().substring(0, 10)} 00:00:00.000');
    for (var item in listPlayNews) {
      var start =
          DateTime.parse('${item.repeatMode!.substring(0, 10)} 00:00:00.000');
      var end =
          DateTime.parse('${item.repeatMode!.substring(13, 23)} 00:00:00.000');
      // print('$start $end $today');
      // print((start.isBefore(today) && end.isAfter(today)));
      // print(start.isAtSameMomentAs(today) || end.isAtSameMomentAs(today));
      if ((start.isBefore(today) && end.isAfter(today)) ||
          start.isAtSameMomentAs(today) ||
          end.isAtSameMomentAs(today)) {
        temp.add(item);
      }
    }
    temp.sort((a, b) {
      return b.createDate!.compareTo(a.createDate!);
    });
    return temp;
  }

  Future<void> updateListPlayNewsToday() async {
    List<PlayNewsHiveModel> listP = await hivePlayNews.get();
    if (listP.isNotEmpty) {
      listPlayNews.value = listP.toList();
    }
    listPlayNewsToday.value = getListPlayNewsToday();
  }

  void filt() {
    listPlayNewsFilted.value = getListPlayNewsFilted().toList();
    filted = true;
  }

  List<PlayNewsHiveModel> getListPlayNewsFilted() {
    List<PlayNewsHiveModel> temp = [];
    var category = filter[0];
    var time = filter[1];
    var calender = filter[2];

    //loc category
    for (var item in listPlayNews) {
      if (category != 'Tất cả') {
        if (getNews(item.idNews!).type == category) {
          temp.add(item);
        }
      } else {
        temp = listPlayNews.toList();
      }
    }

    //loc khung gio
    List<PlayNewsHiveModel> temp2 = [];
    for (var item in temp) {
      switch (time) {
        case 'Tất cả':
          temp2 = temp.toList();
          break;
        case 'Khung giờ khác':
          if (item.timeTitle!.length < 13) {
            temp2.add(item);
          }
          break;
        default:
          if (item.timeTitle!.contains(time)) {
            temp2.add(item);
          }
      }
    }
    temp = temp2.toList();
    temp2 = [];

    //loc thoi gian

    for (var item in temp) {
      switch (calender) {
        case 'Tất cả':
          temp2.add(item);
          break;
        case 'Hôm nay':
          DateTime start = DateTime.parse(
              '${DateTime.now().toString().substring(0, 10)} 00:00:00.000');
          DateTime end = DateTime.parse(
              '${DateTime.now().toString().substring(0, 10)} 00:00:00.000');
          if (checkTimeOverlap(start, end, item)) {
            temp2.add(item);
          }
          break;
        case 'Hôm qua':
          DateTime start = DateTime.parse(
              '${DateTime.now().subtract(const Duration(days: 1)).toString().substring(0, 10)} 00:00:00.000');
          DateTime end = DateTime.parse(
              '${DateTime.now().subtract(const Duration(days: 1)).toString().substring(0, 10)} 00:00:00.000');
          if (checkTimeOverlap(start, end, item)) {
            temp2.add(item);
          }
          break;
        case 'Trong tuần':
          DateTime start = DateTime.parse(
              '${DateTime.now().subtract(const Duration(days: 7)).toString().substring(0, 10)} 00:00:00.000');
          DateTime end = DateTime.parse(
              '${DateTime.now().toString().substring(0, 10)} 00:00:00.000');
          if (checkTimeOverlap(start, end, item)) {
            temp2.add(item);
          }
          break;

        case 'Trong tháng':
          DateTime start = DateTime.parse(
              '${DateTime.now().subtract(const Duration(days: 30)).toString().substring(0, 10)} 00:00:00.000');
          DateTime end = DateTime.parse(
              '${DateTime.now().toString().substring(0, 10)} 00:00:00.000');
          if (checkTimeOverlap(start, end, item)) {
            temp2.add(item);
          }
          break;
        default:
      }
    }
    temp = temp2.toList();
    temp2 = [];

    //loc theo thiet bi

    if (filtDeviceCounter.value == 0) {
      temp2 = temp.toList();
    } else {
      for (var device in listFiltDeviceSelected) {
        for (var item in temp2) {
          if (checkDeviceInList(device, item.listDevice)) {
            temp2.add(item);
          }
        }
      }
    }
    temp = temp2.toList();
    temp2 = [];

    //sap xep theo ngay tao
    temp.sort((a, b) {
      return b.createDate!.compareTo(a.createDate!);
    });
    return temp;
  }

  bool checkDeviceInList(DeviceHiveModel device, List<DeviceHiveModel> list) {
    bool check = false;
    for (var item in list) {
      if (item.id == device.id) {
        check = true;
        break;
      }
    }
    return check;
  }

  bool checkTimeOverlap(
      DateTime start1, DateTime end1, PlayNewsHiveModel item) {
    // var start1 = DateTime.parse('${calender.substring(0, 10)} 00:00:00.000');
    // var end1 = DateTime.parse('${calender.substring(13, 23)} 00:00:00.000');

    var start2 =
        DateTime.parse('${item.repeatMode!.substring(0, 10)} 00:00:00.000');
    var end2 =
        DateTime.parse('${item.repeatMode!.substring(13, 23)} 00:00:00.000');
// print('$start $end $today');
    // print((start.isBefore(today) && end.isAfter(today)));
    // print(start.isAtSameMomentAs(today) || end.isAtSameMomentAs(today));
    bool check = (start1.isAtSameMomentAs(end2) || start1.isBefore(end2)) &&
        (end1.isAtSameMomentAs(start2) || end1.isAfter(start2));
    return check;
  }
}

class Time {
  final String id;
  final String name;
  String getId() {
    return id;
  }

  String getName() {
    return name;
  }

  Time({
    required this.id,
    required this.name,
  });
}
