// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'news_hmodel.g.dart';

@HiveType(typeId: 0)
class NewsHiveModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? type;

  @HiveField(3)
  String? author;

  @HiveField(4)
  String? content;

  @HiveField(5)
  DateTime? createDate;

  @HiveField(6)
  String? duration;

  @HiveField(7)
  String? status;

  @HiveField(8)
  String? area;

  @HiveField(9)
  String? url;
  NewsHiveModel({
    this.id,
    this.name,
    this.type,
    this.author,
    this.content,
    this.createDate,
    this.duration,
    this.status,
    this.area,
    this.url,
  });

  NewsHiveModel copyWith({
    String? id,
    String? name,
    String? type,
    String? author,
    String? content,
    DateTime? createDate,
    String? duration,
    String? status,
    String? area,
    String? url,
  }) {
    return NewsHiveModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      author: author ?? this.author,
      content: content ?? this.content,
      createDate: createDate ?? this.createDate,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      area: area ?? this.area,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'author': author,
      'content': content,
      'createDate': createDate?.millisecondsSinceEpoch,
      'duration': duration,
      'status': status,
      'area': area,
      'url': url,
    };
  }

  factory NewsHiveModel.fromMap(Map<String, dynamic> map) {
    return NewsHiveModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      author: map['author'] != null ? map['author'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      createDate: map['createDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createDate'] as int)
          : null,
      duration: map['duration'] != null ? map['duration'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      area: map['area'] != null ? map['area'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsHiveModel.fromJson(String source) =>
      NewsHiveModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewsHiveModel(id: $id, name: $name, type: $type, author: $author, content: $content, createDate: $createDate, duration: $duration, status: $status, area: $area, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsHiveModel &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.author == author &&
        other.content == content &&
        other.createDate == createDate &&
        other.duration == duration &&
        other.status == status &&
        other.area == area &&
        other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        author.hashCode ^
        content.hashCode ^
        createDate.hashCode ^
        duration.hashCode ^
        status.hashCode ^
        area.hashCode ^
        url.hashCode;
  }
}
