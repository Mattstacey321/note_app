import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/folder.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/services/folder_services.dart';
import 'package:note_app/app/data/services/note_services.dart';
import 'package:note_app/app/modules/home/views/all_note_view.dart';
import 'package:note_app/app/modules/home/views/folder_note_view.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;
  FolderServices _folderServices = FolderServices();
  NoteServices _noteServices = NoteServices();
  var notes = <Note>[].obs;
  var folders = <NoteFolder>[].obs;
  var tabViews = [AllNoteView(), FolderNoteView()];
  var currentIndex = 0.obs;

  void initData() async {
    notes.addAll(await _noteServices.getNote());
    folders.addAll(await _folderServices.getFolder());
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        currentIndex.value = tabController.index;
      });
    initData();
    super.onInit();
  }
}
