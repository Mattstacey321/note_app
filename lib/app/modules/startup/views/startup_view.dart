import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:note_app/app/constraints/assets_path.dart';
import 'package:note_app/app/routes/app_pages.dart';
import 'package:note_app/app/theme/app_style.dart';
import 'package:note_app/app/theme/index.dart';

import '../controllers/startup_controller.dart';

class StartupView extends GetView<StartupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: SvgPicture.asset(
              AssetsPath.takeNoteSvg,
            ),
          ),
          Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Daily Notes",
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    "Take notes, reminder, set targets, collect resources, and secure privacy",
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1.5),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAndToNamed(Routes.HOME);
                    },
                    style: AppStyles.getStartedButtonStyle,
                    child: Text("Get Started"),
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
