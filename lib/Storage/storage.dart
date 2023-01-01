import 'dart:async';
import 'dart:developer';

import 'package:fierbase/Controller/addproductcontroller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

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

  Future<String?> getstorage() async {
    streamSubscription = uploadTask!.snapshotEvents.listen((event) {
      addproductcontroller.addpro.sindicator.value =
          event.bytesTransferred / event.totalBytes * 100;
    });
    TaskSnapshot taskSnapshot = await uploadTask!;
    downloadurl = await taskSnapshot.ref.getDownloadURL();
    streamSubscription!.cancel();

    return downloadurl;
  }
}
