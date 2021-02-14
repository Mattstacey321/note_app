import 'package:hive/hive.dart';
import 'package:note_app/app/data/models/folder.dart';

class FolderServices {
  Box<NoteFolder> folderBox = Hive.box('folder');

  Future<List<NoteFolder>> getFolder() async {
    return folderBox.values.toList();
  }
}
