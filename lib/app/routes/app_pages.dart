import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:note_app/app/modules/add_folder/views/add_folder_view.dart';
import 'package:note_app/app/modules/add_note/bindings/add_note_bindings.dart';
import 'package:note_app/app/modules/add_note/views/add_note_view.dart';
import 'package:note_app/app/modules/edit_note/bindings/edit_note_binding.dart';
import 'package:note_app/app/modules/edit_note/views/edit_note_view.dart';
import 'package:note_app/app/modules/home/bindings/home_binding.dart';
import 'package:note_app/app/modules/home/views/home_view.dart';
import 'package:note_app/app/modules/note_by_folder/views/note_by_folder_view.dart';
import 'package:note_app/app/modules/setting/bindings/setting_binding.dart';
import 'package:note_app/app/modules/setting/views/setting_view.dart';
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
      page: () => SafeArea(child: StartupView()),
      binding: StartupBinding(),
    ),
    GetPage(
      name: _Paths.ADDNOTE,
      page: () => SafeArea(child: AddNoteView()),
      binding: AddNoteBindings(),
    ),
    GetPage(
      name: _Paths.ADDFOLDER,
      page: () => SafeArea(child: AddFolderView()),
    ),
    GetPage(
      name: _Paths.NOTEBYFOLDER,
      page: () => SafeArea(child: NoteByFolderView()),
    ),
    GetPage(
      name: _Paths.EDIT_NOTE,
      page: () => EditNoteView(),
      binding: EditNoteBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
  ];
}
