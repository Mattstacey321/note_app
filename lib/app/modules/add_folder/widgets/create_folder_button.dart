import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:note_app/app/modules/add_folder/controllers/add_folder_controller.dart';

class CreateFolderButton extends GetView<AddFolderController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ObxValue(
          (res) {
            return Text("Create",style: TextStyle(color: !res.value ? Colors.white : Colors.grey),);
          },
          controller.isFolderNameEmpty,
        ),
      ],
    );
  }
}
