import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/note_component.dart';
import 'package:note_app/app/global_widgets/custom_app_bar.dart';
import 'package:note_app/app/modules/add_note/controllers/add_note_controller.dart';
import 'package:note_app/app/modules/add_note/widgets/edit_note_menu.dart';
import 'package:note_app/app/modules/add_note/widgets/next_button.dart';
import 'package:note_app/app/utils/time_utils.dart';

class NoteContent extends GetView<AddNoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childs: [
          SizedBox(width: 40),
          Text(
            "Notes",
            style: TextStyle(color: Colors.grey),
          )
        ],
        childAlignment: MainAxisAlignment.start,
        homeIcon: Icon(
          EvaIcons.close,
          color: Colors.grey,
        ),
        menu: NextButton(),
        onTapBack: () => Get.back(),
      ),
      bottomNavigationBar: EditNoteMenu(),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              //title
              Container(
                height: 80,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: controller.titleCtrl,
                        textCapitalization: TextCapitalization.characters,
                        style: TextStyle(fontSize: 20),
                        onChanged: (value) => controller.checkTitleIsEmpty(value),
                        decoration: InputDecoration.collapsed(hintText: "Title"),
                      ),
                    ),
                    SizedBox(height: 10),
                    ObxValue<RxInt>(
                      (res) => Text(
                        "${TimeUtils.fullDate(DateTime.now())} | ${res.value} words",
                        style: TextStyle(color: Colors.grey),
                      ),
                      controller.countWord,
                    ),
                  ],
                ),
              ),
              // write note area
              Expanded(
                flex: 8,
                child: ObxValue<RxList<NoteComponnent>>(
                  (res) => Container(
                    width: Get.width,
                    child: ReorderableListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          key: Key('$index'),
                          behavior: HitTestBehavior.translucent,
                          onLongPress: () => controller.triggerRearrangeMode(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: res[index].widget),
                              ObxValue<RxBool>(
                                (res) {
                                  return res.value
                                      ? ReorderableDragStartListener(
                                          index: index,
                                          child: Icon(
                                            EvaIcons.moreVerticalOutline,
                                            size: 15,
                                          ),
                                        )
                                      : SizedBox();
                                },
                                controller.rearrangeMode,
                              ),
                            ],
                          ),
                        );
                      },
                      buildDefaultDragHandles: false,
                      itemCount: res.length,
                      onReorder: (oldIndex, newIndex) => controller.onReorder(oldIndex, newIndex),
                    ),
                  ),
                  controller.pages,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
