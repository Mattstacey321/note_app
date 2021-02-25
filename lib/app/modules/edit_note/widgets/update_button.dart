import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:note_app/app/modules/edit_note/controllers/edit_note_controller.dart';

class UpdateButton extends GetView<EditNoteController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // change note
        controller.updateNote();
      },
      child: Text("Change"),
    );
  }
}
