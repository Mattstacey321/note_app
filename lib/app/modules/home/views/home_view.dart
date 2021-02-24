import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/global_widgets/custom_app_bar.dart';
import 'package:note_app/app/modules/home/widgets/add_button.dart';
import 'package:note_app/app/modules/home/widgets/home_menu.dart';
import 'package:note_app/app/modules/home/widgets/home_tabbar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childAlignment: MainAxisAlignment.start,
        childPadding: 20,
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
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (pageIndex) => controller.onPageChange(pageIndex),
        children: controller.tabViews.map<Widget>((Map e) => e["page"]).toList(),
      ),
    );
  }
}
