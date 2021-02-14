import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:note_app/app/modules/home/bindings/home_binding.dart';
import 'package:note_app/app/modules/home/views/home_view.dart';
import 'package:note_app/app/modules/startup/bindings/startup_binding.dart';
import 'package:note_app/app/modules/startup/views/startup_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => SafeArea(child: HomeView()),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.STARTUP,
      page: () => SafeArea(child:StartupView()),
      binding: StartupBinding(),
    ),
  ];
}
