import 'package:hive/hive.dart';
import 'package:note_app/app/constraints/hive_box_name.dart';
import 'package:note_app/app/data/models/folder.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/services/base_services.dart';
import 'package:uuid/uuid.dart';

class FolderServices {
  var uuid = Uuid();
  var folderBox = Hive.box<NoteFolder>(HiveBoxName.noteFolder);
  BaseServices _baseServices = BaseServices();

  List<NoteFolder> getFolder() {
    return folderBox.values.toList();
  }

  List<Note> getNoteByFolderId(String id) {
    return _baseServices.getNoteByFolderId(id);
  }

  void add(String name) {
    String id = uuid.v1();
    folderBox.put(id, NoteFolder(id: id, folderName: name));
  }

  void remove(String id) {
    folderBox.delete(id);
  }
}
