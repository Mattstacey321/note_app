import 'package:hive/hive.dart';
import 'package:note_app/app/constraints/hive_box_name.dart';
import 'package:note_app/app/data/models/folder.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/models/note_rel.dart';
import 'package:note_app/app/data/models/private.dart';
import 'package:uuid/uuid.dart';

class BaseServices {
  var uuid = Uuid();
  var noteBox = Hive.box<Note>(HiveBoxName.noteBox);
  var privateBox = Hive.box<Private>(HiveBoxName.privateBox);
  var folderBox = Hive.box<NoteFolder>(HiveBoxName.noteFolder);
  var noteRelBox = Hive.box<NoteRel>(HiveBoxName.noteRelBox);

  int countNoteByFolder(String folderId) {
    int count = 0;
    return count;
  }

  List<String> getFolderByNoteId(String id) {
    var listFolderId =
        noteRelBox.values.where((e) => e.noteId == id).map((e) => e.folderId).toList();
    print(listFolderId);
    return folderBox.values
        .where((item) => listFolderId.contains(item.id))
        .map((e) => e.folderName)
        .toList();
  }

  List<Note> getNoteByFolderId(String id) {
    var listNoteId = noteRelBox.values.where((e) => e.folderId == id).map((e) => e.noteId).toList();
    print(listNoteId);
    return noteBox.values.where((item) => listNoteId.contains(item.id)).toList();
  }

  Private isNotePrivate(String noteId) {
    return privateBox.values.firstWhere((item) => item.id == noteId, orElse: () => null);
  }

  void addFolder(String name, {bool isPrivate, String pwd}) {
    String id = uuid.v1();
    folderBox.put(id, NoteFolder(id: id, folderName: name));
    if (isPrivate) privateBox.put(id, Private(id: id, password: pwd));
  }

  void editFolder(String id) {}

  void removeFolder(String id) {
    folderBox.delete(id);
    privateBox.delete(id);
  }

  Private isFolderPrivate(String id){
    return privateBox.values.firstWhere((item) => item.id == id, orElse: () => null);

  }
}
