// 1 to many note - folder
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'note_rel.g.dart';

@HiveType(typeId: 4)
class NoteRel {
  @HiveField(0)
  String noteId;
  @HiveField(1)
  String folderId;
  NoteRel({@required this.noteId, @required this.folderId});
}
