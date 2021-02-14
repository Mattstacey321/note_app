import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/global_widgets/custom_app_bar.dart';
import 'package:note_app/app/modules/home/views/all_note_view.dart';
import 'package:note_app/app/modules/home/views/folder_note_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childAlignment: MainAxisAlignment.start,
        childs: [
          Text(
            "Notes",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
        menu: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Text("Edit"),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {},
              child: Icon(EvaIcons.searchOutline),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {},
              child: Icon(EvaIcons.settings2Outline),
            ),
          ],
        ),
        height: 120,
        tabBar: Container(
          height: 40,
          child: Theme(
            data: Theme.of(context)
                .copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
            child: TabBar(
              controller: controller.tabController,
              indicatorColor: Colors.amber,
              tabs: [Text("All"), Text("Folder")],
            ),
          ),
        ),
      ),
      floatingActionButton: ObxValue(
        (res) {
          return FloatingActionButton(
            onPressed: () {},
            child: AnimatedSwitcher(
              duration: 1.seconds,
              child: res.value == 0
                  ? Icon(EvaIcons.fileAddOutline, color: Colors.white)
                  : Icon(EvaIcons.plus, color: Colors.white),
            ),
          );
        },
        controller.currentIndex,
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: controller.tabViews,
      ),
    );
  }
}
