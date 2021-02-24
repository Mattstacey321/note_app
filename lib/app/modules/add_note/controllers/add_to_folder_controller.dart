import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/services/folder_services.dart';
import 'package:note_app/app/global_widgets/circle_icon.dart';

class AddToFolderController extends GetxController {
  static AddToFolderController get to => Get.find();
  FolderServices _folderServices = FolderServices();
  TextEditingController folderNameCtrl = TextEditingController();
  Stream folderBoxStream;
  var folderIds = <String>[].obs;

  void selectFolder(String id) {
    if (folderIds.contains(id)) {
      folderIds.remove(id);
    } else {
      folderIds.add(id);
    }
  }

  void addFolder() {
    _folderServices.add(folderNameCtrl.text);
  }

  void createFolder() {
    Get.bottomSheet(
      Container(
        height: 150,
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleIcon(
                  tooltip: "Close",
                  icon: Icon(EvaIcons.close),
                  onTap: () {},
                ),
                ElevatedButton(
                  onPressed: () {
                    addFolder();
                  },
                  child: Text("Add"),
                )
              ],
            ),
            Flexible(
              child: Center(
                child: TextField(
                  controller: folderNameCtrl,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration.collapsed(
                    hintText: "Folder name",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      enterBottomSheetDuration: 500.milliseconds,
      backgroundColor: Colors.grey[850],
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    );
  }

  @override
  void onReady() {
    folderBoxStream = _folderServices.folderBox.watch();
    super.onReady();
  }
}
