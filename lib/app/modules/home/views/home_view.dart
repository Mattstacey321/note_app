import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/global_widgets/index.dart';
import 'package:note_app/app/modules/home/widgets/index.dart';

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
        menu: HomeMenu(),
        height: 120,
        tabBar: HomeTabbar(),
      ),
      floatingActionButton: AddButton(),
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (pageIndex) => controller.onPageChange(pageIndex),
              children: controller.tabViews.map<Widget>((Map e) => e["page"]).toList(),
            ),
          ),
          // drag area
          ObxValue<RxBool>(
            (res) {
              bool _ = res.value;
              print("home $_");
              return DeleteArea();
            },
            controller.showDeleteZone,
          ),
        ],
      ),
    );
  }
}
