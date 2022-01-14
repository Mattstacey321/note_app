import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';
import 'package:note_app/app/routes/app_pages.dart';

class AddButton extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return ObxValue<RxBool>(
      (res) {
        bool deleteMode = res.value;
        return AnimatedContainer(
          duration: 200.milliseconds,
          height: 100,
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedOpacity(
                duration: 200.milliseconds,
                opacity: deleteMode ? 0 : 1,
                child: ObxValue<RxInt>(
                  (res) {
                    return FloatingActionButton(
                      onPressed: () {
                        res.value == 0
                            ? Get.toNamed(Routes.ADDNOTE)
                            : Get.toNamed(Routes.ADDFOLDER);
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
                ),
              )
              /*res.value
                  ? DragTarget(
                      onMove: (details) {},
                      onLeave: (data) {},
                      builder: (context, candidateData, rejectedData) => Container(
                        height: 50,
                        width: 120,
                        child: CircleIcon(
                          onTap: () {},
                          bgColor: Colors.red,
                          icon: Icon(
                            EvaIcons.trash,
                            color: Colors.white,
                          ),
                          tooltip: "",
                        ),
                      ),
                    )
                  : SizedBox(),*/
            ],
          ),
        );
      },
      controller.deleteMode,
    );
  }
}
