import 'package:fierbase/Controller/addproductcontroller.dart';
import 'package:fierbase/Controller/productdetailcontroller.dart';
import 'package:fierbase/Storage/storage.dart';
import 'package:fierbase/View/seller/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../Controller/homeScreenController.dart';
import '../../firestore/fierStonehelper.dart';
import '../../main.dart';

class editproduct extends StatefulWidget {
  const editproduct({Key? key}) : super(key: key);

  @override
  State<editproduct> createState() => _editproductState();
}

class _editproductState extends State<editproduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h, bottom: 4.h),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Product Detail",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 60.h,
                      width: double.infinity,
                      child: Image.network(
                          fit: BoxFit.cover,
                          "${ProductDetailCont.detailcontroller.productdetailmodel.imgurl}"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                    height: 5.h,
                    width: double.infinity,
                    color: Colors.white.withOpacity(0.5),
                    child: Padding(
                      padding:  EdgeInsets.only(left: 2.w,right: 2.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            width: 55.w,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "${ProductDetailCont.detailcontroller.productdetailmodel.productname}",
                              style: GoogleFonts.poppins(color: Colors.white,
                                  fontSize: 18.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "\$",
                                style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${ProductDetailCont.detailcontroller.productdetailmodel.productprice}",
                                style: GoogleFonts.poppins(
                                    fontSize: 18.sp, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(2.5.h),
          child: SizedBox(
            height: 50,
            width: 340,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () async {},
              child: Text(
                "Update Product",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
