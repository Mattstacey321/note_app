import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:note_app/app/global_widgets/custom_app_bar.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends GetView<EditNoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childs: [],
      ),
      body: Container(),
    );
  }
}
