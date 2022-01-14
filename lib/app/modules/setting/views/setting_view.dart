import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  var _delta;
  var _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Draggable(
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.amber,
                  ),
                  feedback: Container(
                    height: 50,
                    width: 50,
                    color: Colors.amber,
                  ),
                  onDragUpdate: (details) {
                    setState(() {
                      var triggerShow = Get.height - details.globalPosition.dy <= 150;
                      var completeShow = Get.height - details.globalPosition.dy <= 100;
                      _delta = triggerShow;
                      _value = completeShow;
                    });
                  },
                  onDraggableCanceled: (velocity, offset) {
                    setState(() {
                      _delta = 0;
                      _value = 0;
                    });
                  },
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    Text("$_delta"),
                    SizedBox(width: 20),
                    VerticalDivider(
                      color: Colors.white,
                    ),
                    Text("$_value")
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
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
                                //backgroundReturn?.call();
                              },
                              //The DecoratedBox here is very important,he will fill the entire parent component
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
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 1)
                                ],
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      cancelFunc();
                                    },
                                  children: [
                                    TextSpan(text: '"sadsa" was deleted.'),
                                    TextSpan(
                                      text: " Undo?",
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text("click me"))
              ],
            ),
            Expanded(
              flex: 2,
              child: DragTarget(
                builder: (context, candidateData, rejectedData) {
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomOffsetAnimation extends StatefulWidget {
  final AnimationController controller;
  final Widget child;

  const CustomOffsetAnimation({Key? key, required this.controller, required this.child})
      : super(key: key);

  @override
  _CustomOffsetAnimationState createState() => _CustomOffsetAnimationState();
}

class _CustomOffsetAnimationState extends State<CustomOffsetAnimation> {
  late Tween<Offset> tweenOffset;
  late Tween<double> tweenScale;

  late Animation<double> animation;

  @override
  void initState() {
    tweenOffset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 2),
    );
    animation = CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: widget.child,
      animation: widget.controller,
      builder: (context, child) {
        return FractionalTranslation(
          translation: tweenOffset.evaluate(animation),
          child: Opacity(
            child: child,
            opacity: animation.value,
          ),
        );
      },
    );
  }
}
