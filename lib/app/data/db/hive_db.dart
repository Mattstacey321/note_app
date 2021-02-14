import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:note_app/app/data/models/folder.dart';
import 'package:note_app/app/data/models/note.dart';

class HiveDb {
  static Future init() async {
    Hive..registerAdapter(NoteAdapter())..registerAdapter(NoteFolderAdapter());
    await Hive.openBox<Note>('note');
    await Hive.openBox<NoteFolder>('folder');
    //await Get.putAsync(() => ConfigServices().initializeDownloader());
  }
}
