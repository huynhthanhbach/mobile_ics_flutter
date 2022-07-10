// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';
part 'bandwidth_hmodel.g.dart';

@HiveType(typeId: 3)
class BandwidthHiveModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  DateTime? createDate;

  @HiveField(2)
  String? area;

  @HiveField(3)
  double? total;

  BandwidthHiveModel({
    this.id,
    this.createDate,
    this.area,
    this.total,
  });

  BandwidthHiveModel copyWith({
    String? id,
    DateTime? createDate,
    String? area,
    double? total,
  }) {
    return BandwidthHiveModel(
      id: id ?? this.id,
      createDate: createDate ?? this.createDate,
      area: area ?? this.area,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createDate': createDate?.millisecondsSinceEpoch,
      'area': area,
      'total': total,
    };
  }

  factory BandwidthHiveModel.fromMap(Map<String, dynamic> map) {
    return BandwidthHiveModel(
      id: map['id'] != null ? map['id'] as String : null,
      createDate: map['createDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createDate'] as int)
          : null,
      area: map['area'] != null ? map['area'] as String : null,
      total: map['total'] != null ? map['total'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BandwidthHiveModel.fromJson(String source) =>
      BandwidthHiveModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BandwidthHiveModel(id: $id, createDate: $createDate, area: $area, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BandwidthHiveModel &&
        other.id == id &&
        other.createDate == createDate &&
        other.area == area &&
        other.total == total;
  }

  @override
  int get hashCode {
    return id.hashCode ^ createDate.hashCode ^ area.hashCode ^ total.hashCode;
  }
}
