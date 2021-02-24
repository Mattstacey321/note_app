import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:note_app/app/modules/add_note/controllers/add_note_controller.dart';

class NoteContentComponent extends GetView<AddNoteController> {
  const NoteContentComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.contentCtrl,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onChanged: (value) => controller.countNoteText(value),
      decoration: InputDecoration.collapsed(hintText: "Write a note"),
    );
  }
}
