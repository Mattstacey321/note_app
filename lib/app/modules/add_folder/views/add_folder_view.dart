import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/global_widgets/custom_app_bar.dart';
import 'package:note_app/app/modules/add_folder/controllers/add_folder_controller.dart';
import 'package:note_app/app/modules/add_folder/widgets/create_folder_button.dart';
import 'package:note_app/app/theme/app_colors.dart';

class AddFolderView extends StatelessWidget {
  final controller = Get.put<AddFolderController>(AddFolderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childs: [
          SizedBox(width: 40),
          Text(
            "Folder",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
        childAlignment: MainAxisAlignment.start,
        childPadding: 10,
        menu: CreateFolderButton(),
        homeIcon: Icon(
          EvaIcons.chevronLeft,
          color: Colors.grey,
        ),
        onTapBack: () {
          Get.back();
        },
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  EvaIcons.folder,
                  color: AppColors.buttonColor,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      controller: controller.folderNameCtrl,
                      onChanged: (value) => controller.checkFolderName(value),
                      decoration: InputDecoration.collapsed(hintText: "Name"),
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: <Widget>[
                        Text("Private"),
                        Spacer(),
                        ObxValue(
                          (res) {
                            return Switch(
                              value: res.value,
                              onChanged: (_) => controller.changePrivateMode(),
                            );
                          },
                          controller.isPrivate,
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: ObxValue(
                      (res) {
                        return AnimatedOpacity(
                          duration: 200.milliseconds,
                          opacity: res.value ? 1 : 0,
                          child: TextField(
                            controller: controller.passwordCtrl,
                            obscureText: true,
                            onChanged: (value) => controller.checkTypingPassword(value),
                            decoration: InputDecoration.collapsed(hintText: "Password"),
                          ),
                        );
                      },
                      controller.isPrivate,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
