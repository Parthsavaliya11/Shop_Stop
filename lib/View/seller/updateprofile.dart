import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:fierbase/Storage/storage.dart';
import 'package:fierbase/firestore/fierStonehelper.dart';
import 'package:fierbase/firestore/firestore%20controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../Controller/editprofilecontroller.dart';
import '../../Controller/homeScreenController.dart';
import '../../Controller/userprofile.dart';
import 'homeScreen.dart';

class Updateprofile extends StatefulWidget {
  const Updateprofile({Key? key}) : super(key: key);

  @override
  State<Updateprofile> createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Editprofile.editprofile.Utxt_uname = TextEditingController(
        text: Editprofile.editprofile.editprofilemodel!.uname);
    Editprofile.editprofile.Utxt_umobile = TextEditingController(
        text: Editprofile.editprofile.editprofilemodel!.umobile);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: Editprofile.editprofile.editprofilekey,
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
                      Text("Profile Update",
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
                                Editprofile.editprofile.xFile =
                                    await Editprofile.editprofile.imagePicker
                                        .pickImage(source: ImageSource.gallery);

                                Editprofile.editprofile.profileimg.value =
                                    Editprofile.editprofile.xFile!.path;
                                Editprofile.editprofile.iconhide.value = false;
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 4.h),
                                height: 17.h,
                                width: 17.h,
                                child: CircleAvatar(
                                  backgroundImage: Editprofile
                                              .editprofile.profileimg.value !=
                                          ""
                                      ? FileImage(
                                          File(
                                              "${Editprofile.editprofile.profileimg.value}"),
                                        )
                                      : null,
                                  backgroundColor: Colors.blueAccent,
                                  child: Editprofile
                                              .editprofile.profileimg.value ==
                                          ""
                                      ? ClipOval(
                                          child: Image.network(
                                              height: 17.h,
                                              width: 17.h,
                                              fit: BoxFit.cover,
                                              "${Editprofile.editprofile.editprofilemodel!.refurl}"))
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
                              controller: Editprofile.editprofile.Utxt_uname,
                              keyboardType: TextInputType.name,
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
                              controller: Editprofile.editprofile.Utxt_umobile,
                              keyboardType: TextInputType.number,
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
                          Padding(
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
                                  onPressed: () async {
                                    if (Editprofile
                                            .editprofile.profileimg.value !=
                                        '') {
                                      FirebaseStorage.instance
                                          .refFromURL(
                                              "${Editprofile.editprofile.refurl}")
                                          .putFile(
                                            File(Editprofile
                                                .editprofile.profileimg.value),
                                          );
                                    } else {}
                                    editProfile(
                                        Editprofile.editprofile.Utxt_uname.text,
                                        Editprofile
                                            .editprofile.Utxt_umobile.text,
                                        Editprofile.editprofile
                                            .editprofilemodel!.docid!);
                                    HomeScreenController.homeController.tabindex.value = 0;
                                    Get.offAll(homeScreen());
                                  }),
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
