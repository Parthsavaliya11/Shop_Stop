import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

void createfirestore(
  String productName,
  String productPrice,
  String dis,
  String uid,
) async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference collectionReference =
      firebaseFirestore.collection("Product");
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

void userwiefirestore(String productName, String productPrice, String dis,
    String uid, String picurl, String procategory) {
  FirebaseFirestore.instance
      .collection("Product")
      .doc("${uid}")
      .collection("data")
      .add({
    "productname": "$productName",
    "productprice": "$productPrice",
    "description": "$dis",
    "userid": "$uid",
    "imageurl": "$picurl",
    "category": "$procategory",

  });
// }void userwiefirestore(String productName, String productPrice, String dis,
//     String uid, String picurl, String procategory) {
//   FirebaseFirestore.instance
//       .collection("Product")
//       .doc("${uid}")
//       .collection("data")
//       .add({
//     "productname": "$productName",
//     "productprice": "$productPrice",
//     "description": "$dis",
//     "userid": "$uid",
//     "imageurl": "$picurl",
//     "category": "$procategory"
//   });
// }

}


  void updatefirestore(String pn, String pp, String pd, String user) {
    CollectionReference users = FirebaseFirestore.instance.collection(
        'Product');
    users.doc("$user").update(
        {"productname": "$pn", "productprice": "$pp", "description": "$pd"});
  }

Stream<QuerySnapshot<Map<String, dynamic>>> readfirestore() {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  return firebaseFirestore.collection('Product').snapshots();
}

Stream<QuerySnapshot<Map<String, dynamic>>> userwiseread() {
  return FirebaseFirestore.instance
      .collection("Product")
      .doc("${FirebaseAuth.instance.currentUser!.uid}")
      .collection("data")
      .snapshots();
}

// List<String> searchkeywords(String char) {
//   List<String> charsearch = [];
//   String temp = "";
//   for (int i = 0; i < char.length; i++) {
//     temp = temp + char[i];
//     charsearch.add(temp);
//   }
//   return charsearch;
// }
// users.doc('Product')..update(
// {"productname": "$pn", "productprice": "$pp", "description": "$pd"});
