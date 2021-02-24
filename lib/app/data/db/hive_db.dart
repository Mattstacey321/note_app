import 'package:hive/hive.dart';
import 'package:note_app/app/constraints/hive_box_name.dart';
import 'package:note_app/app/data/models/folder.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/models/note_rel.dart';
import 'package:note_app/app/data/models/private.dart';

class HiveDb {
  static Future init() async {
    Hive
      ..registerAdapter(NoteAdapter())
      ..registerAdapter(TaskAdapter())
      ..registerAdapter(NoteFolderAdapter())
      ..registerAdapter(PrivateAdapter())
      ..registerAdapter(NoteRelAdapter());
    await Hive.openBox<Note>(HiveBoxName.noteBox);
    await Hive.openBox<NoteFolder>(HiveBoxName.noteFolder);
    await Hive.openBox<Private>(HiveBoxName.privateBox);
    await Hive.openBox<NoteRel>(HiveBoxName.noteRelBox);
    await Hive.openBox(HiveBoxName.settingBox);

    //await Get.putAsync(() => ConfigServices().initializeDownloader());
  }
}
