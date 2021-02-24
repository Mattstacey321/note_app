import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/app/constraints/hive_box_name.dart';
import 'package:note_app/app/data/models/folder.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/models/note_rel.dart';
import 'package:note_app/app/data/models/private.dart';

class NoteServices {
  var noteBox = Hive.box<Note>(HiveBoxName.noteBox);
  var privateBox = Hive.box<Private>(HiveBoxName.privateBox);
  var folderBox = Hive.box<NoteFolder>(HiveBoxName.noteFolder);
  var noteRelBox = Hive.box<NoteRel>(HiveBoxName.noteRelBox);

  Future addNote(Note note, {Private value, @required List<String> folderIds}) async {
    noteBox.add(
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
    return noteBox.values.toList();
  }

  Note getNoteById(String noteId) {
    return noteBox.values.firstWhere((item) => item.id == noteId);
  }
}
