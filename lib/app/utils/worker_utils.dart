import 'package:bot_toast/bot_toast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/modules/add_note/controllers/add_note_controller.dart';

class WorkerUtils {
  Worker worker;
  final controller = Get.find<AddNoteController>();
  WorkerUtils(Worker worker) : worker = worker;

  void listenTitleChange(RxInt titleLength) {
    worker = debounce(
      titleLength,
      (int count) {
        //tasks.any((item) => item.title == "") || isTitleEmpty.isTrue
        if (count > 0)
          controller.canNextStep.value = true;
        else
          controller.canNextStep.value = false;
      },
      time: 500.milliseconds,
    );
  }

  void setPassword(RxBool isPrivateNote) {
    var showPassword = controller.showPassword;
    var passwordCtrl = controller.passwordCtrl;

    worker = ever(isPrivateNote, (bool res) {
      if (res) {
        Get.generalDialog(
            transitionDuration: Duration(milliseconds: 200),
            pageBuilder: (context, animation, secondaryAnimation) {
              return Center(
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 10000),
                    height: 150,
                    width: Get.width - 100,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(
                          CurvedAnimation(
                              parent: animation,
                              curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Set your password ?"),
                          SizedBox(height: 15),
                          Expanded(
                            child: Container(
                              child: ObxValue<RxBool>((res) {
                                bool hidePwd = res.value;
                                return TextField(
                                  controller: passwordCtrl,
                                  obscureText: hidePwd ? true : false,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    border: InputBorder.none,
                                    hintText: "",
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        showPassword.toggle();
                                      },
                                      child: res.value
                                          ? Icon(EvaIcons.eyeOutline)
                                          : Icon(EvaIcons.eyeOffOutline),
                                    ),
                                  ),
                                );
                              }, showPassword),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  controller.setNotePassword();
                                },
                                child: Text("Set"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return Transform.translate(
                offset: Offset(animation.value, animation.value * 15),
                child: Opacity(opacity: animation.value, child: child),
              );
            },
            barrierDismissible: true,
            barrierLabel: "Enter password");
      }
      BotToast.showText(
        text: "Change to ${res == true ? 'Private mode' : 'Public Mode'}",
        align: Alignment.bottomCenter,
      );
    });
  }
}
