import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/modules/add_note/controllers/add_note_controller.dart';

class ListTaskComponent extends GetView<AddNoteController> {
  const ListTaskComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxList<Task>>((res) {
      List<Task> tasks = res;
      return ListView.separated(
        key: key,
        padding: EdgeInsets.symmetric(vertical: 10),
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(height: 10),
        itemCount: tasks.length,
        itemBuilder: (ctx, index) {
          int listTaskIndex = controller.pages.indexWhere((item) => item.id == "list-task");
          final task = tasks[index];
          return TaskItem(
            task: task,
            widgetIndex: listTaskIndex,
            onComplete: (value) {
              controller.completeTask(task.id);
            },
            onSubbmit: (value) {
              return controller.updateTitle(value, task.id);
            },
            onDelete: () {
              controller.removeTask(task.id, listTaskIndex);
            },
          );
        },
      );
    }, controller.tasks);
  }
}

class TaskItem extends GetView<AddNoteController> {
  final Task task;
  final int widgetIndex;
  // task id
  final Function(String) onComplete;
  // edit task title
  final Function(String) onSubbmit;
  // delete task
  final Function onDelete;
  TaskItem({
    required this.task,
    required this.widgetIndex,
    required this.onComplete,
    required this.onSubbmit,
    required this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    TextEditingController ctrl = TextEditingController(text: task.title);
    FocusNode focusNode = FocusNode();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: task.title.isNotEmpty ? () => onComplete(task.id) : () {},
          child: task.isDone
              ? Icon(EvaIcons.checkmarkCircle2, color: Colors.blue)
              : Icon(EvaIcons.radioButtonOffOutline),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: ctrl,
            focusNode: focusNode,
            style: TextStyle(
              decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
            ),
            textInputAction: TextInputAction.next,
            onSubmitted: (value) {
              focusNode.nextFocus();
              return onSubbmit(value);
            },
            decoration: InputDecoration.collapsed(hintText: "Your task"),
          ),
        ),
        GestureDetector(
          child: Icon(EvaIcons.trash2, color: Colors.red),
          onTap: () => onDelete(),
        ),
      ],
    );
  }
}
