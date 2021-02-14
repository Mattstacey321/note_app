import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static ButtonStyle getStartedButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    minimumSize: MaterialStateProperty.all(
      Size(140, 50),
    ),
    backgroundColor: MaterialStateProperty.all(AppColors.buttonColor),
  );
}
