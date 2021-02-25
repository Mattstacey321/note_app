import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/models/note_component.dart';
import 'package:note_app/app/data/services/note_services.dart';
import 'package:note_app/app/modules/add_note/widgets/list_task_component.dart';

class EditNoteController extends GetxController {
  String _noteId;
  EditNoteController(String noteId) : _noteId = noteId;
  NoteServices _noteServices = NoteServices();
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();
  Worker _worker;
  var note = Rx<Note>();
  var tasks = <Task>[].obs;
  var pages = <NoteComponnent>[].obs;
  var countWord = 0.obs;

  void getNoteData() {
    note.value = _noteServices.getNoteById(_noteId);

    Note noteResult = note.value;
    String nnteTitle = noteResult.title;
    List<Task> tasksResult = noteResult.tasks;
    String contentResult = noteResult.content;

    titleCtrl.text = nnteTitle;
    contentCtrl.text = contentResult;
    tasks.addAll(tasksResult);
    
    pages.add(NoteComponnent(
      id: "content",
      widget: TextField(
        controller: contentCtrl,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        //onChanged: (value) => controller.countNoteText(value),
        decoration: InputDecoration.collapsed(hintText: "Write a note"),
      ),
    ));
    pages.add(
      NoteComponnent(
        id: "list-task",
        widget: ObxValue<RxList<Task>>(
            (res) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 10),
                separatorBuilder: (ctx, index) => SizedBox(height: 10),
                itemCount: res.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TaskItem(
                    task: res[index],
                  );
                },
              );
            },
            tasks,
          ),
        
      ),
    );
  }

  void onTitleChange(String text) {
    countWord.value = text.length;
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

  void updateNote() {}

  void isChangeAnything() {
    //_worker = ever()
  }

  @override
  void onReady() {
    getNoteData();
    super.onReady();
  }
}
