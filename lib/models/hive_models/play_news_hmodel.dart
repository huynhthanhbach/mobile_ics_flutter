// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:mobile_ics_flutter/controllers/dashboard_controllers/device_controller.dart';

part 'play_news_hmodel.g.dart';

@HiveType(typeId: 5)
class PlayNewsHiveModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? idNews;

  @HiveField(2)
  String? timeTitle;

  @HiveField(3)
  String? status;

  @HiveField(4)
  String? volume;

  @HiveField(5)
  String? repeatMode;

  @HiveField(6)
  DateTime? createDate;

  @HiveField(7)
  String? prioritized;

  @HiveField(8)
  String? area;

  @HiveField(9)
  List<Device> listDevice = [];

  PlayNewsHiveModel({
    this.id,
    this.idNews,
    this.timeTitle,
    this.status,
    this.volume,
    this.repeatMode,
    this.createDate,
    this.prioritized,
    this.area,
  });

  PlayNewsHiveModel copyWith({
    String? id,
    String? idNews,
    String? timeTitle,
    String? status,
    String? volume,
    String? repeatMode,
    DateTime? createDate,
    String? prioritized,
    String? area,
  }) {
    return PlayNewsHiveModel(
      id: id ?? this.id,
      idNews: idNews ?? this.idNews,
      timeTitle: timeTitle ?? this.timeTitle,
      status: status ?? this.status,
      volume: volume ?? this.volume,
      repeatMode: repeatMode ?? this.repeatMode,
      createDate: createDate ?? this.createDate,
      prioritized: prioritized ?? this.prioritized,
      area: area ?? this.area,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idNews': idNews,
      'timeTitle': timeTitle,
      'status': status,
      'volume': volume,
      'repeatMode': repeatMode,
      'createDate': createDate?.millisecondsSinceEpoch,
      'prioritized': prioritized,
      'area': area,
    };
  }

  factory PlayNewsHiveModel.fromMap(Map<String, dynamic> map) {
    return PlayNewsHiveModel(
      id: map['id'] != null ? map['id'] as String : null,
      idNews: map['idNews'] != null ? map['idNews'] as String : null,
      timeTitle: map['timeTitle'] != null ? map['timeTitle'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      volume: map['volume'] != null ? map['volume'] as String : null,
      repeatMode:
          map['repeatMode'] != null ? map['repeatMode'] as String : null,
      createDate: map['createDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createDate'] as int)
          : null,
      prioritized:
          map['prioritized'] != null ? map['prioritized'] as String : null,
      area: map['area'] != null ? map['area'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayNewsHiveModel.fromJson(String source) =>
      PlayNewsHiveModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlayNewsHiveModel(id: $id, idNews: $idNews, timeTitle: $timeTitle, status: $status, volume: $volume, repeatMode: $repeatMode, createDate: $createDate, prioritized: $prioritized, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlayNewsHiveModel &&
        other.id == id &&
        other.idNews == idNews &&
        other.timeTitle == timeTitle &&
        other.status == status &&
        other.volume == volume &&
        other.repeatMode == repeatMode &&
        other.createDate == createDate &&
        other.prioritized == prioritized &&
        other.area == area;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idNews.hashCode ^
        timeTitle.hashCode ^
        status.hashCode ^
        volume.hashCode ^
        repeatMode.hashCode ^
        createDate.hashCode ^
        prioritized.hashCode ^
        area.hashCode;
  }
}
