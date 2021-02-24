
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class ImageComponentController extends GetxController {
  var imagePath = "".obs;
  final _picker = ImagePicker();
  
  void insertImage() async{
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
        imagePath.value = pickedFile.path;
      } else {

      }
  }
}
