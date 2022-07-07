// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warning_hmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WarningHiveModelAdapter extends TypeAdapter<WarningHiveModel> {
  @override
  final int typeId = 1;

  @override
  WarningHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WarningHiveModel(
      id: fields[0] as String?,
      idDevice: fields[1] as String?,
      name: fields[2] as String?,
      content: fields[3] as String?,
      type: fields[4] as String?,
      level: fields[5] as String?,
      createDate: fields[6] as DateTime?,
      completedTime: fields[7] as DateTime?,
      status: fields[8] as String?,
      area: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WarningHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idDevice)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.level)
      ..writeByte(6)
      ..write(obj.createDate)
      ..writeByte(7)
      ..write(obj.completedTime)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.area);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WarningHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
