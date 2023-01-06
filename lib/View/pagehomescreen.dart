import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Controller/homeScreenController.dart';
import '../Controller/searchpagecontroller.dart';
import '../firestore/fierStonehelper.dart';
import '../firestore/firestore controller.dart';
import '../main.dart';

class pagehome extends StatefulWidget {
  const pagehome({Key? key}) : super(key: key);

  @override
  State<pagehome> createState() => _pagehomeState();
}

class _pagehomeState extends State<pagehome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Products Category",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16.sp),
                  ),
                  Text(
                    "filter",
                    style: GoogleFonts.poppins(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: HomeScreenController.homeController.ctegorylist
                    .asMap()
                    .entries
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.all(15),
                        child: InkWell(
                          onTap: () {
                            SearchPageController
                                    .searchcontroller.category.value =
                                HomeScreenController
                                    .homeController.ctegorylistnames[e.key];
                            log("${SearchPageController
                                .searchcontroller.category.value}");
                          },
                          child: Ink(
                            height: 10.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Colors.grey.shade400.withOpacity(0.5),
                                      blurRadius: 10,
                                      offset: Offset(0, 7))
                                ],
                                border: Border.all(
                                    color: Colors.blueAccent, width: 0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    height: 11.h,
                                    width: 11.w,
                                    child: Image.asset(
                                        "${HomeScreenController.homeController.ctegorylist[e.key]}"),
                                  ),
                                  Text(
                                    "${HomeScreenController.homeController.ctegorylistnames[e.key]}",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            StreamBuilder(
              stream: SearchPageController.searchcontroller.category == ''
                  ? userwiseread()
                  : categorywise(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  getstore.allfinal.clear();
                  var storedata = snapshot.data!;

                  for (var z in storedata.docs) {
                    Map finaldata = z.data() as Map<String, dynamic>;

                    String proname = finaldata['productname'];
                    String proprice = finaldata['productprice'];
                    String prodisc = finaldata['description'];
                    String imglink = finaldata['imageurl'];
                    fstoremodel f = fstoremodel(
                      productname: proname,
                      productprice: proprice,
                      productdes: prodisc,
                      prodocimg: imglink,
                    );
                    getstore.allfinal.value.add(f);
                  }
                  return getstore.allfinal.length == 0
                      ? Expanded(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 32.h,
                              child: Image.asset("assets/images/cart.png"),
                            ),
                          ],
                        ))
                      : Expanded(
                          child: SingleChildScrollView(
                            physics: getstore.allfinal.length >= 4
                                ? BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  )
                                : null,
                            child: StaggeredGrid.count(
                                crossAxisCount: 2,
                                children: getstore.allfinal
                                    .map(
                                      (index) => Padding(
                                        padding: EdgeInsets.all(1.h),
                                        child: Container(
                                          height: 35.h,
                                          width: 10.h,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0.2,
                                                  color: Colors.grey),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade200,
                                                    blurRadius: 10,
                                                    offset: Offset(0, 5))
                                              ]),
                                          child: Padding(
                                            padding: EdgeInsets.all(2.w),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 20.h,
                                                  width: double.infinity,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                        fit: BoxFit.cover,
                                                        "${index.prodocimg}"),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${index.productname}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${index.productprice} \$",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 35,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              shape:
                                                                  StadiumBorder(),
                                                              backgroundColor:
                                                                  Colors
                                                                      .blueAccent),
                                                          onPressed: () {},
                                                          child: Text(
                                                            "Edit",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .white),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()),
                          ),
                        );
                }
                return const Center(
                  child: SizedBox(
                    height: 35,
                    width: 35,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
