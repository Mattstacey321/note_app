import 'package:get/get.dart';
import 'package:note_app/app/data/services/setting_services.dart';
import 'package:note_app/app/routes/app_pages.dart';

class StartupController extends GetxController {
  SettingServices _settingServices = SettingServices();
  void getStarted() {
    Get.offAndToNamed(Routes.HOME);
    _settingServices.setLogin();
  }
}
