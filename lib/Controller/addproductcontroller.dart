import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class addproductcontroller extends GetxController {
  addproductcontroller._();

  static final addpro = addproductcontroller._();
  ImagePicker imagePicker = ImagePicker();
  XFile? xFile;
  File? productpic;
  RxString imgpath = "".obs;
  RxString pic = "".obs;
  RxDouble sindicator = 0.0.obs;
  RxBool heart = true.obs;
  List<String> dropdown = ["Electric", "Fashion", "LifeStyle", "Kitchen"];
  RxString productcategory = "".obs;

  void imagepick(dynamic file) async {
    productpic = file;
    pic.value = file.path;
  }

  void heartchange(bool h) {
    heart.value = !h;
  }

  void changecategory(String category) {

    productcategory.value = category;
  }
}
