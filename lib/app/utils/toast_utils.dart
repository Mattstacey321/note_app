import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:note_app/app/global_widgets/index.dart';

class ToastUtils {
  void deleteNofify(String title, {required VoidCallback undoFunct}) {
    BotToast.showAnimationWidget(
      animationDuration: 200.milliseconds,
      duration: 5.seconds,
      ignoreContentClick: false,
      crossPage: false,
      wrapToastAnimation: (controller, cancelFunc, child) => Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              cancelFunc();
            },
            child: AnimatedBuilder(
              builder: (_, child) => Opacity(
                opacity: controller.value,
                child: child,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.transparent),
                child: SizedBox.expand(),
              ),
              animation: controller,
            ),
          ),
          CustomOffsetAnimation(
            controller: controller,
            child: child,
          )
        ],
      ),
      toastBuilder: (cancelFunc) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () {
              undoFunct();
              cancelFunc();
            },
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 1)],
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: '"$title" was deleted.'),
                    TextSpan(
                      text: " Undo?",
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
