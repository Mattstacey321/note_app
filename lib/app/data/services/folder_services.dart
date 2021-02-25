import 'package:hive/hive.dart';
import 'package:note_app/app/constraints/hive_box_name.dart';
import 'package:note_app/app/data/models/folder.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/services/base_services.dart';

class FolderServices {
  var folderBox = Hive.box<NoteFolder>(HiveBoxName.noteFolder);
  BaseServices _baseServices = BaseServices();

  List<NoteFolder> getFolder() {
    return folderBox.values.toList();
  }

  List<Note> getNoteByFolderId(String id) {
    return _baseServices.getNoteByFolderId(id);
  }

  void add(String name, {bool isPrivate, String pwd}) {
    _baseServices.addFolder(name, isPrivate: isPrivate, pwd: pwd);
  }

  void edit(String id) {
    _baseServices.editFolder(id);
  }

  void remove(String id) {
    _baseServices.removeFolder(id);
  }
}
