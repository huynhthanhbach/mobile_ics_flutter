// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CalendarModel {
  String id;
  String name;
  String level;
  DateTime createTime;
  String status;

  List<Map<String, dynamic>> descNews = [];
  CalendarModel({
    required this.id,
    required this.name,
    required this.level,
    required this.createTime,
    required this.status,
  });

  CalendarModel copyWith({
    String? id,
    String? name,
    String? level,
    DateTime? createTime,
    String? status,
  }) {
    return CalendarModel(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      createTime: createTime ?? this.createTime,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'level': level,
      'createTime': createTime.millisecondsSinceEpoch,
      'status': status,
    };
  }

  factory CalendarModel.fromMap(Map<String, dynamic> map) {
    return CalendarModel(
      id: map['id'] as String,
      name: map['name'] as String,
      level: map['level'] as String,
      createTime: DateTime.fromMillisecondsSinceEpoch(map['createTime'] as int),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CalendarModel.fromJson(String source) =>
      CalendarModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CalendarModel(id: $id, name: $name, level: $level, createTime: $createTime, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarModel &&
        other.id == id &&
        other.name == name &&
        other.level == level &&
        other.createTime == createTime &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        level.hashCode ^
        createTime.hashCode ^
        status.hashCode;
  }
}
