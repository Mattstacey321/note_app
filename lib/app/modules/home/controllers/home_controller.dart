import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/folder.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/services/folder_services.dart';
import 'package:note_app/app/data/services/note_services.dart';
import 'package:note_app/app/data/services/private_note_services.dart';
import 'package:note_app/app/modules/home/views/all_folder_view.dart';
import 'package:note_app/app/modules/home/views/all_note_view.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController;
  PageController pageController;
  FolderServices _folderServices = FolderServices();
  NoteServices _noteServices = NoteServices();
  PrivateNoteServices _privateNoteService = PrivateNoteServices();
  var notes = <Note>[].obs;
  var privateNoteIndex = <String>[];

  var folders = <NoteFolder>[].obs;
  var tabViews = <Map<String, dynamic>>[
    {"name": "All", "page": AllNoteView()},
    {"name": "Folder", "page": AllFolderView()}
  ];
  var currentIndex = 0.obs;

  void initData() async {
    var noteList = _noteServices.getNotes();
    var noteFolder = _folderServices.getFolder();
    for (var item in noteList) {
      if (_privateNoteService.isPrivateNote(item.id)) {
        privateNoteIndex.add(item.id);
      }
    }

    notes.addAll(noteList);
    folders.addAll(noteFolder);
  }

  void onPageChange(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    pageController = PageController();
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        currentIndex.value = tabController.index;
        pageController.animateToPage(tabController.index,
            duration: 500.milliseconds, curve: Curves.fastLinearToSlowEaseIn);
      });
    super.onInit();
  }

  @override
  void onReady() {
    initData();
    super.onReady();
  }
}
