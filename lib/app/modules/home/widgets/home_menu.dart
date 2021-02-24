import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

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
          onTap: () {},
          child: Icon(EvaIcons.settings2Outline),
        ),
      ],
    );
  }
}
