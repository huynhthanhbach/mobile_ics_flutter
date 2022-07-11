// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

import '../../../controllers/operator_controllers/operator_controller.dart';
import 'component.dart';

var controller = Get.find<OperatorController>();
const newsTest1 = 'Bản tin thời sự đài truyền hình Việt Nam';

List<DropdownMenuItem<String>> priorityList = const [
  DropdownMenuItem(value: '0', child: Text('Khẩn cấp')),
  DropdownMenuItem(value: '1', child: Text('Ưu tiên cao')),
  DropdownMenuItem(value: '2', child: Text('Ưu tiên thấp')),
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
  const DropdownMenuItem(value: '2', child: Text('Trong 1 tuần')),
  const DropdownMenuItem(value: '3', child: Text('Trong 1 tháng')),
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
