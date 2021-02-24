import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/folder.dart';
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
        (res) {
          if (res.isEmpty) return Text("Empty Folder");
          return StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 12,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            scrollDirection: Axis.vertical,
            itemCount: res.length,
            itemBuilder: (context, index) {
              return FolderItem(
                res[index],
                onTap: () {
                  Get.toNamed(Routes.NOTEBYFOLDER,arguments: res[index].id);
                },
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
  FolderItem(this.folder, {@required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.itemColor,
        ),
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
    );
  }
}
