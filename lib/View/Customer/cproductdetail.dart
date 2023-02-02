import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fierbase/Controller/uproDetailcontroller.dart';
import 'package:fierbase/firestore/fierStonehelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import '../../Controller/FavController.dart';
import '../../Controller/cartcontroller.dart';

class Cproductdetail extends StatefulWidget {
  const Cproductdetail({Key? key}) : super(key: key);

  @override
  State<Cproductdetail> createState() => _CproductdetailState();
}

class _CproductdetailState extends State<Cproductdetail> {
  bool? e;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxScrooled) {
            return [
              SliverAppBar(
                snap: true,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: IconButton(
                      iconSize: 25,
                      onPressed: () async {
                        Favcontroller.Favcont.e = (await Favexits(
                            "${Userprodetailcont.uprodetailcont.uproductdetail.docid}"))!;
                        if (Favcontroller.Favcont.e) {
                          Fluttertoast.showToast(msg: "Already Fav...");
                        } else {
                          Fluttertoast.showToast(msg: "Add To Wishlist");
                          addFav();
                          setState(() {
                            Favcontroller.Favcont.e = true;
                          });
                        }
                      },
                      icon: Icon(
                        Favcontroller.Favcont.e == true
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
                toolbarHeight: 10.h,
                iconTheme: IconThemeData(color: Colors.black),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.white,
                floating: true,
                title: SizedBox(
                  height: 13.h,
                  width: 13.h,
                  child: Image.asset("assets/images/shopstopblue.png"),
                ),
              ),
            ];
          },
          body: Padding(
            padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 50.h,
                            width: double.infinity,
                            child: Image.network(
                                fit: BoxFit.cover,
                                "${Userprodetailcont.uprodetailcont.uproductdetail.imgurl}"),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 4.w, right: 4.w, top: 4.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 40,
                                width: 55.w,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  "${Userprodetailcont.uprodetailcont.uproductdetail.productname}",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "\$ ${Userprodetailcont.uprodetailcont.uproductdetail.productprice}",
                                style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueAccent),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h),
                          child: ReadMoreText(
                              style: GoogleFonts.poppins(fontSize: 12.sp),
                              trimLines: 3,
                              lessStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                              colorClickableText: Colors.pink,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show More',
                              trimExpandedText: 'Show Less',
                              moreStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600),
                              "${Userprodetailcont.uprodetailcont.uproductdetail.discription} "),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
              onPressed: () async {
                bool? e = await exits(
                    "${Userprodetailcont.uprodetailcont.uproductdetail.docid}");

                if (e!) {
                  Fluttertoast.showToast(
                    msg: "Already Added",
                  );
                } else {
                  Fluttertoast.showToast(msg: "Item add To Cart");
                  FirebaseFirestore.instance
                      .collection("Cart")
                      .doc("${FirebaseAuth.instance.currentUser!.uid}")
                      .collection("usercart")
                      .doc(
                          "${Userprodetailcont.uprodetailcont.uproductdetail.docid}")
                      .set({
                    "productname":
                        "${Userprodetailcont.uprodetailcont.uproductdetail.productname}",
                    "productprice":
                        "${Userprodetailcont.uprodetailcont.uproductdetail.productprice}",
                    "description":
                        "${Userprodetailcont.uprodetailcont.uproductdetail.discription}",
                    "userid": "${FirebaseAuth.instance.currentUser!.uid}",
                    "imageurl":
                        "${Userprodetailcont.uprodetailcont.uproductdetail.imgurl}",
                    "category":
                        "${Userprodetailcont.uprodetailcont.uproductdetail.category}",
                    "docid":
                        "${Userprodetailcont.uprodetailcont.uproductdetail.docid}",
                  });
                }
              },
              child: Text(
                "Add To Cart ",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Fluttertoast.cancel();
    Favcontroller.Favcont.e = false;
  }
}
