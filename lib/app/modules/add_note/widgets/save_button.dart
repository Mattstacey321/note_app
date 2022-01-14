import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/global_widgets/circle_icon.dart';
import 'package:note_app/app/modules/add_note/controllers/add_note_controller.dart';
import 'package:note_app/app/modules/add_note/controllers/add_to_folder_controller.dart';

class SaveButton extends GetView<AddNoteController> {
  @override
  Widget build(BuildContext context) {
    var addToFolderCtrl = Get.find<AddToFolderController>();
    return Row(
      children: [
        CircleIcon(
          onTap: () {
            addToFolderCtrl.createFolder();
          },
          tooltip: "Add folder",
          icon: Icon(
            EvaIcons.folderAdd,
            color: Colors.grey,
          ),
        ),
        SizedBox(width: 10),
        ObxValue<RxBool>(
          (res) {
            return CircleIcon(
              onTap: () {
                controller.lockNote();
              },
              tooltip: "Lock note",
              icon: Icon(
                res.value ? EvaIcons.lock : EvaIcons.lockOutline,
                color: Colors.grey,
              ),
            );
          },
          controller.isPrivateNote,
        ),
        SizedBox(width: 10),
        CircleIcon(
          onTap: () {},
          tooltip: "Save to cloud",
          icon: Icon(
            EvaIcons.archiveOutline,
            color: Colors.grey,
          ),
        ),
        SizedBox(width: 10),
        ObxValue<RxList<String>>(
          (res) {
            return GestureDetector(
              onTap: res.isEmpty
                  ? null
                  : () {
                      controller.saveNote();
                    },
              child: Text(
                "Done",
                style: TextStyle(color: res.isEmpty ? Colors.grey : Colors.white),
              ),
            );
          },
          addToFolderCtrl.folderIds,
        )
      ],
    );
  }
}
