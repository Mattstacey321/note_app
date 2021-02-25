import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/services/base_services.dart';
import 'package:note_app/app/routes/app_pages.dart';

class DialogUtils {
  final _baseServices = BaseServices();
  Future<bool> isNoteHasContent(bool isPageEmpty, bool isTitleEmpty) {
    if (!isPageEmpty || isTitleEmpty) {
      return Get.generalDialog(
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) {
          return Center(
            child: Material(
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: 1.seconds,
                height: 100,
                width: Get.width - 150,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(
                          CurvedAnimation(
                              parent: animation,
                              curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Save as draft ?"),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  //save as draft
                                },
                                child: Text("OK"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
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
        barrierLabel: "Save as draft",
      );
    } else
      return Future.value(false);
  }

  void verifyNotePassword(String noteId, TextEditingController passwordCtrl) {
    final notePwd = _baseServices.isNotePrivate(noteId).password;
    final userTypePwd = passwordCtrl.text;
    if (notePwd == userTypePwd) {
      Get.offAndToNamed(Routes.EDIT_NOTE, arguments: noteId);
    } else
      BotToast.showText(text: "Wrong password");
  }

  void verifyFolderPassword(String folderId, TextEditingController passwordCtrl) {
    final folderPwd = _baseServices.isFolderPrivate(folderId).password;
    final userTypePwd = passwordCtrl.text;
    if (folderPwd == userTypePwd) {
      Get.offAndToNamed(Routes.NOTEBYFOLDER, arguments: folderId);
    } else
      BotToast.showText(text: "Wrong password");
  }

  Future enterPassword(String type, {@required String id}) async {
    Get.generalDialog(
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        final passwordCtrl = TextEditingController();
        return Center(
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: AnimatedContainer(
              duration: 1.seconds,
              height: 150,
              width: Get.width - 100,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: SlideTransition(
                position: Tween(begin: Offset(0, -1), end: Offset.zero).animate(CurvedAnimation(
                    parent: animation, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Enter note password ?"),
                    SizedBox(height: 15),
                    Flexible(
                      child: SlideTransition(
                        position: Tween(begin: Offset(0, -1), end: Offset.zero).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Interval(
                              0.5,
                              1,
                              curve: Curves.fastOutSlowIn,
                            ),
                          ),
                        ),
                        child: TextField(
                          controller: passwordCtrl,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              border: InputBorder.none,
                              hintText: "Password"),
                        ),
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
                            //verify password
                            type == "note"
                                ? verifyNotePassword(id, passwordCtrl)
                                : verifyFolderPassword(id, passwordCtrl);
                          },
                          child: Text("Confirm"),
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
      barrierLabel: "Enter password",
    );
  }
}
