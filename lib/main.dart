import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import "package:hive_flutter/hive_flutter.dart";
import 'package:note_app/app/data/db/hive_db.dart';
import 'package:note_app/app/data/services/setting_services.dart';
import 'package:note_app/app/theme/app_theme.dart';

import 'app/routes/app_pages.dart';

void main() async {
  AppThemes themes = AppThemes();
  await Hive.initFlutter();
  await HiveDb.init();
  SettingServices settingServices = SettingServices();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
    NotificationListener(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowGlow();
        return false;
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        initialRoute: settingServices.isLogin ? Routes.HOME : Routes.STARTUP,
        theme: themes.lightTheme,
        darkTheme: themes.darkTheme,
        themeMode: ThemeMode.dark,
        getPages: AppPages.routes,
      ),
    ),
  );
}
