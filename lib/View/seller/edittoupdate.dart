import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:fierbase/Controller/addproductcontroller.dart';
import 'package:fierbase/Controller/editupdatecontroller.dart';
import 'package:fierbase/Storage/storage.dart';
import 'package:fierbase/View/seller/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../Controller/homeScreenController.dart';
import '../../firestore/fierStonehelper.dart';
import '../../main.dart';
import '../componets/txtfields.dart';

class editupdate extends StatefulWidget {
  const editupdate({Key? key}) : super(key: key);

  @override
  State<editupdate> createState() => _editupdateState();
}

class _editupdateState extends State<editupdate> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Editupdatecontroller.editupdate.txt_proprice = TextEditingController(
        text: Editupdatecontroller.editupdate.updatemodel.productprice);
    Editupdatecontroller.editupdate.txt_proname = TextEditingController(
        text: Editupdatecontroller.editupdate.updatemodel.productname);
    Editupdatecontroller.editupdate.txt_prodiscription = TextEditingController(
        text: Editupdatecontroller.editupdate.updatemodel.discription);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: Editupdatecontroller.editupdate.key,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.h, bottom: 2.h),
                      child: Text(
                        "Product Gallery",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Obx(
                        () => CupertinoButton(
                          onPressed: () async {
                            Editupdatecontroller.editupdate.xFile =
                                await Editupdatecontroller
                                    .editupdate.imagePicker
                                    .pickImage(source: ImageSource.gallery);

                            Editupdatecontroller.editupdate.imgpath.value =
                                await Editupdatecontroller
                                    .editupdate.xFile!.path;
                          },
                          child: DottedBorder(
                            dashPattern: [6, 4, 6, 4],
                            color: Colors.blueAccent,
                            padding: EdgeInsets.all(10),
                            child: Container(
                              height: 30.h,
                              width: 30.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Editupdatecontroller
                                            .editupdate.imgpath.value ==
                                        ''
                                    ? Image.network(
                                        "${Editupdatecontroller.editupdate.updatemodel.imgurl}",
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        fit: BoxFit.cover,
                                        File(
                                            "${Editupdatecontroller.editupdate.imgpath.value}")),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h, bottom: 4.h),
                      child: Text(
                        "Product Details",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent),
                      ),
                    ),
                    addtxtfiels(
                        TextInputAction.next,
                        Editupdatecontroller.editupdate.txt_proname,
                        TextInputType.text,
                        "Product Name",
                        "Enter Name",
                        maxline: 25),
                    addtxtfiels(
                        TextInputAction.next,
                        Editupdatecontroller.editupdate.txt_proprice,
                        TextInputType.number,
                        "Product Price",
                        "Enter Price",
                        maxline: 5),
                    addtxtfiels(
                        TextInputAction.done,
                        Editupdatecontroller.editupdate.txt_prodiscription,
                        TextInputType.text,
                        "Product Description",
                        "Enter Description",
                        maxline: 200),
                    Padding(
                      padding: EdgeInsets.all(2.5.h),
                      child: DropdownButtonFormField(
                        value: Editupdatecontroller
                            .editupdate.updatemodel.category,
                        onSaved: (selected) {
                          Editupdatecontroller.editupdate.updatedcategory
                              .value = selected.toString();
                        },
                        validator: (value) {
                          if (value == "") {
                            return 'Please Select Category';
                          }
                          return null;
                        },
                        hint: Text("Product Category"),
                        focusColor: Colors.lightGreenAccent,
                        items: addproductcontroller.addpro.dropdown
                            .map((e) => DropdownMenuItem<String>(
                                value: e, child: Text("${e}")))
                            .toList(),
                        onChanged: (String? value) {
                          Editupdatecontroller
                              .editupdate.updatedcategory.value = value!;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.5.h),
                      child: SizedBox(
                        height: 50,
                        width: 340,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent),
                          onPressed: () async {
                            String? link;
                            Editupdatecontroller.editupdate.imgpath.value != ''
                                ? Editupdatecontroller
                                        .editupdate.updatedimg.value =
                                    (await cloudStorageHelper.storageHelp.updateimg(
                                        context,
                                        Editupdatecontroller
                                            .editupdate.updatemodel.imgurl!,
                                        File(
                                            "${Editupdatecontroller.editupdate.imgpath.value}")))!
                                : Editupdatecontroller
                                        .editupdate.updatedimg.value =
                                    Editupdatecontroller
                                        .editupdate.updatemodel.imgurl!;

                            log("$link aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                            Editupdatecontroller.editupdate.key.currentState!
                                .save();
                            updatedocFirestore(
                                Editupdatecontroller
                                    .editupdate.txt_proname.text,
                                Editupdatecontroller
                                    .editupdate.txt_proprice.text,
                                Editupdatecontroller
                                    .editupdate.txt_prodiscription.text,
                                FirebaseAuth.instance.currentUser!.uid,
                                Editupdatecontroller
                                    .editupdate.updatedimg.value,
                                Editupdatecontroller
                                    .editupdate.updatedcategory.value,
                                Editupdatecontroller
                                    .editupdate.updatemodel.docid!);
                            Get.offAll(homeScreen());
                          },
                          child: Text(
                            "Update Product",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
