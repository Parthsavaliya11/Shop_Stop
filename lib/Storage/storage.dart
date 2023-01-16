import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:fierbase/Controller/addproductcontroller.dart';
import 'package:fierbase/Controller/editupdatecontroller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:uuid/uuid.dart';

import '../Controller/userprofile.dart';

class cloudStorageHelper {
  cloudStorageHelper._();

  static final storageHelp = cloudStorageHelper._();

  UploadTask? uploadTask;
  String? downloadurl;
  StreamSubscription? streamSubscription;

  void firestorage() {
    uploadTask = FirebaseStorage.instance
        .ref()
        .child("${Uuid().v1()}")
        .putFile(addproductcontroller.addpro.productpic!);
  }

  Future<String?> getstorage(BuildContext contextt) async {
    ProgressDialog pd = ProgressDialog(context: contextt);
    streamSubscription = uploadTask!.snapshotEvents.listen((event) {
      addproductcontroller.addpro.sindicator.value =
          event.bytesTransferred / event.totalBytes * 100;
      pd.show(
          completed: Completed(
              completedMsg: "Downloading Done !", completionDelay: 2500),
          closeWithDelay: 100,
          max: 100,
          progressType: ProgressType.valuable,
          msg: "Uploading",
          valueColor: Colors.blue,
          valuePosition: ValuePosition.right,
          elevation: 0,
          valueFontSize: 10.sp);
      pd.update(value: addproductcontroller.addpro.sindicator.value.toInt());
    });
    TaskSnapshot taskSnapshot = await uploadTask!;
    downloadurl = await taskSnapshot.ref.getDownloadURL();
    streamSubscription!.cancel();

    return downloadurl;
  }

  void postuserprofile() {
    uploadTask = FirebaseStorage.instance
        .ref()
        .child("${Uuid().v1()}")
        .putFile(File("${Profilecontroller.cont.profileimg.value}"));
  }

  Future<String?> getuserprofile() async {
    streamSubscription = uploadTask!.snapshotEvents.listen((event) {
      addproductcontroller.addpro.sindicator.value =
          event.bytesTransferred / event.totalBytes * 100;
    });
    TaskSnapshot taskSnapshot = await uploadTask!;
    downloadurl = await taskSnapshot.ref.getDownloadURL();
    streamSubscription!.cancel();

    return downloadurl;
  }

  Future<String?> updateimg(
      BuildContext context, String refurl, File updateimg) async {
      ProgressDialog pd = ProgressDialog(context: context);
    uploadTask = FirebaseStorage.instance
        .refFromURL("$refurl")
        .putFile(updateimg);

    //// get indicator values live
    streamSubscription = uploadTask!.snapshotEvents.listen((event) {
      Editupdatecontroller.editupdate.indicatorvalue =
          event.bytesTransferred / event.totalBytes * 100;

      pd.show(
          completed: Completed(
              completedMsg: "Downloading Done !"),
          max: 100,closeWithDelay: 100,
          progressType: ProgressType.valuable,
          msg: "Uploading",
          valueColor: Colors.blue,
          valuePosition: ValuePosition.right,
          elevation: 0,
          valueFontSize: 10.sp);
      pd.update(value: Editupdatecontroller.editupdate.indicatorvalue!.toInt());
    });


     pd.close(delay: 0);

      TaskSnapshot taskSnapshot = await uploadTask!;
    downloadurl = await taskSnapshot.ref.getDownloadURL();
    streamSubscription!.cancel();

    return downloadurl;
  }
}
