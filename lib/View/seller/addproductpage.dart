import 'dart:io';
import 'package:fierbase/Controller/addproductcontroller.dart';
import 'package:fierbase/Storage/storage.dart';
import 'package:fierbase/firestore/fierStonehelper.dart';
import 'package:fierbase/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

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
        getstore.pronamee.clear();
        getstore.propricee.clear();
        getstore.prodescription.clear();
        addproductcontroller.addpro.productpic = null;
        return await true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                getstore.pronamee.clear();
                getstore.propricee.clear();
                getstore.prodescription.clear();
                addproductcontroller.addpro.productpic = null;
                Get.back();
              },
            ),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Form(
              key: getstore.k,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Product Detail",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CupertinoButton(
                                onPressed: () async {
                                  addproductcontroller.addpro.xFile =
                                      await addproductcontroller
                                          .addpro.imagePicker
                                          .pickImage(
                                              source: ImageSource.gallery);
                                  setState(() {
                                    addproductcontroller.addpro.productpic =
                                        File(addproductcontroller
                                            .addpro.xFile!.path);
                                  });
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 30.h,
                                      width: 30.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 0.5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade200,
                                            blurRadius: 40,
                                            offset: Offset(20, 20),
                                          ),
                                        ],
                                        color: Colors.grey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(2.h),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: addproductcontroller
                                                    .addpro.productpic !=
                                                null
                                            ? Image.file(
                                                addproductcontroller
                                                    .addpro.productpic!,
                                                fit: BoxFit.cover,
                                              )
                                            : Icon(Icons.upload,
                                                color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter Product Name' : null,
                              controller: getstore.pronamee,
                              maxLength: 30,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                              decoration: InputDecoration(
                                helperText: "enter product attractive name",
                                helperStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Product Name',
                                contentPadding: const EdgeInsets.only(
                                    left: 25.0, bottom: 5.0, top: 5.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter Product Price' : null,
                              controller: getstore.propricee,
                              maxLength: 30,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                              decoration: InputDecoration(
                                helperText: "enter product price please",
                                helperStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Product Price',
                                contentPadding: const EdgeInsets.only(
                                    left: 25.0, bottom: 5.0, top: 5.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.transparent),
                            child: TextFormField(
                              validator: (value) => value!.isEmpty
                                  ? 'Enter Product Description'
                                  : null,
                              controller: getstore.prodescription,
                              maxLength: 100,
                              autofocus: false,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                              decoration: InputDecoration(
                                helperText: "enter product short discription",
                                helperStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Description',
                                contentPadding: const EdgeInsets.only(
                                    left: 25.0, bottom: 5.0, top: 5.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.5.h),
                          child: DropdownButtonFormField(
                              onSaved: (selected) {
                                print("$selected -------------");
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
                                  backgroundColor: Colors.lightGreenAccent),
                              onPressed: addproductcontroller
                                          .addpro.productpic !=
                                      null
                                  ? () async {
                                      if (getstore.k.currentState!.validate()) {
                                        getstore.k.currentState!.save();
                                        Get.defaultDialog(
                                            title: "Shop Stop",
                                            radius: 10,
                                            titlePadding: EdgeInsets.all(20),
                                            backgroundColor: Colors.white,
                                            content: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Obx(
                                                    () => Text(
                                                      "${addproductcontroller.addpro.sindicator.toString()}",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: LoadingAnimationWidget
                                                      .threeRotatingDots(
                                                          color: Colors
                                                              .lightGreenAccent,
                                                          size: 50),
                                                ),
                                              ],
                                            ));

                                        addproductcontroller.addpro.imagepick(
                                            addproductcontroller
                                                .addpro.productpic!);
                                        cloudStorageHelper.storageHelp
                                            .firestorage();
                                        String? imageurl =
                                            await cloudStorageHelper.storageHelp
                                                .getstorage();
                                        userwiefirestore(
                                            getstore.pronamee.text,
                                            getstore.propricee.text,
                                            getstore.prodescription.text,
                                            "${getsign.userid.obs}",
                                            "${imageurl}",
                                            "${addproductcontroller.addpro.productcategory}");
                                        getlocal.showbuttonmethod();
                                        Get.snackbar("${"ShopStop"}",
                                            "Your Product Lauch Successfully");
                                        Get.offAllNamed('homeScreen');
                                        getstore.pronamee.clear();
                                        getstore.propricee.clear();
                                        getstore.prodescription.clear();
                                        addproductcontroller.addpro.productpic =
                                            null;
                                        addproductcontroller
                                            .addpro.sindicator.value = 0.0;
                                      } else {
                                        print('Form is invalid');
                                      }
                                    }
                                  : null,
                              child: Text(
                                "Add Customer",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
