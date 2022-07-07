// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_hmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeviceHiveModelAdapter extends TypeAdapter<DeviceHiveModel> {
  @override
  final int typeId = 2;

  @override
  DeviceHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceHiveModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      type: fields[2] as String?,
      typePlay: fields[3] as String?,
      status: fields[4] as String?,
      createDate: fields[5] as DateTime?,
      area: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DeviceHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.typePlay)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.createDate)
      ..writeByte(6)
      ..write(obj.area);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
