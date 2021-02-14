// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteFolderAdapter extends TypeAdapter<NoteFolder> {
  @override
  final int typeId = 2;

  @override
  NoteFolder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteFolder(
      folderName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteFolder obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.folderName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteFolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
