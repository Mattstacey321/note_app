import 'package:flutter/material.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';
import 'package:note_app/app/theme/index.dart';
import 'package:get/get.dart';

class NoteItemHolder extends StatefulWidget {
  final int index;
  NoteItemHolder(this.index);

  @override
  _NoteItemHolderState createState() => _NoteItemHolderState();
}

class _NoteItemHolderState extends State<NoteItemHolder> with SingleTickerProviderStateMixin {
  /*AnimationController controller;
  Animation animation;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: 200.milliseconds);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return AnimatedOpacity(
      opacity: controller.currentIndex.value == widget.index ? 0 : 1,                                                                                                                                                                    
      duration: 800.milliseconds,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
      child: Container(
        height: 180,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.itemColor,
        ),
      ),
    );
  }
}
