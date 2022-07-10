// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mobile_ics_flutter/models/hive_models/hive_model.dart';
part 'calendar_hmodel.g.dart';

@HiveType(typeId: 4)
class CalendarHiveModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  DateTime? createDate;

  @HiveField(3)
  String? status;

  @HiveField(4)
  String? area;

  @HiveField(5)
  List<Map<String, dynamic>> descNews = [];

  @HiveField(6)
  List<NewsHiveModel> listNews = [];

  CalendarHiveModel({
    this.id,
    this.name,
    this.createDate,
    this.status,
    this.area,
  });

  CalendarHiveModel copyWith({
    String? id,
    String? name,
    DateTime? createDate,
    String? status,
    String? area,
  }) {
    return CalendarHiveModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createDate: createDate ?? this.createDate,
      status: status ?? this.status,
      area: area ?? this.area,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createDate': createDate?.millisecondsSinceEpoch,
      'status': status,
      'area': area,
    };
  }

  factory CalendarHiveModel.fromMap(Map<String, dynamic> map) {
    return CalendarHiveModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      createDate: map['createDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createDate'] as int)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      area: map['area'] != null ? map['area'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CalendarHiveModel.fromJson(String source) =>
      CalendarHiveModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CalendarHiveModel(id: $id, name: $name, createDate: $createDate, status: $status, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarHiveModel &&
        other.id == id &&
        other.name == name &&
        other.createDate == createDate &&
        other.status == status &&
        other.area == area;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        createDate.hashCode ^
        status.hashCode ^
        area.hashCode;
  }
}
