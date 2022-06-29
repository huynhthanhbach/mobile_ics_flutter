// ignore_for_file: non_constant_identifier_names

import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'component.dart';

List<DropdownMenuItem<String>> newsList = const [
  DropdownMenuItem(
      value: '0', child: Text('Bản tin thời sự đài truyền hình Việt Nam')),
  DropdownMenuItem(value: '1', child: Text('Bản tin dự báo thời tiết')),
  DropdownMenuItem(value: '2', child: Text('Thông báo tiêm ngừa Covid 19')),
  DropdownMenuItem(value: '3', child: Text('Bản tin pháp luật và đời sống')),
  DropdownMenuItem(value: '4', child: Text('Thông tin cần biết và cảnh báo')),
];

List<DropdownMenuItem<String>> priorityList = const [
  DropdownMenuItem(value: '1', child: Text('Khẩn cấp')),
  DropdownMenuItem(value: '2', child: Text('Ưu tiên cao')),
  DropdownMenuItem(value: '3', child: Text('Ưu tiên thấp')),
];

List<DropdownMenuItem<String>> timeList = const [
  DropdownMenuItem(value: '0', child: Text('Tất cả')),
  DropdownMenuItem(value: '1', child: Text('5h - 8h30')),
  DropdownMenuItem(value: '2', child: Text('11h - 12h')),
  DropdownMenuItem(value: '3', child: Text('16h - 19h30')),
  DropdownMenuItem(value: '4', child: Text('21h - 23h30')),
];

List<DropdownMenuItem<String>> categoriesList = const [
  DropdownMenuItem(value: '0', child: Text('Tất cả')),
  DropdownMenuItem(value: '1', child: Text('Thể thao')),
  DropdownMenuItem(value: '2', child: Text('Đời sống')),
  DropdownMenuItem(value: '3', child: Text('Pháp luật')),
  DropdownMenuItem(value: '4', child: Text('Cảnh báo')),
  DropdownMenuItem(value: '5', child: Text('Thời sự')),
  DropdownMenuItem(value: '6', child: Text('Thông tin')),
];

List<DropdownMenuItem<String>> repeatList = const [
  DropdownMenuItem(value: '0', child: Text('Một lần hôm nay')),
  DropdownMenuItem(value: '1', child: Text('Một lần ngày mai')),
  DropdownMenuItem(value: '2', child: Text('Lặp trong tuần')),
  DropdownMenuItem(value: '3', child: Text('Lặp trong tháng')),
];

List<DropdownMenuItem<String>> deviceList = const [
  DropdownMenuItem(value: '0', child: Text("Tất cả")),
  DropdownMenuItem(value: '1', child: Text("Cụm loa 1")),
  DropdownMenuItem(value: '2', child: Text("Cụm loa 2")),
  DropdownMenuItem(value: '3', child: Text("Cụm loa 3")),
  DropdownMenuItem(value: '4', child: Text("Cụm loa 4")),
  DropdownMenuItem(value: '5', child: Text("Cụm loa 5")),
  DropdownMenuItem(value: '6', child: Text("Cụm loa 6")),
  DropdownMenuItem(value: '7', child: Text("Cụm loa 7")),
  DropdownMenuItem(value: '8', child: Text("Cụm loa 8")),
  DropdownMenuItem(value: '9', child: Text("Cụm loa 9")),
  DropdownMenuItem(value: '10', child: Text("Cụm loa 10")),
  DropdownMenuItem(value: '11', child: Text("Cụm loa 11")),
  DropdownMenuItem(value: '12', child: Text("Cụm loa 12")),
  DropdownMenuItem(value: '13', child: Text("Cụm loa 13")),
  DropdownMenuItem(value: '14', child: Text("Cụm loa 14")),
  DropdownMenuItem(value: '15', child: Text("Cụm loa 15")),
  DropdownMenuItem(value: '16', child: Text("Cụm loa 16")),
  DropdownMenuItem(value: '17', child: Text("Cụm loa 17")),
  DropdownMenuItem(value: '18', child: Text("Cụm loa 18")),
  DropdownMenuItem(value: '19', child: Text("Cụm loa 19")),
];

class Device {
  final int id;
  final String name;

  Device({
    required this.id,
    required this.name,
  });
}

final List<Device> Devices = [
  Device(id: 1, name: "Cụm loa 1"),
  Device(id: 2, name: "Cụm loa 2"),
  Device(id: 3, name: "Cụm loa 3"),
  Device(id: 4, name: "Cụm loa 4"),
  Device(id: 5, name: "Cụm loa 5"),
  Device(id: 6, name: "Cụm loa 6"),
  Device(id: 7, name: "Cụm loa 7"),
  Device(id: 8, name: "Cụm loa 9"),
  Device(id: 9, name: "Cụm loa 8"),
  Device(id: 10, name: "Cụm loa 10"),
  Device(id: 11, name: "Cụm loa 11"),
  Device(id: 12, name: "Cụm loa 12"),
  Device(id: 13, name: "Cụm loa 13"),
  Device(id: 14, name: "Cụm loa 14"),
  Device(id: 15, name: "Cụm loa 15"),
  Device(id: 16, name: "Cụm loa 16"),
  Device(id: 17, name: "Cụm loa 17"),
  Device(id: 18, name: "Cụm loa 18"),
  Device(id: 19, name: "Cụm loa 19"),
  Device(id: 20, name: "Cụm loa 20"),
  Device(id: 21, name: "Cụm loa 21"),
  Device(id: 22, name: "Cụm loa 22"),
  Device(id: 23, name: "Cụm loa 23"),
  Device(id: 24, name: "Cụm loa 24"),
  Device(id: 25, name: "Cụm loa 25"),
  Device(id: 26, name: "Cụm loa 26"),
  Device(id: 27, name: "Cụm loa 27"),
];
final device_items =
    Devices.map((device) => MultiSelectItem<Device>(device, device.name))
        .toList();

class Time {
  final int id;
  final String name;

  Time({
    required this.id,
    required this.name,
  });
}

final List<Time> Timess = [
  Time(id: 1, name: "5h - 8h30"),
  Time(id: 2, name: "11h - 12h"),
  Time(id: 3, name: "16h - 19h30"),
  Time(id: 4, name: "21h - 23h30"),
];
final time_items =
    Timess.map((time) => MultiSelectItem<Time>(time, time.name)).toList();

List<DropdownMenuItem<String>> calenderList = const [
  DropdownMenuItem(value: '0', child: Text('Hôm nay')),
  DropdownMenuItem(value: '1', child: Text('Trong tuần')),
  DropdownMenuItem(value: '2', child: Text('Trong tháng')),
  DropdownMenuItem(
    value: '3',
    child: Text('Vào ngày: '),
  ),
];
