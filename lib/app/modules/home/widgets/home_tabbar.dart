import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';

class HomeTabbar extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Theme(
        data: Theme.of(context)
            .copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
        child: TabBar(
          controller: controller.tabController,
          indicatorColor: Colors.amber,
          tabs: controller.tabViews.map<Widget>((e) => Text(e["name"])).toList(),
        ),
      ),
    );
  }
}
