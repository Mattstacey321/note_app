import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/constraints/navigator_key.dart';
import 'package:note_app/app/modules/add_note/controllers/add_note_controller.dart';
import 'package:note_app/app/modules/add_note/views/add_to_folder.dart';
import 'package:note_app/app/modules/add_note/views/note_content.dart';
import 'package:note_app/app/utils/dialog_utils.dart';

class AddNoteView extends StatelessWidget {
  final controller = Get.put<AddNoteController>(AddNoteController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return DialogUtils()
            .isNoteHasContent(controller.pages.isEmpty, controller.isTaskTitleEmpty.value);
      },
      child: Navigator(
        key: Get.nestedKey(NavigatorKey.addNoteKey),
        onGenerateRoute: (settings) {
          if (settings.name == "/")
            return GetPageRoute(
              settings: settings,
              page: () => NoteContent(),
            );
          else
            return GetPageRoute(
              settings: settings,
              page: () => AddToFolder(),
            );
        },
      ),
    );
  }
}
