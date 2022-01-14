import 'package:get/get.dart';
import 'package:note_app/app/modules/add_note/controllers/add_note_controller.dart';

class EditNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddNoteController());
  }
}
