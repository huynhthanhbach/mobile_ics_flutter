// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_hmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarHiveModelAdapter extends TypeAdapter<CalendarHiveModel> {
  @override
  final int typeId = 4;

  @override
  CalendarHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarHiveModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      createDate: fields[2] as DateTime?,
      status: fields[3] as String?,
      area: fields[4] as String?,
    )
      ..descNews = (fields[5] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList()
      ..listNews = (fields[6] as List).cast<NewsHiveModel>();
  }

  @override
  void write(BinaryWriter writer, CalendarHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createDate)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.area)
      ..writeByte(5)
      ..write(obj.descNews)
      ..writeByte(6)
      ..write(obj.listNews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
