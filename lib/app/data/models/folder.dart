import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'folder.g.dart';

@HiveType(typeId: 2)
class NoteFolder extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String folderName;
  NoteFolder({@required this.id, @required this.folderName});
}
