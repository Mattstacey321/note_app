import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/models/note_component.dart';
import 'package:note_app/app/data/models/private.dart';
import 'package:note_app/app/data/services/note_services.dart';
import 'package:note_app/app/modules/add_note/controllers/add_to_folder_controller.dart';
import 'package:note_app/app/modules/add_note/widgets/image_component.dart';
import 'package:note_app/app/modules/add_note/widgets/list_task_component.dart';
import 'package:note_app/app/modules/add_note/widgets/note_content_component.dart';
import 'package:note_app/app/utils/worker_utils.dart';
import 'package:uuid/uuid.dart';

class AddNoteController extends GetxController {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  NoteServices _noteServices = NoteServices();
  var titleLength = 0.obs;
  var isPrivateNote = false.obs;
  var password = "".obs;
  var countWord = 0.obs;
  var tasks = <Task>[].obs;
  var pages = <NoteComponnent>[].obs;
  var taskMode = false.obs;
  var isTaskTitleEmpty = true.obs;
  var rearrangeMode = false.obs;
  var showPassword = false.obs;
  var canNextStep = false.obs;

  void countNoteText(String text) {
    countWord.value = text.trim().length;
  }

  void checkTitleIsEmpty(String text) {
    titleLength.value = text.length;
    // count when title change
    ever(titleLength, (res) {
      countWord.value = res as int;
    });
  }

  void addTaskMode() {
    addMoreTask();
    pages.add(
      NoteComponnent(
        id: "list-task",
        widget: ListTaskComponent(
          key: UniqueKey(),
        ),
      ),
    );
  }

  void addMoreTask() {
    var key = Uuid().v1();
    tasks.add(Task(id: key, title: ""));
    tasks.refresh();
  }

  void switchTaskMode() {
    var key = Uuid().v1();
    if (!pages.any((element) => element.id == "list-task")) {
      addTaskMode();
    }
    if (taskMode.value) {
      tasks.add(Task(id: key, title: ""));
    } else {
      taskMode.toggle();
    }
  }

  void completeTask(String id) {
    bool isDone = tasks.firstWhere((element) => element.id == id).isDone;
    tasks.firstWhere((element) => element.id == id).isDone = !isDone;
    tasks.refresh();
    pages.refresh();
  }

  void removeTask(String taskId, int pageIndex) {
    tasks.removeWhere((element) => element.id == taskId);
    if (tasks.isEmpty) pages.removeAt(pageIndex);
    tasks.refresh();
    pages.refresh();
  }

  void updateTitle(String value, String id) {
    tasks.firstWhere((element) => element.id == id).title = value;
    tasks.refresh();
    pages.refresh();
  }

  bool checkEmptyTaskTitle(String id) {
    return tasks.singleWhere((element) => element.id == id).title.isEmpty;
  }

  void addImage() {
    pages.add(NoteComponnent(
        id: "image ${pages.length + 1}",
        widget: ImageComponent(key: Key("image ${pages.length + 1}"))));
  }

  void saveNote() {
    var uuid = Uuid().v1();
    //before save
    if (tasks.any((item) => item.title == "")) {
      BotToast.showText(
        text: "Some task title is empty, please check again...",
        align: Alignment.bottomCenter,
      );
    } else {
      final noteId = uuid;
      final title = titleCtrl.text;
      final content = contentCtrl.text;
      final listTask = tasks;
      final privateInfo = Private(id: noteId, password: password.value);
      final folderIds = AddToFolderController.to.folderIds;
      _noteServices.addNote(
        Note(
          id: noteId,
          title: title,
          content: content,
          dateTime: DateTime.now(),
          tasks: listTask,
        ),
        folderIds: folderIds,
        value: privateInfo,
      );
      Get.back();
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    NoteComponnent item = pages.removeAt(oldIndex);
    pages.insert(
      newIndex,
      NoteComponnent(id: item.id, widget: item.widget),
    );
    pages.refresh();
  }

  void triggerRearrangeMode() {
    rearrangeMode.toggle();
  }

  void lockNote() {
    isPrivateNote.toggle();
  }

  void setNotePassword() {
    password.value = passwordCtrl.text;
    Get.back();
  }

  @override
  void onReady() {
    // listenTitleChange(titleLength);
    // setPassword(isPrivateNote);
    pages.add(NoteComponnent(
      id: "note-content",
      widget: NoteContentComponent(
        key: UniqueKey(),
      ),
    ));
    super.onReady();
  }

  @override
  void onClose() {
    tasks.clear();
    pages.clear();
    super.onClose();
  }
}
