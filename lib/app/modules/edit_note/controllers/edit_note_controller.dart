import 'package:get/get.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/services/note_services.dart';

class EditNoteController extends GetxController {
  String _noteId;
  EditNoteController(String noteId) : _noteId = noteId;
  NoteServices _noteServices = NoteServices();
  var note = Rx<Note>();

  void getNoteData() {
    note.value = _noteServices.getNoteById(_noteId);
  }

  @override
  void onReady() {
    getNoteData();
    super.onReady();
  }
}
