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
  Worker worker;
  var titleLength = 0.obs;
  var isPrivateNote = false.obs;
  var password = "".obs;
  var countWord = 0.obs;
  var tasks = <Task>[].obs;
  var pages = <NoteComponnent>[
    NoteComponnent(
      id: "note-content",
      widget: NoteContentComponent(
        key: UniqueKey(),
      ),
    ),
  ].obs;
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
    tasks.add(Task(id: UniqueKey().toString(), title: ""));
    tasks.refresh();
  }

  void switchTaskMode() {
    if (!pages.any((element) => element.id == "list-task")) {
      addTaskMode();
    }
    if (taskMode.value) {
      tasks.add(Task(id: UniqueKey().toString(), title: ""));
    } else {
      taskMode.toggle();
    }
  }

  void completeTask(String id) {
    tasks.singleWhere((element) => element.id == id).isDone =
        !tasks.singleWhere((element) => element.id == id).isDone;
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
    print(id);
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
    WorkerUtils(worker).listenTitleChange(titleLength);
    WorkerUtils(worker).setPassword(isPrivateNote);
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    tasks.clear();
    pages.clear();
    super.onClose();
  }
}
