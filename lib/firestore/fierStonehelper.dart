import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../Controller/searchpagecontroller.dart';

// create userprofile
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

// User Wise Data Store
void userwiefirestore(String productName, String productPrice, String dis,
    String uid, String picurl, String procategory) {
  final usercollection = FirebaseFirestore.instance
      .collection("Product")
      .doc("${uid}")
      .collection("data");

  usercollection.add({
    "productname": "$productName",
    "productprice": "$productPrice",
    "description": "$dis",
    "userid": "$uid",
    "imageurl": "$picurl",
    "category": "$procategory",
    "search": SearchPageController.searchcontroller.searchsystem(productName),
  });
}

// User Profile Details

void userprofileStorage(
    String username, String profillink, String uid, String mobile) {
  FirebaseFirestore.instance
      .collection("user")
      .doc("$uid")
      .collection("profiledetail")
      .add({
    "username": username,
    "userprofilelink": profillink,
    "mobile": "$mobile"
  });
}

Future<QuerySnapshot<Map<String, dynamic>>> readuserprofile() {
  return FirebaseFirestore.instance
      .collection("user")
      .doc("${FirebaseAuth.instance.currentUser!.uid}")
      .collection("profiledetail")
      .get();
}

void updatefirestore(String pn, String pp, String pd, String user) {
  CollectionReference users = FirebaseFirestore.instance.collection('Product');
  users.doc("$user").update(
      {"productname": "$pn", "productprice": "$pp", "description": "$pd"});
}

Stream<QuerySnapshot<Map<String, dynamic>>> readfirestore() {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  return firebaseFirestore.collection('Product').snapshots();
}

Stream<QuerySnapshot<Map<String, dynamic>>> searchwiseread() {
  return FirebaseFirestore.instance
      .collection("Product")
      .doc("${FirebaseAuth.instance.currentUser!.uid}")
      .collection("data")
      .where("search",
          arrayContains:
              SearchPageController.searchcontroller.searchkeywords.value)
      .snapshots();
}

Stream<QuerySnapshot<Map<String, dynamic>>> searchwisereadfull() {
  return FirebaseFirestore.instance
      .collection("Product")
      .doc("${FirebaseAuth.instance.currentUser!.uid}")
      .collection("data")
      .snapshots();
}

////////////////////////////////////////////////////////////////////////////////////////
Stream<QuerySnapshot<Map<String, dynamic>>> userwiseread() {
  return FirebaseFirestore.instance
      .collection("Product")
      .doc("${FirebaseAuth.instance.currentUser!.uid}")
      .collection("data")
      .snapshots();
}

Stream<QuerySnapshot<Map<String, dynamic>>> categorywise() {
  return FirebaseFirestore.instance
      .collection("Product")
      .doc("${FirebaseAuth.instance.currentUser!.uid}")
      .collection("data")
      .where("category",
          isEqualTo: SearchPageController.searchcontroller.category.value)
      .snapshots();
}

// userwise update firestore
void updateFirestore(String productName, String productPrice, String dis,
    String uid, String picurl, String procategory) {
  FirebaseFirestore.instance.collection("Product").doc("${uid}").update({
    "productname": "$productName",
    "productprice": "$productPrice",
    "description": "$dis",
    "userid": "$uid",
    "imageurl": "$picurl",
    "category": "$procategory",
    "search": SearchPageController.searchcontroller.searchsystem(productName)
  });
}

void updatedocFirestore(String productName, String productPrice, String dis,
    String uid, String picurl, String procategory, String docid) {
  FirebaseFirestore.instance
      .collection("Product")
      .doc("${uid}")
      .collection("data")
      .doc("$docid")
      .update({
    "productname": "$productName",
    "productprice": "$productPrice",
    "description": "$dis",
    "userid": "$uid",
    "imageurl": "$picurl",
    "category": "$procategory",
    "search": SearchPageController.searchcontroller.searchsystem(productName)
  });
}

void editProfile(String name, String mobile, String docid) {
  FirebaseFirestore.instance
      .collection("user")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("profiledetail")
      .doc("$docid")
      .update({
    "username": name,
    "mobile": mobile,
  });
}

Stream<QuerySnapshot<Map<String, dynamic>>> alldataread() {
  return FirebaseFirestore.instance.collection("Product").snapshots();
}
