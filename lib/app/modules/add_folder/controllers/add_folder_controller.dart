import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:note_app/app/data/services/folder_services.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';

class AddFolderController extends GetxController {
  TextEditingController folderNameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  FolderServices _folderServices = FolderServices();
  var isPrivate = false.obs;
  var isFolderNameEmpty = true.obs;
  var isPasswordEmpty = true.obs;
  late Stream<BoxEvent> folderBoxStream;

  void createFolder() {
    final folderName = folderNameCtrl.text;
    final folderPassword = passwordCtrl.text;
    _folderServices.add(
      folderName,
      isPrivate: isPrivate.value,
      pwd: folderPassword,
    );
  }

  void checkFolderName(String value) {
    isFolderNameEmpty.value = value.isEmpty;
  }

  void changePrivateMode() {
    isPrivate.toggle();
  }

  void checkTypingPassword(String text) {
    isPasswordEmpty.value = text.isEmpty;
  }

  @override
  void onReady() {
    folderBoxStream = _folderServices.folderBox.watch();
    // data change refresh data
    folderBoxStream.listen((data) {
      HomeController.to.folders.add(data.value);
    });
    super.onReady();
  }
}
