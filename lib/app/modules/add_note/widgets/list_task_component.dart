import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/modules/add_note/controllers/add_note_controller.dart';

class ListTaskComponent extends GetView<AddNoteController> {
  const ListTaskComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObxValue((res) {
      List<Task> tasks = res;
      return ListView.separated(
        key: UniqueKey(),
        padding: EdgeInsets.symmetric(vertical: 10),
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(height: 10),
        itemCount: tasks.length,
        itemBuilder: (ctx, index) {
          int listTaskIndex = controller.pages.indexWhere((item) => item.id == "list-task");
          return TaskItem(task: tasks[index], widgetIndex: listTaskIndex);
        },
      );
    }, controller.tasks);
  }
}

class TaskItem extends GetView<AddNoteController> {
  final Task task;
  final int widgetIndex;
  TaskItem({this.task, this.widgetIndex});
  @override
  Widget build(BuildContext context) {
    TextEditingController ctrl = TextEditingController(text: task.title);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: task.title.isNotEmpty
              ? () {
                  controller.completeTask(task.id);
                }
              : () {},
          child: task.isDone
              ? Icon(EvaIcons.checkmarkCircle2, color: Colors.blue)
              : Icon(EvaIcons.radioButtonOffOutline),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: ctrl,
            style: TextStyle(
                decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none),
            onSubmitted: (value) {
              return controller.updateTitle(value, task.id);
            },
            decoration: InputDecoration.collapsed(hintText: "Your task"),
          ),
        ),
        GestureDetector(
          child: Icon(EvaIcons.trash2, color: Colors.red),
          onTap: () {
            controller.removeTask(task.id, widgetIndex);
          },
        ),
      ],
    );
  }
}
