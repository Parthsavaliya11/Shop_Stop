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
  List<fstoremodel> allfinal = [];
  String? proname, proprice, prodisp, prodocid;
}

class fstoremodel {
  String? productname, productprice, productdes, prodocid;

  fstoremodel(
      {this.productname, this.productprice, this.productdes, this.prodocid});

}