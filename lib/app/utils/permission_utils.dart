import 'package:permission_handler/permission_handler.dart';

class PermissionUltis {
  Future<bool> isReadExtStoragePermissionGranted() async{
    return Permission.storage.isGranted;
  }

  void readExternalStorage() async {
    await Permission.storage.request();
  }
}
