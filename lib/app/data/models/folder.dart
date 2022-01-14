import 'package:hive/hive.dart';
part 'folder.g.dart';

@HiveType(typeId: 2)
class NoteFolder extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  DateTime createdDate;
  bool isPrivate;
  NoteFolder(
      {required this.id, required this.name, required this.createdDate, this.isPrivate = false});
  NoteFolder copyWith({String? id, String? name, bool? isPrivate, DateTime? createdDate}) =>
      NoteFolder(
        id: id ?? this.id,
        name: name ?? this.name,
        createdDate: createdDate ?? this.createdDate,
        isPrivate: isPrivate ?? this.isPrivate,
      );
}
