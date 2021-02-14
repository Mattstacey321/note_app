import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:hive/hive.dart';
import 'package:note_app/app/data/models/note.dart';

class NoteServices extends GetxService {
  Box<Note> noteBox = Hive.box('note');

  Future addNote(Note note) async {
    noteBox.add(
        Note(title: note.title, content: note.content, dateTime: DateTime.now(), type: note.type));
  }

  Future<List<Note>> getNote() async {
    return noteBox.values.toList();
  }
}
