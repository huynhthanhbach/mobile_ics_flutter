// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BandwidthModel {
  int time;
  int value;
  BandwidthModel({
    required this.time,
    required this.value,
  });

  BandwidthModel copyWith({
    int? time,
    int? value,
  }) {
    return BandwidthModel(
      time: time ?? this.time,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'value': value,
    };
  }

  factory BandwidthModel.fromMap(Map<String, dynamic> map) {
    return BandwidthModel(
      time: map['time'] as int,
      value: map['value'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory BandwidthModel.fromJson(String source) =>
      BandwidthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BandwidthModel(time: $time, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BandwidthModel &&
        other.time == time &&
        other.value == value;
  }

  @override
  int get hashCode => time.hashCode ^ value.hashCode;
}
