// fetch available folder and select
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/constraints/navigator_key.dart';
import 'package:note_app/app/data/models/folder.dart';
import 'package:note_app/app/global_widgets/custom_app_bar.dart';
import 'package:note_app/app/modules/add_note/controllers/add_to_folder_controller.dart';
import 'package:note_app/app/modules/add_note/widgets/save_button.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';
import 'package:note_app/app/theme/app_colors.dart';

class AddToFolder extends GetView<AddToFolderController> {
  @override
  Widget build(BuildContext context) {
    final homeCtrl = Get.find<HomeController>();
    return Scaffold(
      appBar: CustomAppBar(
        childs: [],
        homeIcon: Icon(
          EvaIcons.arrowBack,
          color: Colors.grey,
        ),
        menu: SaveButton(),
        onTapBack: () {
          Get.toNamed("/", id: NavigatorKey.addNoteKey);
        },
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: ObxValue<RxList<NoteFolder>>(
          (res) {
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: res.length,
                  itemBuilder: (context, index) {
                    return ItemBuilder(
                      res[index],
                      onTap: () {
                        controller.selectFolder(res[index].id);
                      },
                    );
                  },
                ),
                res.isEmpty
                    ? ElevatedButton.icon(
                        onPressed: () {
                          controller.createFolder();
                        },
                        icon: Icon(EvaIcons.plus),
                        label: Text("Add folder"),
                      )
                    : SizedBox()
              ],
            );
          },
          homeCtrl.folders,
        ),
      ),
    );
  }
}

class ItemBuilder extends GetView<AddToFolderController> {
  final NoteFolder folder;
  final VoidCallback? onTap;
  ItemBuilder(this.folder, {this.onTap});
  @override
  Widget build(BuildContext context) {
    final count = controller.totalNote(folder.id);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: Get.width,
        child: Row(
          children: <Widget>[
            Expanded(flex: 1, child: FittedBox(child: Icon(EvaIcons.folder, color: Colors.amber))),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    folder.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "$count ${count > 0 ? "notes" : "note"} ",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: ObxValue<RxList<String>>(
                (res) {
                  return AnimatedCrossFade(
                      duration: 200.milliseconds,
                      crossFadeState: res.contains(folder.id)
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      secondChild: Icon(EvaIcons.radioButtonOff, color: AppColors.buttonColor),
                      firstChild: Icon(EvaIcons.checkmarkCircle2, color: AppColors.buttonColor));
                },
                controller.folderIds,
              ),
            )
          ],
        ),
      ),
    );
  }
}
