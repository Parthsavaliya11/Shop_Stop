import 'dart:developer';
import 'dart:io';

import 'package:fierbase/Storage/storage.dart';
import 'package:fierbase/View/seller/homeScreen.dart';
import 'package:fierbase/firestore/fierStonehelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';
import '../../Controller/userprofile.dart';
import '../componets/buttons.dart';

class userprofile extends StatefulWidget {
  const userprofile({Key? key}) : super(key: key);

  @override
  State<userprofile> createState() => _userprofileState();
}

class _userprofileState extends State<userprofile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Form(
          key: Profilecontroller.cont.user,
          child: SingleChildScrollView(
            physics: MediaQuery.of(context).viewInsets.bottom == 0
                ? NeverScrollableScrollPhysics()
                : BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 40.h,
                  width: 100.w,
                  color: Colors.blueAccent,
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Profile SetUp",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25.sp))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: Center(
                    child: Container(
                      height: 70.h,
                      width: 90.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 30,
                            offset: Offset(0, 20),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Obx(
                            () => CupertinoButton(
                              onPressed: () async {
                                Profilecontroller.cont.xFile =
                                    await Profilecontroller.cont.imagePicker
                                        .pickImage(source: ImageSource.gallery);

                                Profilecontroller.cont.file =
                                    File(Profilecontroller.cont.xFile!.path);
                                Profilecontroller.cont.iconhide.value = false;
                                Profilecontroller.cont.profileimg.value =
                                    Profilecontroller.cont.xFile!.path;
                                cloudStorageHelper.storageHelp
                                    .postuserprofile();
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 4.h),
                                height: 17.h,
                                width: 17.h,
                                child: CircleAvatar(
                                  backgroundImage:
                                      Profilecontroller.cont.profileimg.value ==
                                              ""
                                          ? null
                                          : FileImage(
                                              File(
                                                  "${Profilecontroller.cont.profileimg.value}"),
                                            ),
                                  backgroundColor: Colors.blueAccent,
                                  child:
                                      Profilecontroller.cont.profileimg.value ==
                                              ""
                                          ? Icon(
                                              Icons.account_circle,
                                              size: 35,
                                            )
                                          : null,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5.w, left: 5.w),
                            child: TextFormField(
                              controller: Profilecontroller.cont.txt_uname,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  size: 25,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                hintText: 'Enter Username',
                                hintStyle: TextStyle(fontSize: 15),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(11),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 5.w, left: 5.w),
                            child: TextFormField(
                              controller: Profilecontroller.cont.txt_umobile,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  size: 25,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                hintText: 'Enter Mobile Number',
                                hintStyle: TextStyle(fontSize: 15),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(11),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Obx(
                            () => Padding(
                              padding: EdgeInsets.only(right: 5.w, left: 5.w),
                              child: SizedBox(
                                width: 90.w,
                                height: 7.h,
                                child: CupertinoButton(
                                    color: Colors.blueAccent,
                                    child: Text(
                                      "Submit",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    onPressed:
                                        Profilecontroller.cont.profileimg != ""
                                            ? () async {
                                                if (Profilecontroller.cont
                                                            .txt_uname.text !=
                                                        "" &&
                                                    Profilecontroller.cont
                                                            .txt_umobile.text !=
                                                        "") {
                                                  String? profillink =
                                                      await cloudStorageHelper
                                                          .storageHelp
                                                          .getuserprofile();

                                                  userprofileStorage(
                                                      Profilecontroller
                                                          .cont.txt_uname.text,
                                                      profillink!,
                                                      " ${FirebaseAuth.instance.currentUser!.uid}",
                                                      Profilecontroller.cont
                                                          .txt_umobile.text);

                                                  Get.offAll(homeScreen());
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      backgroundColor:
                                                          Colors.blueAccent,
                                                      duration: Duration(
                                                          milliseconds: 400),
                                                      content:
                                                          Text("Fill Setup"),
                                                    ),
                                                  );
                                                }
                                              }
                                            : null),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
