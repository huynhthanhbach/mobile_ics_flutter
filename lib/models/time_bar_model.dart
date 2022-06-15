// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TimeBarModel {
  String text;
  String num;

  bool now = false;
  TimeBarModel({
    required this.text,
    required this.num,
  });

  TimeBarModel copyWith({
    String? text,
    String? num,
  }) {
    return TimeBarModel(
      text: text ?? this.text,
      num: num ?? this.num,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'num': num,
    };
  }

  factory TimeBarModel.fromMap(Map<String, dynamic> map) {
    return TimeBarModel(
      text: map['text'] as String,
      num: map['num'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeBarModel.fromJson(String source) =>
      TimeBarModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TimeBarModel(text: $text, num: $num)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TimeBarModel && other.text == text && other.num == num;
  }

  @override
  int get hashCode => text.hashCode ^ num.hashCode;
}
