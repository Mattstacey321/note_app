import 'package:get/get.dart';
import 'package:note_app/app/modules/add_note/controllers/add_to_folder_controller.dart';

class AddNoteBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddToFolderController());
  }
}
