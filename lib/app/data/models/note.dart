import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  @HiveField(2)
  DateTime dateTime;
  @HiveField(3)
  bool isPrivate;
  @HiveField(4)
  String type;
  @HiveField(5)
  List<Task> tasks;
  Note({
    @required this.title,
    @required this.content,
    @required this.dateTime,
    this.isPrivate = false,
    @required this.type,
  });
}

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  bool isDone;
  Task({@required this.title, this.isDone = false});
}
