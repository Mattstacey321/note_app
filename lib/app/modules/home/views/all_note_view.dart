import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/services/base_services.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';
import 'package:note_app/app/theme/app_colors.dart';
import 'package:note_app/app/utils/time_utils.dart';

class AllNoteView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      alignment: Alignment.center,
      child: ObxValue<RxList<Note>>(
        (res) {
          if (res.isEmpty == true) return const Text("Empty Note");
          return StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            scrollDirection: Axis.vertical,
            itemCount: res.length,
            itemBuilder: (context, index) {
              return NoteItem(
                res[index],
                hasPassword:
                    controller.privateNoteIndex.contains((item) => (res[index].id == item)),
              );
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(1, index.isEven ? 1.3 : 1.2);
            },
          );
        },
        controller.notes,
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  final Note note;
  final bool hasPassword;
  NoteItem(this.note, {this.hasPassword = false});
  @override
  Widget build(BuildContext context) {
    var tasks = note.tasks ??= [];
    return Container(
      height: 200,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.itemColor),
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            note.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Expanded(
            child: Center(
              child: hasPassword
                  ? FittedBox(
                      child: Icon(EvaIcons.lock),
                    )
                  : _buildItem(tasks),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(List<Task> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Text(note.content, overflow: TextOverflow.ellipsis),
        SizedBox(height: 15),
        tasks.isEmpty
            ? SizedBox()
            : ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskItem(task: tasks[index]);
                },
              ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              TimeUtils.fullDate(note.dateTime),
              style: TextStyle(color: Colors.grey),
            ),
            Text("${BaseServices().getFolderByNoteId(note.id).first}",
                style: TextStyle(color: Colors.grey))
          ],
        ),
      ],
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  TaskItem({@required this.task});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          task.isDone ? EvaIcons.checkmarkCircle2 : EvaIcons.radioButtonOffOutline,
          color: task.isDone ? Colors.blue : Colors.white,
        ),
        Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        )
      ],
    );
  }
}
