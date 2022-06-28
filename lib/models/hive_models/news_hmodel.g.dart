// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_hmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsHiveModelAdapter extends TypeAdapter<NewsHiveModel> {
  @override
  final int typeId = 0;

  @override
  NewsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsHiveModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      type: fields[2] as String?,
      author: fields[3] as String?,
      content: fields[4] as String?,
      createDate: fields[5] as DateTime?,
      duration: fields[6] as String?,
      status: fields[7] as String?,
      area: fields[8] as String?,
      url: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NewsHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.content)
      ..writeByte(5)
      ..write(obj.createDate)
      ..writeByte(6)
      ..write(obj.duration)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.area)
      ..writeByte(9)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
