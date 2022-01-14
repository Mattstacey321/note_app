import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:note_app/app/modules/edit_note/controllers/edit_note_controller.dart';

class UpdateButton extends GetView<EditNoteController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool isEditMode = !controller.editMode.value;
        bool anyChange = controller.anyChange.value;
        return GestureDetector(
          onTap: isEditMode
              ? () {
                  controller.editMode.value = true;
                }
              : () {
                  controller.updateNote();
                },
          child: isEditMode
              ? Text("Edit")
              : Text(
                  "Change",
                  style: TextStyle(color: anyChange ? Colors.white : Colors.grey),
                ),
        );
      },
    );
  }
}
