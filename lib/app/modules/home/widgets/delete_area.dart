import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/app/global_widgets/circle_icon.dart';
import 'package:note_app/app/modules/home/controllers/home_controller.dart';

class DeleteArea extends StatefulWidget {
  @override
  _DeleteAreaState createState() => _DeleteAreaState();
}

class _DeleteAreaState extends State<DeleteArea> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation dragAreaAnim;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: 200.milliseconds);
    dragAreaAnim = Tween<double>(begin: -150.0, end: 0).animate(_controller)
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

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    bool showDeleteZone = controller.showDeleteZone.value;
    showDeleteZone ? _controller.forward() : _controller.reverse();
    return AnimatedPositioned(
      height: Get.height,
      width: Get.width,
      duration: 350.milliseconds,
      curve: Curves.fastOutSlowIn,
      bottom: dragAreaAnim.value,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: DottedBorder(
            dashPattern: [6, 6],
            borderType: BorderType.RRect,
            radius: Radius.circular(15),
            strokeWidth: 2.5,
            color: Colors.red[900]!,
            child: ObxValue<RxBool>(
              (res) {
                return AnimatedContainer(
                  height: 100,
                  duration: 200.milliseconds,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: res.value ? Colors.red[200] : Colors.red[100],
                  ),
                  width: Get.width - 20,
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(
                    duration: 200.milliseconds,
                    child: res.value ? DeleteScaleButton() : SplashText(),
                  ),
                );
              },
              controller.showDeleteBtn,
            ),
          ),
        ),
      ),
    );
  }
}

class SplashText extends StatefulWidget {
  @override
  _SplashTextState createState() => _SplashTextState();
}

class _SplashTextState extends State<SplashText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: 800.milliseconds);
    scaleAnimation = Tween<double>(begin: 0.0, end: 5.0).animate(_controller)
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

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    bool showDeleteBtn = controller.showDeleteBtn.value;
    showDeleteBtn ? _controller.forward() : _controller.reverse();
    //bool showDeleteBtn = controller.showDeleteBtn.value;
    /*Future.delayed(500.milliseconds, () {
      showDeleteBtn ? _controller.forward() : _controller.reverse();
    });*/
    return Obx(() {
      bool showDeleteBtn = controller.showDeleteBtn.value;
      showDeleteBtn ? _controller.forward() : _controller.reverse();
      return Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: showDeleteBtn ? 0 : 1,
            child: Text(
              "Drag here to delete",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red[900],
              ),
            ),
          ),
          Transform.scale(
            scale: scaleAnimation.value,
            child: AnimatedContainer(
              duration: 500.milliseconds,
              height: scaleAnimation.value * 20,
              width: scaleAnimation.value * 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withOpacity(0.2),
              ),
            ),
          )
        ],
      );
    });
  }
}

class DeleteScaleButton extends StatefulWidget {
  @override
  DeleteScaleButtonState createState() => DeleteScaleButtonState();
}

class DeleteScaleButtonState extends State<DeleteScaleButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: 200.milliseconds);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
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

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    bool showDeleteBtn = controller.showDeleteBtn.value;
    showDeleteBtn ? _controller.forward() : _controller.reverse();
    return DragTarget(
      onAccept: (Map data) {
        controller.deleteNote(data);
      },
      builder: (context, candidateData, rejectedData) {
        return Transform.scale(
          scale: animation.value * 2,
          child: CircleIcon(
            onTap: null,
            bgColor: Colors.white,
            icon: Icon(
              EvaIcons.trash,
              color: Colors.red,
            ),
            tooltip: "",
          ),
        );
      },
    );
  }
}
