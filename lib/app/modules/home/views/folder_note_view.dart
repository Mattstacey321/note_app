import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';

class FolderNoteView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      alignment: Alignment.center,
      child: ObxValue((res) {
        if (res.isEmpty) return Text("Empty Folder");
        return GridView.count(
          crossAxisCount: 2,
          children: [
            for(var item in res)
              Text("asdsad")
          ],
        );
      }, controller.notes),
    );
  }
}
