import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/services/base_services.dart';
import 'package:note_app/app/theme/index.dart';
import 'package:note_app/app/utils/time_utils.dart';

class NoteItem extends StatefulWidget {
  final int index;
  final Note note;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  NoteItem(
    this.index,
    this.note, {
    required this.onTap,
    this.onLongPress,
  });

  @override
  _NoteItemState createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> with SingleTickerProviderStateMixin {
  BaseServices _baseServices = BaseServices();
  late AnimationController _controller;
  late Animation<Offset> offsetAnim;

  Note get note => widget.note;
  String get title => note.title;
  List<Task> get tasks => note.tasks;
  String get folderName => _baseServices.getFolderByNoteId(widget.note.id).first;
  bool get isPrivate => note.isPrivate;
  String get noteContent => note.content;
  String get createdDate => TimeUtils.fullDate(note.dateTime);

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: 500.milliseconds);
    offsetAnim = Tween(begin: Offset.zero, end: Offset(0, -5)).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*if (itemIndex == selectedIndex) {
      _controller.forward();
      //_controller.reverse();
    }*/

    return Transform.translate(
      offset: offsetAnim.value,
      child: InkWell(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        borderRadius: BorderRadius.circular(15),
        child: AnimatedContainer(
          height: 200,
          duration: 200.milliseconds,
          curve: Curves.easeInBack,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.itemColor,
          ),
          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              // hide if private
              Expanded(
                child: isPrivate
                    ? _buildPrivateContent()
                    : _buildNoteContent(noteContent, tasks, folderName, createdDate),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivateContent() {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          EvaIcons.lock,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildNoteContent(
      String content, List<Task> tasks, String folderName, String createdDate) {
    final totalDisplayTask = 3;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Text(content, overflow: TextOverflow.ellipsis),
        SizedBox(height: 15),
        tasks.isEmpty
            ? SizedBox()
            : ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: tasks.length > totalDisplayTask ? totalDisplayTask + 1 : tasks.length,
                itemBuilder: (context, index) {
                  return index < 3 ? TaskItem(task: tasks[index]) : _buildRemainTask(index);
                },
              ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              createdDate,
              style: TextStyle(color: Colors.grey),
            ),
            Text(folderName, style: TextStyle(color: Colors.grey))
          ],
        ),
      ],
    );
  }

  Widget _buildRemainTask(int index) {
    return Row(
      children: [Text("+${tasks.length - index}"), const Text(" more")],
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  TaskItem({required this.task});
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
