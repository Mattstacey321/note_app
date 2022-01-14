import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/routes/app_pages.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
          onTap: () {
            Get.toNamed(Routes.SETTING);
          },
          child: Icon(EvaIcons.settings2Outline),
        ),
      ],
    );
  }
}
