import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/data/models/note.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';

class NoteItemFeedback extends StatefulWidget {
  final Note note;
  NoteItemFeedback({required this.note});
  @override
  _NoteItemFeedbackState createState() => _NoteItemFeedbackState();
}

class _NoteItemFeedbackState extends State<NoteItemFeedback> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation positionAnim;
  late Animation rotateAnim;
  late Animation slideAnim;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: 800.milliseconds);
    positionAnim = RelativeRectTween(
            begin: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
            end: RelativeRect.fromLTRB(0.0, 10.0, 0.0, 0.0))
        .animate(
            CurvedAnimation(parent: _controller, curve: Interval(0.15, 0.20, curve: Curves.ease)))
      ..addListener(() {
        setState(() {});
      });
    slideAnim = Tween(begin: Offset.zero, end: Offset(0.1, 0.15)).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    rotateAnim = Tween(begin: 0.0, end: math.pi / 36).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.1, curve: Curves.easeInOut)))
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // slide -> rotale -> scale
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    var deleteMode = controller.deleteMode.value;
    if (deleteMode) {
      _controller.forward();
    } else
      _controller.reverse();
    return ObxValue<Rxn<DragUpdateDetails>>(
      (res) {
        var dragDetails = res.value!; //NOTE
        var dy = Get.height - dragDetails.globalPosition.dy;
        var scale = (1 - 1 / (dy / 100));

        if (scale <= 0.3) {
          scale = 0.3;
        }
        return Transform.rotate(
          angle: rotateAnim.value,
          alignment: Alignment.bottomRight,
          child: Transform.translate(
            offset: slideAnim.value,
            child: Transform.scale(
              alignment: Alignment.center,
              scale: scale,
              child: Container(
                height: 220,
                width: 180,
                decoration: BoxDecoration(
                  color: Color(0xff3F3A47),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Material(
                  type: MaterialType.transparency,
                  elevation: 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      widget.note.title,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      controller.dragDetail,
    );
  }
}
