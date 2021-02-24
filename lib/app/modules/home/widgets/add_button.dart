import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';
import 'package:note_app/app/routes/app_pages.dart';

class AddButton extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (res) {
        return FloatingActionButton(
          onPressed: () {
            res.value == 0 ? Get.toNamed(Routes.ADDNOTE) : Get.toNamed(Routes.ADDFOLDER);
          },
          child: AnimatedSwitcher(
            duration: 1.seconds,
            child: res.value == 0
                ? Icon(EvaIcons.fileAddOutline, color: Colors.white)
                : Icon(EvaIcons.plus, color: Colors.white),
          ),
        );
      },
      controller.currentIndex,
    );
  }
}
