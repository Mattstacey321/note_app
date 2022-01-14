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
    var count = noteRelBox.values.where((e) => e.folderId == folderId).map((e) => e.noteId).length;
    return count;
  }

  List<String> getFolderByNoteId(String id) {
    var listFolderId =
        noteRelBox.values.where((e) => e.noteId == id).map((e) => e.folderId).toList();
    return folderBox.values
        .where((item) => listFolderId.contains(item.id))
        .map((e) => e.name)
        .toList();
  }

  List<Note> getNoteByFolderId(String id) {
    var listNoteId = noteRelBox.values.where((e) => e.folderId == id).map((e) => e.noteId).toList();
    return noteBox.values.where((item) => listNoteId.contains(item.id)).toList();
  }

  bool isNotePrivate(String noteId) {
    return privateBox.values.any((item) => item.id == noteId);
  }

  String getNotePassword(String noteId) {
    return privateBox.values.firstWhere((item) => item.id == noteId).password;
  }

  void addFolder(String name, {bool isPrivate = false, String pwd = ''}) {
    String id = uuid.v1();
    folderBox.put(id, NoteFolder(id: id, name: name, createdDate: DateTime.now()));
    if (isPrivate) privateBox.put(id, Private(id: id, password: pwd));
  }

  void editFolder(String id) {}

  void removeFolder(String id) {
    folderBox.delete(id);
    privateBox.delete(id);
  }

  bool isFolderPrivate(String id) {
    return privateBox.values.any((item) => item.id == id);
  }

  String getFolderPassword(String id) {
    return privateBox.values.firstWhere((item) => item.id == id).password;
  }

  void updateNote(Note note) {
    if (!note.isPrivate) {
      privateBox.delete(note.id);
    }
    noteBox
        .get(note.id)
        ?.copyWith(title: note.title, content: note.content, tasks: note.tasks)
        .save();
  }

  void updateFolder(NoteFolder folder) {
    if (!folder.isPrivate) {
      privateBox.delete(folder.id);
    }
    folderBox.get(folder.id)?.copyWith(name: folder.name);
  }

  void removeNote(String noteId) {}
}
