import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/global_widgets/index.dart';
import 'package:note_app/app/global_widgets/staggered_grid_view.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';
import 'package:note_app/app/modules/home/widgets/index.dart';

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
          return CustomStaggeredGridView(
            total: res.length,
            mainAxisCellCount: (index) {
              final taskLength = res[index].tasks.length;
              return taskLength <= 2
                  ? 1.2
                  : taskLength >= 3
                      ? 1.5
                      : 1.4;
            },
            itemBuilder: (context, index) {
              final noteId = res[index].id;
              final note = res[index];
              final isPrivate = note.isPrivate;
              final dragNoteData = {"id": noteId, "index": index, "title": note.title};
              //LongPressDraggable
              return Draggable(
                child: NoteItem(
                  index,
                  note,
                  onTap: () {
                    // view or edit note
                    controller.viewNote(isPrivate, noteId);
                  },
                ),
                childWhenDragging: Container(), //NoteItemHolder(index),
                data: dragNoteData,
                dragAnchorStrategy: (draggable, context, position) {
                  return position;
                },
                onDragStarted: () {
                  controller.deleteMode.toggle();
                  controller.currentIndex.value = index;
                },
                onDragUpdate: (details) {
                  controller.onDragUpdate(details);
                },
                onDraggableCanceled: (velocity, offset) {
                  controller.onDragCancel();
                },
                feedbackOffset: Offset(5, 10),
                feedback: NoteItemFeedback(note: note),
              );
            },
          );
        },
        controller.notes,
      ),
    );
  }
}
