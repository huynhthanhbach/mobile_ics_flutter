// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../controllers/operator_controllers/operator_controller.dart';
import 'component.dart';

var controller = Get.find<OperatorController>();
const newsTest1 = 'Bản tin thời sự đài truyền hình Việt Nam';

List<DropdownMenuItem<String>> newsList = const [
  DropdownMenuItem(value: '0', child: Text('+ Thêm bản tin')),
  DropdownMenuItem(
      value: '1', child: Text('Bản tin thời sự đài truyền hình Việt Nam')),
  DropdownMenuItem(value: '2', child: Text('Bản tin dự báo thời tiết')),
  DropdownMenuItem(value: '3', child: Text('Thông báo tiêm ngừa Covid 19')),
  DropdownMenuItem(value: '4', child: Text('Bản tin pháp luật và đời sống')),
  DropdownMenuItem(value: '5', child: Text('Thông tin cần biết và cảnh báo')),
];

List<DropdownMenuItem<String>> priorityList = const [
  DropdownMenuItem(value: '1', child: Text('Khẩn cấp')),
  DropdownMenuItem(value: '2', child: Text('Ưu tiên cao')),
  DropdownMenuItem(value: '3', child: Text('Ưu tiên thấp')),
];

// List<DropdownMenuItem<String>> timeOptions = [
//   const DropdownMenuItem(value: '1', child: PlayTimeButton()),
//   const DropdownMenuItem(value: '2', child: PlayCustomTimeButton()),
// ];

var categories = [
  'Thể thao',
  'Đời sống',
  'Pháp luật',
  'Cảnh báo',
  'Thời sự',
  'Thông tin',
];
var calenders = ['Hôm qua', 'Hôm nay', 'Trong tuần', 'Trong tháng'];
var devices = [
  'Cụm loa 1',
  'Cụm loa 2',
  'Cụm loa 3',
  'Cụm loa 4',
  'Cụm loa 5',
  'Cụm loa 6',
  'Cụm loa 7',
  'Cụm loa 8',
  'Cụm loa 9',
  'Cụm loa 10'
];

List<DropdownMenuItem<String>> categoriesList = [];
List<DropdownMenuItem<String>> calenderList = [];
List<DropdownMenuItem<String>> deviceList = [];

List<DropdownMenuItem<String>> repeatList = [
  const DropdownMenuItem(value: '-1', child: Text('Tự thiết lập')),
  const DropdownMenuItem(value: '0', child: Text('Một lần hôm nay')),
  const DropdownMenuItem(value: '1', child: Text('Một lần ngày mai')),
  const DropdownMenuItem(value: '2', child: Text('Lặp trong tuần')),
  const DropdownMenuItem(value: '3', child: Text('Lặp trong tháng')),
];

class Device {
  final String id;
  final String name;
  String getId() {
    return id;
  }

  String getName() {
    return name;
  }

  Device({
    required this.id,
    required this.name,
  });
}

//  List<Device> Devices = [
//   Device(id: '1', name: "Cụm loa 1"),
//   Device(id: '2', name: "Cụm loa 2"),
//   Device(id: '3', name: "Cụm loa 3"),
//   Device(id: '4', name: "Cụm loa 4"),
//   Device(id: '5', name: "Cụm loa 5"),
//   Device(id: '6', name: "Cụm loa 6"),
//   Device(id: '7', name: "Cụm loa 7"),
//   Device(id: '8', name: "Cụm loa 9"),
//   Device(id: '9', name: "Cụm loa 8"),
//   Device(id: '10', name: "Cụm loa 10"),
// ];
//  var device_items =
//     Devices.map((device) => MultiSelectItem<Device>(device, device.name))
//         .toList();
// List<Device> listDeviceSelected = [];

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

TimeOfDay selectedCustomTime = TimeOfDay.now();
