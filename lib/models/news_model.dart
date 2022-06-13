// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class NewsModel {
  final String type;
  final String status;
  final int amount;
  final Color barColor;
  NewsModel({
    required this.type,
    required this.status,
    required this.amount,
    required this.barColor,
  });

  NewsModel copyWith({
    String? type,
    String? status,
    int? amount,
    Color? barColor,
  }) {
    return NewsModel(
      type: type ?? this.type,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      barColor: barColor ?? this.barColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'status': status,
      'amount': amount,
      'barColor': barColor.value,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      type: map['type'] as String,
      status: map['status'] as String,
      amount: map['amount'] as int,
      barColor: Color(map['barColor'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewsModel(type: $type, status: $status, amount: $amount, barColor: $barColor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsModel &&
        other.type == type &&
        other.status == status &&
        other.amount == amount &&
        other.barColor == barColor;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        status.hashCode ^
        amount.hashCode ^
        barColor.hashCode;
  }
}
