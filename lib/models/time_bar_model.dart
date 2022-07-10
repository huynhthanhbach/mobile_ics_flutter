// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TimeBarModel {
  String date;
  String day;
  String month;
  String year;

  bool now = false;
  TimeBarModel({
    required this.date,
    required this.day,
    required this.month,
    required this.year,
  });

  TimeBarModel copyWith({
    String? date,
    String? day,
    String? month,
    String? year,
  }) {
    return TimeBarModel(
      date: date ?? this.date,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'day': day,
      'month': month,
      'year': year,
    };
  }

  factory TimeBarModel.fromMap(Map<String, dynamic> map) {
    return TimeBarModel(
      date: map['date'] as String,
      day: map['day'] as String,
      month: map['month'] as String,
      year: map['year'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeBarModel.fromJson(String source) =>
      TimeBarModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TimeBarModel(date: $date, day: $day, month: $month, year: $year)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeBarModel &&
        other.date == date &&
        other.day == day &&
        other.month == month &&
        other.year == year;
  }

  @override
  int get hashCode {
    return date.hashCode ^ day.hashCode ^ month.hashCode ^ year.hashCode;
  }
}
