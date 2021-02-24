import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String content;
  @HiveField(3)
  DateTime dateTime;
  @HiveField(4)
  List<Task> tasks;
  Note({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.dateTime,
    @required this.tasks,
  });
}

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  bool isDone;
  Task({this.id, @required this.title, this.isDone = false});
}
