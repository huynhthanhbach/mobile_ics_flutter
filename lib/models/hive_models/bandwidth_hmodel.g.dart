// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bandwidth_hmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BandwidthHiveModelAdapter extends TypeAdapter<BandwidthHiveModel> {
  @override
  final int typeId = 3;

  @override
  BandwidthHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BandwidthHiveModel(
      id: fields[0] as String?,
      createDate: fields[1] as DateTime?,
      area: fields[2] as String?,
      total: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, BandwidthHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createDate)
      ..writeByte(2)
      ..write(obj.area)
      ..writeByte(3)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BandwidthHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
