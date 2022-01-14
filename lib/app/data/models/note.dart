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
  bool isPrivate;
  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.dateTime,
      required this.tasks,
      this.isPrivate = false});

  Note copyWith(
          {String? id,
          String? title,
          List<Task>? tasks,
          String? content,
          DateTime? dateTime,
          bool? isPrivate}) =>
      Note(
        id: id ?? this.id,
        content: content ?? this.content,
        dateTime: dateTime ?? this.dateTime,
        tasks: tasks ?? this.tasks,
        title: title ?? this.title,
        isPrivate: isPrivate ?? this.isPrivate,
      );
}

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  bool isDone;
  Task({required this.id, required this.title, this.isDone = false});
  Task copyWith({String? id, String? title, bool? isDone}) =>
      Task(title: title ?? this.title, id: id ?? this.id, isDone: isDone ?? this.isDone);
}
