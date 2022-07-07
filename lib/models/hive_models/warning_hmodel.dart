// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'warning_hmodel.g.dart';

@HiveType(typeId: 1)
class WarningHiveModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? idDevice;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? content;

  @HiveField(4)
  String? type;

  @HiveField(5)
  String? level;

  @HiveField(6)
  DateTime? createDate;

  @HiveField(7)
  DateTime? completedTime;

  @HiveField(8)
  String? status;

  @HiveField(9)
  String? area;
  WarningHiveModel({
    this.id,
    this.idDevice,
    this.name,
    this.content,
    this.type,
    this.level,
    this.createDate,
    this.completedTime,
    this.status,
    this.area,
  });

  WarningHiveModel copyWith({
    String? id,
    String? idDevice,
    String? name,
    String? content,
    String? type,
    String? level,
    DateTime? createDate,
    DateTime? completedTime,
    String? status,
    String? area,
  }) {
    return WarningHiveModel(
      id: id ?? this.id,
      idDevice: idDevice ?? this.idDevice,
      name: name ?? this.name,
      content: content ?? this.content,
      type: type ?? this.type,
      level: level ?? this.level,
      createDate: createDate ?? this.createDate,
      completedTime: completedTime ?? this.completedTime,
      status: status ?? this.status,
      area: area ?? this.area,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idDevice': idDevice,
      'name': name,
      'content': content,
      'type': type,
      'level': level,
      'createDate': createDate?.millisecondsSinceEpoch,
      'completedTime': completedTime?.millisecondsSinceEpoch,
      'status': status,
      'area': area,
    };
  }

  factory WarningHiveModel.fromMap(Map<String, dynamic> map) {
    return WarningHiveModel(
      id: map['id'] != null ? map['id'] as String : null,
      idDevice: map['idDevice'] != null ? map['idDevice'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      level: map['level'] != null ? map['level'] as String : null,
      createDate: map['createDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createDate'] as int)
          : null,
      completedTime: map['completedTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['completedTime'] as int)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      area: map['area'] != null ? map['area'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WarningHiveModel.fromJson(String source) =>
      WarningHiveModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WarningHiveModel(id: $id, idDevice: $idDevice, name: $name, content: $content, type: $type, level: $level, createDate: $createDate, completedTime: $completedTime, status: $status, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WarningHiveModel &&
        other.id == id &&
        other.idDevice == idDevice &&
        other.name == name &&
        other.content == content &&
        other.type == type &&
        other.level == level &&
        other.createDate == createDate &&
        other.completedTime == completedTime &&
        other.status == status &&
        other.area == area;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idDevice.hashCode ^
        name.hashCode ^
        content.hashCode ^
        type.hashCode ^
        level.hashCode ^
        createDate.hashCode ^
        completedTime.hashCode ^
        status.hashCode ^
        area.hashCode;
  }
}
