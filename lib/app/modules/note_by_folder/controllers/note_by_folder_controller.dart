import 'package:get/get.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/services/folder_services.dart';

class NoteByFolderController extends GetxController {
  String _folderId;
  NoteByFolderController(String folderId) : _folderId = folderId;
  FolderServices _folderServices = FolderServices();
  var notes = <Note>[].obs;

  void initData() {
    final listNote = _folderServices.getNoteByFolderId(_folderId);
    notes.addAll(listNote);
  }

  @override
  void onReady() {
    initData();
    super.onReady();
  }
}
