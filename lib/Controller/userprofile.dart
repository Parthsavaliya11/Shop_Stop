import 'dart:async';
import 'dart:io';

import 'package:fierbase/Controller/addproductcontroller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

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
  final user = GlobalKey<FormState>();
  GetStorage userformcount = GetStorage();
  RxList<UserprofileData> alluserdetail = <UserprofileData>[].obs;

}

class UserprofileData {
  String? mobile, username, userprofilelink,docid;

  UserprofileData({this.mobile, this.username, this.userprofilelink,this.docid});
}
