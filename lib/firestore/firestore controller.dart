import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class firestoreget extends GetxController {
  TextEditingController pronamee = TextEditingController();
  TextEditingController propricee = TextEditingController();
  TextEditingController prodescription = TextEditingController();
  TextEditingController upronamee = TextEditingController();
  TextEditingController upropricee = TextEditingController();
  TextEditingController uprodescription = TextEditingController();
  final k = GlobalKey<FormState>();
  var alldocs;
  RxList<fstoremodel> allfinal = <fstoremodel>[].obs;
  RxString proname = "".obs,
      proprice = "".obs,
      prodisp = "".obs,
      prodocid = "".obs;
}

class fstoremodel {
  String? productname, productprice, productdes, prodocimg;

  fstoremodel(
      {this.productname, this.productprice, this.productdes, this.prodocimg});
}
