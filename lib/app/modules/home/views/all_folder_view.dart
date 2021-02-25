import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/folder.dart';
import 'package:note_app/app/global_widgets/circle_icon.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';
import 'package:note_app/app/routes/app_pages.dart';
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
          return StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            scrollDirection: Axis.vertical,
            itemCount: folders.length,
            itemBuilder: (context, index) {
              return ObxValue<RxBool>(
                (res) {
                  final folderId = folders[index].id;
                  return FolderItem(
                    folders[index],
                    onTap: () {
                      Get.toNamed(Routes.NOTEBYFOLDER, arguments: folderId);
                    },
                    onLongPress: () {
                      controller.changeToEditMode();
                    },
                    editMode: res.value,
                  );
                },
                controller.editMode,
              );
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(1, index.isEven ? 1.2 : 1.1);
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
  final Function onTap;
  final Function onLongPress;
  final bool editMode;
  FolderItem(this.folder,
      {@required this.onTap, @required this.onLongPress, this.editMode = false});
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: (event) {},
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.itemColor,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 10,
                child: AnimatedOpacity(
                  duration: 200.milliseconds,curve: Curves.fastOutSlowIn,
                  opacity: editMode ? 1 : 0,
                  child: CircleIcon(
                    onTap: () {},
                    icon: Icon(EvaIcons.moreVertical),
                    tooltip: "Option",
                  ),
                ),
              ),
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
                    Expanded(child: Text(folder.folderName))
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
