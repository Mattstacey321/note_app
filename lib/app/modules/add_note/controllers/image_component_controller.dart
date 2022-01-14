import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageComponentController extends GetxController {
  var imagePath = "".obs;
  final _picker = ImagePicker();

  void insertImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    } else {}
  }
}
