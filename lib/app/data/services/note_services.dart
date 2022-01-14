import 'package:hive/hive.dart';
import 'package:note_app/app/constraints/hive_box_name.dart';
import 'package:note_app/app/data/models/folder.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/models/note_rel.dart';
import 'package:note_app/app/data/models/private.dart';
import 'package:note_app/app/data/services/index.dart';

class NoteServices {
  var noteBox = Hive.box<Note>(HiveBoxName.noteBox);
  var privateBox = Hive.box<Private>(HiveBoxName.privateBox);
  var folderBox = Hive.box<NoteFolder>(HiveBoxName.noteFolder);
  var noteRelBox = Hive.box<NoteRel>(HiveBoxName.noteRelBox);
  final _baseServices = BaseServices();

  Future addNote(Note note, {required Private value, required List<String> folderIds}) async {
    noteBox.put(
      note.id,
      Note(
        id: note.id,
        title: note.title,
        content: note.content,
        dateTime: DateTime.now(),
        tasks: note.tasks,
      ),
    );

    for (var id in folderIds) {
      noteRelBox.add(NoteRel(noteId: note.id, folderId: id));
    }

    if (value.password != "")
      privateBox.add(
        Private(
          id: note.id,
          password: value.password,
        ),
      );
  }

  List<Note> getNotes() {
    return noteBox.values
        .map((e) => e.copyWith(isPrivate: _baseServices.isNotePrivate(e.id)))
        .toList();
  }

  Note getNoteById(String noteId) {
    return noteBox.values.firstWhere((item) => item.id == noteId);
  }

  void removeNote(String noteId) {
    //remove anything relate with noteId
    noteBox.delete(noteId);
    noteRelBox.values.toList().removeWhere((item) => item.noteId == noteId);
    privateBox.delete(noteId);
  }
}
