import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogUtils {
  Future<bool> isNoteHasContent(bool isPageEmpty, bool isTitleEmpty) {
    if (!isPageEmpty|| isTitleEmpty) {
      return Get.generalDialog(
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) {
            return Center(
              child: Material(
                borderRadius: BorderRadius.circular(10),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 10000),
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
          barrierLabel: "Save as draft");
    } else
      return Future.value(false);
  }
}
