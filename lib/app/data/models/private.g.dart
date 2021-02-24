// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrivateAdapter extends TypeAdapter<Private> {
  @override
  final int typeId = 3;

  @override
  Private read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Private(
      id: fields[0] as String,
      type: fields[1] as String,
      password: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Private obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrivateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
