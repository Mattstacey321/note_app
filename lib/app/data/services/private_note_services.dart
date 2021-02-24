import 'package:hive/hive.dart';
import 'package:note_app/app/constraints/hive_box_name.dart';
import 'package:note_app/app/data/models/private.dart';

class PrivateNoteServices {
  var privateBox = Hive.box<Private>(HiveBoxName.privateBox);

  bool isPrivateNote(String id){
    return privateBox.values.contains((item) => item.noteId == id);
  }
}
