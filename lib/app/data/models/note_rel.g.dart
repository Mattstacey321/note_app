// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_rel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteRelAdapter extends TypeAdapter<NoteRel> {
  @override
  final int typeId = 4;

  @override
  NoteRel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteRel(
      noteId: fields[0] as String,
      folderId: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteRel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.noteId)
      ..writeByte(1)
      ..write(obj.folderId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteRelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
