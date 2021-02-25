import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/data/services/base_services.dart';
import 'package:note_app/app/global_widgets/custom_app_bar.dart';
import 'package:note_app/app/modules/home/views/all_note_view.dart';
import 'package:note_app/app/modules/note_by_folder/controllers/note_by_folder_controller.dart';

class NoteByFolderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String folderId = Get.arguments as String;
    return GetBuilder<NoteByFolderController>(
      init: NoteByFolderController(folderId),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(childs: [], onTapBack: () => Get.back()),
          body: ObxValue<RxList<Note>>(
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
                  bool hasPassword =
                      BaseServices().notePassword(res[index].id) == null ? false : true;
                  return NoteItem(
                    res[index],
                    onTap: () {
                    },
                    hasPassword: hasPassword,
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
      },
    );
  }
}
