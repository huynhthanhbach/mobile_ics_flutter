// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_news_hmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayNewsHiveModelAdapter extends TypeAdapter<PlayNewsHiveModel> {
  @override
  final int typeId = 5;

  @override
  PlayNewsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayNewsHiveModel(
      id: fields[0] as String?,
      idNews: fields[1] as String?,
      timeTitle: fields[2] as String?,
      status: fields[3] as String?,
      volume: fields[4] as String?,
      repeatMode: fields[5] as String?,
      createDate: fields[6] as DateTime?,
      prioritized: fields[7] as String?,
      area: fields[8] as String?,
    )..listDevice = (fields[9] as List).cast<DeviceHiveModel>();
  }

  @override
  void write(BinaryWriter writer, PlayNewsHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idNews)
      ..writeByte(2)
      ..write(obj.timeTitle)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.volume)
      ..writeByte(5)
      ..write(obj.repeatMode)
      ..writeByte(6)
      ..write(obj.createDate)
      ..writeByte(7)
      ..write(obj.prioritized)
      ..writeByte(8)
      ..write(obj.area)
      ..writeByte(9)
      ..write(obj.listDevice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayNewsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
