import 'package:hive/hive.dart';
part 'folder.g.dart';

@HiveType(typeId: 2)
class NoteFolder extends HiveObject{
  @HiveField(0)
  String folderName;
  NoteFolder({this.folderName});
}
