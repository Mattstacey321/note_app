import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/folder.dart';
import 'package:note_app/app/global_widgets/staggered_grid_view.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';
import 'package:note_app/app/modules/home/widgets/index.dart';
import 'package:note_app/app/theme/app_colors.dart';

class AllFolderView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      alignment: Alignment.center,
      child: ObxValue<RxList<NoteFolder>>(
        (folders) {
          if (folders.isEmpty) return Text("Empty Folder");
          return CustomStaggeredGridView(
            total: folders.length,
            mainAxisCellCount: (_) {
              return 1.2;
            },
            itemBuilder: (context, index) {
              final folderId = folders[index].id;
              final folder = folders[index];
              final isPrivate = folder.isPrivate;
              return Draggable(
                child: FolderItem(
                  folders[index],
                  onTap: () {
                    controller.viewFolder(isPrivate, folderId);
                  },
                ),
                dragAnchorStrategy: (draggable, context, position) {
                  return position;
                },
                feedback: FolderItemFeedback(),
              );
            },
          );
        },
        controller.folders,
      ),
    );
  }
}

class FolderItem extends StatelessWidget {
  final NoteFolder folder;
  final VoidCallback onTap;
  FolderItem(
    this.folder, {
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: (event) {},
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.itemColor,
          ),
          child: Stack(
            children: [
              /*Positioned(
                top: 10,
                right: 10,
                child: AnimatedOpacity(
                  duration: 200.milliseconds,
                  curve: Curves.fastOutSlowIn,
                  opacity: editMode ? 1 : 0,
                  child: CircleIcon(
                    onTap: () {},
                    icon: Icon(EvaIcons.moreVertical),
                    tooltip: "Option",
                  ),
                ),
              ),*/
              Positioned.fill(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Icon(
                            EvaIcons.folder,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            folder.isPrivate ? Icon(EvaIcons.lock) : SizedBox(),
                            SizedBox(width: folder.isPrivate ? 5 : 0),
                            Text(
                              folder.name,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
