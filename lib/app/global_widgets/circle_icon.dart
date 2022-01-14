import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final Icon icon;
  final VoidCallback? onTap;
  final Color? bgColor;
  final String tooltip;
  CircleIcon({required this.onTap, required this.icon, this.bgColor, required this.tooltip});
  @override
  Widget build(BuildContext context) {
    final double iconSize = 25;
    return Material(
      color: Colors.transparent,
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(1000),
          onTap: onTap,
          child: Container(
            height: iconSize,
            width: iconSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              color: bgColor,
            ),
            child: IconTheme(
              data: IconThemeData(
                size: iconSize - 10,
                color: Colors.white,
              ),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
