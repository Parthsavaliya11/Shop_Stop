import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/updatemodel.dart';

class Editupdatecontroller extends GetxController
{
  Editupdatecontroller._();
  static final editupdate = Editupdatecontroller._();
  double? indicatorvalue;
  final updateproduct = GlobalKey<FormState>();
  ImagePicker imagePicker = ImagePicker();
  XFile? xFile;
  String? updatedimgurl;
  File? productpic;
  RxString imgpath = "".obs;
  RxString pic = "".obs;
  Updatemodel updatemodel = Updatemodel();
  RxString updatedcategory = "".obs , updatedimg = "".obs;
  final key = GlobalKey<FormState>();

  TextEditingController txt_proname = TextEditingController();
  TextEditingController txt_proprice = TextEditingController();
  TextEditingController txt_prodiscription = TextEditingController();

  void editupdatevalidation()
  {
  }

}