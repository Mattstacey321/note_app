import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';

class AllNoteView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      alignment: Alignment.center,
      child: ObxValue((res) {
        if (res.isEmpty) return Text("Empty Note");
        return ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 20),
          itemCount: res.length,
          itemBuilder: (ctx, index) {
            return Text("A");
          },
        );
      }, controller.notes),
    );
  }
}
