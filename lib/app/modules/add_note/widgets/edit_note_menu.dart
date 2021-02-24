import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:note_app/app/global_widgets/circle_icon.dart';
import 'package:note_app/app/modules/add_note/controllers/add_note_controller.dart';

class EditNoteMenu extends GetView<AddNoteController> {
  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (res) {
        return res.value
        //when task mode is true
            ? Container(
                height: 56,
                child: Row(
                  children: <Widget>[
                    CircleIcon(
                      onTap: () {
                        controller.addMoreTask();
                      },
                      tooltip: "Add task",
                      icon: Icon(
                        EvaIcons.bulb,
                      ),
                    ),
                    Spacer(),
                    CircleIcon(
                      tooltip: "Disable task mode",
                      onTap: () {
                        controller.taskMode.toggle();
                      },
                      icon: Icon(
                        EvaIcons.arrowDown,
                      ),
                    ),
                  ],
                ),
              )
            //when task mode is false
            : Container(
                height: 56,
                child: Row(
                  children: <Widget>[
                    CircleIcon(
                      tooltip: "Switch task mode",
                      onTap: () {
                        controller.switchTaskMode();
                      },
                      icon: Icon(EvaIcons.hashOutline),
                    ),
                    CircleIcon(
                      tooltip: "Add image",
                      onTap: () {
                        controller.addImage();
                      },
                      icon: Icon(EvaIcons.image2),
                    ),
                  ],
                ),
              );
      },
      controller.taskMode,
    );
  }
}
