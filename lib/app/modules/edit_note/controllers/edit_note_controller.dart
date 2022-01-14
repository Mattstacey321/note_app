import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/models/note_component.dart';
import 'package:note_app/app/data/services/index.dart';
import 'package:note_app/app/modules/add_note/widgets/list_task_component.dart';

class EditNoteController extends GetxController {
  String _noteId;
  EditNoteController(String noteId) : _noteId = noteId;
  NoteServices _noteServices = NoteServices();
  BaseServices _baseServices = BaseServices();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();
  var note = Rxn<Note>();
  var tasks = <Task>[].obs;
  var pages = <NoteComponnent>[].obs;
  var countWord = 0.obs;
  var isPrivate = false.obs;
  var editMode = false.obs;
  var anyChange = false.obs;

  Note? get _note => note.value;

  void getNoteData() {
    note.value = _noteServices.getNoteById(_noteId);
    if (_note != null) {
      String noteTitle = _note!.title;
      List<Task> tasksResult = _note!.tasks;
      String contentResult = _note!.content;

      titleCtrl.text = noteTitle;
      contentCtrl.text = contentResult;
      tasks.addAll(tasksResult);

      countWord.value = titleCtrl.text.trim().length + contentCtrl.text.trim().length;

      pages.add(NoteComponnent(
        id: "content",
        widget: TextField(
          controller: contentCtrl,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onChanged: (value) => onTextChange(),
          decoration: InputDecoration.collapsed(hintText: "Write a note"),
        ),
      ));

      pages.add(
        NoteComponnent(
          id: "list-task",
          widget: ObxValue<RxList<Task>>(
            (res) {
              final componentIndex = pages.indexWhere((element) => element.id == "list-task");
              return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 10),
                separatorBuilder: (ctx, index) => SizedBox(height: 10),
                itemCount: res.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final task = res[index];
                  final taskId = task.id;
                  return TaskItem(
                    widgetIndex: index,
                    task: task,
                    onComplete: (value) {
                      completeTask(taskId);
                    },
                    onSubbmit: (value) {},
                    onDelete: () {
                      removeTask(taskId, componentIndex);
                    },
                  );
                },
              );
            },
            tasks,
          ),
        ),
      );
    }
  }

  void onTextChange() {
    countWord.value = titleCtrl.text.trim().length + contentCtrl.text.trim().length;
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

  void updateNote() {
    final noteTitle = titleCtrl.text;
    final content = contentCtrl.text;
    final notePrivate = isPrivate.value;

    if (_note != null) {
      final newValue =
          _note!.copyWith(title: noteTitle, content: content, tasks: tasks, isPrivate: notePrivate);
      if (anyChange.value) {
        _baseServices.updateNote(newValue);
        BotToast.showText(text: "Update success");
      } else {
        Get.back();
        BotToast.showText(text: "No change has been made", backgroundColor: Colors.black);
      }
    }
  }

  void isChangeAnything() {
    everAll([countWord, tasks], (value) {
      anyChange.value = true;
    });
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

  @override
  void onReady() {
    getNoteData();
    isChangeAnything();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
