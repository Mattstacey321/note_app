import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/note_component.dart';
import 'package:note_app/app/global_widgets/custom_app_bar.dart';
import 'package:note_app/app/modules/edit_note/widgets/update_button.dart';
import 'package:note_app/app/utils/time_utils.dart';

import '../controllers/edit_note_controller.dart';

class EditNoteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noteId = Get.arguments as String;
    return GetBuilder<EditNoteController>(
      init: EditNoteController(noteId),
      builder: (controller) {
        return Scaffold(
            appBar: CustomAppBar(
              childs: [],
              menu: UpdateButton(),
              onTapBack: () => Get.back(),
            ),
            body: Obx(() {
              bool editMode = !controller.editMode.value;
              return AbsorbPointer(
                absorbing: editMode,
                child: SingleChildScrollView(
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
                                  onChanged: (value) => controller.onTextChange(),
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
                        // load task, image if available
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
                                    //onLongPress: () => controller.triggerRearrangeMode(),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(child: res[index].widget),
                                      ],
                                    ),
                                  );
                                },
                                buildDefaultDragHandles: false,
                                itemCount: res.length,
                                onReorder: (oldIndex, newIndex) =>
                                    controller.onReorder(oldIndex, newIndex),
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
            }));
      },
    );
  }
}
