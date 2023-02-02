import 'dart:developer';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:fierbase/Controller/addproductcontroller.dart';
import 'package:fierbase/Storage/storage.dart';
import 'package:fierbase/View/componets/txtfields.dart';
import 'package:fierbase/firestore/fierStonehelper.dart';
import 'package:fierbase/firestore/firestore%20controller.dart';
import 'package:fierbase/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../Controller/homeScreenController.dart';

class addproduct extends StatefulWidget {
  const addproduct({Key? key}) : super(key: key);

  @override
  State<addproduct> createState() => _addproductState();
}

class _addproductState extends State<addproduct> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        firestoreget.Firestoreget.pronamee.clear();
        firestoreget.Firestoreget.propricee.clear();
        firestoreget.Firestoreget.prodescription.clear();
        addproductcontroller.addpro.productpic = null;
        return await true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Form(
            key: firestoreget.Firestoreget.k,
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
                          child: CupertinoButton(
                            onPressed: () async {
                              addproductcontroller.addpro.xFile =
                                  await addproductcontroller.addpro.imagePicker
                                      .pickImage(source: ImageSource.gallery);

                              File? croppedimg = await addproductcontroller
                                  .addpro
                                  .imagecropper(
                                file: File(
                                    "${addproductcontroller.addpro.xFile!.path}"),
                              );

                              File? compressedimg =
                                  await addproductcontroller.addpro.compressor(
                                      file: File("${croppedimg!.path}"));

                              setState(() {
                                addproductcontroller.addpro.productpic =
                                    compressedimg;

                              });
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
                                  child:
                                      addproductcontroller.addpro.productpic !=
                                              null
                                          ? Image.file(
                                              addproductcontroller
                                                  .addpro.productpic!,
                                              fit: BoxFit.cover,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.upload,
                                                    color: Colors.black),
                                                SizedBox(height: 5.h),
                                                Text(
                                                  "Browse Document",
                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ],
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
                            firestoreget.Firestoreget.pronamee,
                            TextInputType.text,
                            "Product Name",
                            "Enter Name",
                            maxline: 25),
                        addtxtfiels(
                            TextInputAction.next,
                            firestoreget.Firestoreget.propricee,
                            TextInputType.number,
                            "Product Price",
                            "Enter Price",
                            maxline: 5),
                        addtxtfiels(
                            TextInputAction.done,
                            firestoreget.Firestoreget.prodescription,
                            TextInputType.text,
                            "Product Description",
                            "Enter Description",
                            maxline: 200),
                        Padding(
                          padding: EdgeInsets.all(2.5.h),
                          child: DropdownButtonFormField(
                              onSaved: (selected) {
                                addproductcontroller.addpro
                                    .changecategory(selected.toString());
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please Select Category';
                                }
                              },
                              hint: Text("Product Category"),
                              focusColor: Colors.lightGreenAccent,
                              items: addproductcontroller.addpro.dropdown
                                  .map((e) => DropdownMenuItem<String>(
                                      value: e, child: Text("${e}")))
                                  .toList(),
                              onChanged: (value) {}),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.5.h),
                          child: SizedBox(
                            height: 50,
                            width: 340,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent),
                              onPressed: addproductcontroller
                                          .addpro.productpic !=
                                      null
                                  ? () async {
                                      if (firestoreget
                                          .Firestoreget.k.currentState!
                                          .validate()) {
                                        firestoreget
                                            .Firestoreget.k.currentState!
                                            .save();

                                        addproductcontroller.addpro.imagepick(
                                            addproductcontroller
                                                .addpro.productpic!);
                                        cloudStorageHelper.storageHelp
                                            .firestorage();
                                        String? imageurl =
                                            await cloudStorageHelper.storageHelp
                                                .getstorage(context);
                                        userwiefirestore(
                                            firestoreget
                                                .Firestoreget.pronamee.text,
                                            firestoreget
                                                .Firestoreget.propricee.text,
                                            firestoreget.Firestoreget
                                                .prodescription.text,
                                            "${getsign.userid.obs}",
                                            "$imageurl",
                                            "${addproductcontroller.addpro.productcategory}");
                                        getlocal.showbuttonmethod();
                                        Get.snackbar("${"ShopStop"}",
                                            "Your Product Lauch Successfully");
                                        Get.offAllNamed('homeScreen');
                                        firestoreget.Firestoreget.pronamee
                                            .clear();
                                        firestoreget.Firestoreget.propricee
                                            .clear();
                                        firestoreget.Firestoreget.prodescription
                                            .clear();
                                        addproductcontroller.addpro.productpic =
                                            null;
                                        addproductcontroller
                                            .addpro.sindicator.value = 0.0;
                                        HomeScreenController
                                            .homeController.tabindex.value = 0;
                                      } else {
                                        print('Form is invalid');
                                      }
                                    }
                                  : null,
                              child: Text(
                                "Launch Product",
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
        ),
      ),
    );
  }
}
// getstore.pronamee.clear();
// getstore.propricee.clear();
// getstore.prodescription.clear();
// addproductcontroller.addpro.productpic = null;
// Get.back();
// Get.defaultDialog(
// title: "Shop Stop",
// radius: 10,
// titlePadding: EdgeInsets.all(20),
// backgroundColor: Colors.white,
// content: Column(
// children: [
// Padding(
// padding:
// const EdgeInsets.all(8.0),
// child: Obx(
// () => Text(
// "${addproductcontroller.addpro.sindicator.toString()}",
// style: TextStyle(
// fontSize: 20),
// ),
// ),
// ),
// Padding(
// padding:
// const EdgeInsets.all(8.0),
// child: LoadingAnimationWidget
//     .threeRotatingDots(
// color: Colors
//     .lightGreenAccent,
// size: 50),
// ),
// ],
// ));
