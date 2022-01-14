import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/constraints/navigator_key.dart';
import 'package:note_app/app/modules/add_note/controllers/add_note_controller.dart';

class NextButton extends GetView<AddNoteController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ObxValue<RxBool>(
          (res) {
            return GestureDetector(
              onTap: res.value
                  ? () {
                      Get.toNamed("/add-to-folder", id: NavigatorKey.addNoteKey);
                    }
                  : null,
              child: Text(
                "Next",
                style: TextStyle(
                  color: res.value ? Colors.white : Colors.grey,
                ),
              ),
            );
          },
          controller.canNextStep,
        ),
      ],
    );
  }
}
