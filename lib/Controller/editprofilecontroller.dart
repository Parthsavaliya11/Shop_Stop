import 'dart:io';

import 'package:fierbase/model/editprofilemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Editprofile extends GetxController {
  Editprofile._();

  static final editprofile = Editprofile._();
  final editprofilekey = GlobalKey<FormState>();
  XFile? xFile;
  ImagePicker imagePicker = ImagePicker();
  File? file;
  RxBool isprocess = false.obs;
  RxBool iconhide = true.obs;
  RxString profileimg = "".obs;
  TextEditingController Utxt_uname = TextEditingController();
  TextEditingController Utxt_umobile = TextEditingController();
  String? refurl;
  RxDouble sindicator = 0.0.obs;
  Editprofilemodel? editprofilemodel;
}
