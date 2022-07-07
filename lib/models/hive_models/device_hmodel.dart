// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'device_hmodel.g.dart';

@HiveType(typeId: 2)
class DeviceHiveModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? type;

  @HiveField(3)
  String? typePlay;

  @HiveField(4)
  String? status;

  @HiveField(5)
  DateTime? createDate;

  @HiveField(6)
  String? area;
  DeviceHiveModel({
    this.id,
    this.name,
    this.type,
    this.typePlay,
    this.status,
    this.createDate,
    this.area,
  });

  DeviceHiveModel copyWith({
    String? id,
    String? name,
    String? type,
    String? typePlay,
    String? status,
    DateTime? createDate,
    String? area,
  }) {
    return DeviceHiveModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      typePlay: typePlay ?? this.typePlay,
      status: status ?? this.status,
      createDate: createDate ?? this.createDate,
      area: area ?? this.area,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'typePlay': typePlay,
      'status': status,
      'createDate': createDate?.millisecondsSinceEpoch,
      'area': area,
    };
  }

  factory DeviceHiveModel.fromMap(Map<String, dynamic> map) {
    return DeviceHiveModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      typePlay: map['typePlay'] != null ? map['typePlay'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      createDate: map['createDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createDate'] as int)
          : null,
      area: map['area'] != null ? map['area'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceHiveModel.fromJson(String source) =>
      DeviceHiveModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeviceHiveModel(id: $id, name: $name, type: $type, typePlay: $typePlay, status: $status, createDate: $createDate, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeviceHiveModel &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.typePlay == typePlay &&
        other.status == status &&
        other.createDate == createDate &&
        other.area == area;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        typePlay.hashCode ^
        status.hashCode ^
        createDate.hashCode ^
        area.hashCode;
  }
}
