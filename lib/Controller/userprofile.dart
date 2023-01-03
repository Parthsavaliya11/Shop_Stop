import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Profilecontroller extends GetxController {
  Profilecontroller._();
  static final cont = Profilecontroller._();

  TextEditingController txt_uname = TextEditingController();
  TextEditingController txt_umobile = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  XFile? xFile;
  File? file;
  RxString profileimg = "".obs;
  RxBool iconhide = true.obs;
}
