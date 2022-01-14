import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:note_app/app/data/models/folder.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/services/index.dart';
import 'package:note_app/app/modules/home/views/all_folder_view.dart';
import 'package:note_app/app/modules/home/views/all_note_view.dart';
import 'package:note_app/app/routes/app_pages.dart';
import 'package:note_app/app/utils/index.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  static HomeController get to => Get.find();
  late TabController tabController;
  late PageController pageController;

  FolderServices _folderServices = FolderServices();
  NoteServices _noteServices = NoteServices();

  var notes = <Note>[].obs;
  var privateNoteIndex = <String>[];
  var folders = <NoteFolder>[].obs;
  var tabViews = <Map<String, dynamic>>[
    {"name": "All", "page": AllNoteView()},
    {"name": "Folder", "page": AllFolderView()}
  ];
  var currentIndex = 0.obs;
  //var editMode = false.obs;
  var deleteMode = false.obs;
  var showDeleteZone = false.obs;
  var showDeleteBtn = false.obs;
  var dragDetail = Rxn<DragUpdateDetails>();

  late Stream<BoxEvent> noteStream;
  late Stream<BoxEvent> folderStream;

  void initData() {
    var noteList = _noteServices.getNotes();
    var noteFolder = _folderServices.getFolder();

    notes.assignAll(noteList);
    folders.assignAll(noteFolder);
  }

  void viewNote(bool hasPassword, String noteId) {
    hasPassword
        ? DialogUtils().enterPassword(VerifyMode.view, VerifyType.note, id: noteId)
        : Get.toNamed(Routes.EDIT_NOTE, arguments: noteId);
  }

  void viewFolder(bool hasPassword, String folderId) {
    hasPassword
        ? DialogUtils().enterPassword(VerifyMode.view, VerifyType.folder, id: folderId)
        : Get.toNamed(Routes.NOTEBYFOLDER, arguments: folderId);
  }

  void onPageChange(int index) async {
    currentIndex.value = index;
    //change later - bug
    int tabIndex = (index) == 0 ? 0 : 1;
    tabController.animateTo(tabIndex);
  }

  void _tabListener() {
    currentIndex.value = tabController.index;
    pageController.animateToPage(tabController.index,
        duration: 500.milliseconds, curve: Curves.ease);
  }

  void onDragUpdate(DragUpdateDetails details) {
    dragDetail.value = details;
    var triggerShow = Get.height - details.localPosition.dy.toInt() <= 200;
    var showDelBtn = Get.height - details.localPosition.dy.toInt() <= 150;

    showDeleteZone.value = triggerShow;
    showDeleteBtn.value = showDelBtn;
  }

  void onDragCancel() {
    deleteMode.value = false;
    showDeleteZone.value = false;
    showDeleteBtn.value = false;
  }

  void deleteNote(Map data) async {
    int itemIndex = data["index"];
    String noteId = data["id"];
    String noteTitle = data["title"];
    final deletedNote = notes[itemIndex];
    // request enter password if isPrivate
    if (deletedNote.isPrivate) {
      bool isVerify =
          await DialogUtils().enterPassword(VerifyMode.remove, VerifyType.note, id: noteId);
      if (isVerify) {
        onRemoveItem(itemIndex, noteTitle, noteId, deletedNote);
      } else
        onDragCancel();
    } else {
      onRemoveItem(itemIndex, noteTitle, noteId, deletedNote);
    }
  }

  void onRemoveItem(int index, String noteTitle, String noteId, Note note) {
    notes.removeAt(index);
    _noteServices.removeNote(noteId);
    notes.refresh();
    ToastUtils().deleteNofify(
      noteTitle,
      undoFunct: () => notes.insert(index, note),
    );
    onDragCancel();
  }

  void listenDataChange() {
    noteStream = _noteServices.noteBox.watch();
    noteStream.listen((event) {
      notes.assignAll(_noteServices.getNotes());
    });
    folderStream = _folderServices.folderBox.watch();
    folderStream.listen((event) {
      folders.assignAll(_folderServices.getFolder());
    });
  }

  @override
  void onInit() {
    pageController = PageController();
    tabController = TabController(length: 2, vsync: this)..addListener(() => _tabListener());
    super.onInit();
  }

  @override
  void onReady() {
    initData();
    listenDataChange();
    super.onReady();
  }
}
