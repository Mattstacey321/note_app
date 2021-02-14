
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/app/theme/app_colors.dart';

class AppThemes {
  BuildContext _context;

  AppThemes(BuildContext context) : _context = context;
  ThemeData get darkTheme => getDarkTheme();
  ThemeData get lightTheme => getLightTheme();

  ThemeData getDarkTheme() {
    return ThemeData.dark().copyWith(
      textTheme: GoogleFonts.montserratTextTheme().apply(
        bodyColor: Colors.white
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.buttonColor,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.amber,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.grey
      ),
      scaffoldBackgroundColor: AppColors.mainColor,
      backgroundColor: AppColors.mainColor,
    );
  }

  ThemeData getLightTheme() {
    return ThemeData.light();
  }
}
