import 'package:hive/hive.dart';

class SettingServices {
  Box settingBox = Hive.box("settings");

  bool get isLogin => settingBox.get("login") == null ? false : true;

  void setLogin() {
    settingBox.put("login", true);
  }
}
