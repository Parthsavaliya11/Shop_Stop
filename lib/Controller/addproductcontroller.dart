import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
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

  RxBool indicator_Flag = false.obs;

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

  Future<File?> imagecropper({required File file}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blueAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),

      ],
    );
    log("${File("${croppedFile!.path}").lengthSync()} pppppppppppppppppppppppppp");

    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }

  Future<File?> compressor({required File file}) async {
    var compressfile = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, file.path + 'compress.jpg',
        quality: 50);
    log("${compressfile!.lengthSync()} cccccccccccccccccccccccccooooooooooooooooooooo");
    return File(compressfile.path);
  }
}
