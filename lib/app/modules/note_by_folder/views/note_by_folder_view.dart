import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/global_widgets/index.dart';
import 'package:note_app/app/modules/note_by_folder/controllers/note_by_folder_controller.dart';
import 'package:note_app/app/modules/note_by_folder/widgets/floating_button.dart';

class NoteByFolderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String folderId = Get.arguments as String;
    return GetBuilder<NoteByFolderController>(
      init: NoteByFolderController(folderId),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(childs: [], onTapBack: () => Get.back()),
          floatingActionButton: FloatingBUtton(),
          body: ObxValue<RxList<Note>>(
            (res) {
              if (res.isEmpty == true) return Center(child: const Text("Empty Note"));

              return MasonryGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                itemCount: res.length,
                itemBuilder: (context, index) {
                  return StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: index.isEven ? 1.3 : 1.2,
                    child: NoteItem(
                      index,
                      res[index],
                      onTap: () {},
                      onLongPress: () {},
                    ),
                  );
                },
              );
            },
            controller.notes,
          ),
        );
      },
    );
  }
}
