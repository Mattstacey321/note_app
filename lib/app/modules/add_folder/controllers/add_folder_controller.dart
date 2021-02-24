import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddFolderController extends GetxController {
  TextEditingController folderNameCtrl = TextEditingController();
  var isPrivate = false.obs;
  var isFolderNameEmpty = true.obs;

  void checkFolderName(String value) {
    isFolderNameEmpty.value = value.isEmpty;
  }
}
