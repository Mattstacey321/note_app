import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/modules/add_note/controllers/image_component_controller.dart';

class ImageComponent extends StatefulWidget {
  ImageComponent({Key key}) : super(key: key);

  @override
  _ImageComponentState createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Get.create(() => ImageComponentController());
    final controller = Get.find<ImageComponentController>();
    return ObxValue<RxString>(
      (res) {
        String imagePath = res.value;
        return GestureDetector(
          onTap: () {
            controller.insertImage();
          },
          child: Container(
            height: 80,
            width: Get.width,
            alignment: Alignment.center,
            child: imagePath.isEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(EvaIcons.plus),
                      SizedBox(width: 10),
                      Text("Image"),
                    ],
                  )
                : Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  ),
          ),
        );
      },
      controller.imagePath,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
