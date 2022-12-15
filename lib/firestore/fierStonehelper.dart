import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fierbase/main.dart';
import 'package:get/get.dart';

void createfirestore(
  String productName,
  String productPrice,
  String dis,
  String uid,
) async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference collectionReference =
      await firebaseFirestore.collection("Product");
  collectionReference
      .add({
        "productname": "$productName",
        "productprice": "$productPrice",
        "description": "$dis",
        "userid": "$uid",
      })
      .then((value) => Get.snackbar("Shop Stop", "Success"))
      .catchError(
        (error) => Get.snackbar("Shop Stop", "Not Valid"),
      );
}

void userwiefirestore(
    String productName, String productPrice, String dis, String uid) {
  FirebaseFirestore.instance
      .collection("Product")
      .doc("${uid}")
      .collection("data")
      .add({
    "productname": "$productName",
    "productprice": "$productPrice",
    "description": "$dis",
    "userid": "$uid",
  });
}

Stream<QuerySnapshot<Map<String, dynamic>>> readfirestore() {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  return firebaseFirestore.collection('Product').snapshots();
}

Stream<QuerySnapshot<Map<String, dynamic>>> userwiseread() {
  return FirebaseFirestore.instance
      .collection("Product")
      .doc("${getsign.userid}")
      .collection("data")
      .snapshots();
}

void updatefirestore(String pn, String pp, String pd, String user) {
  CollectionReference users = FirebaseFirestore.instance.collection('Product');
  users.doc("$user").update(
      {"productname": "$pn", "productprice": "$pp", "description": "$pd"});
}
// users.doc('Product')..update(
// {"productname": "$pn", "productprice": "$pp", "description": "$pd"});
