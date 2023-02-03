import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fierbase/View/Customer/cproductdetail.dart';
import 'package:fierbase/animation/fade_animation.dart';
import 'package:fierbase/animation/slide_animation.dart';
import 'package:fierbase/model/Uhomemodel.dart';
import 'package:fierbase/model/cProdetailModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../Controller/FavController.dart';
import '../../Controller/productdetailcontroller.dart';
import '../../Controller/uproDetailcontroller.dart';
import '../../Controller/userhomecontroller.dart';
import '../../firestore/fierStonehelper.dart';

class Userhomewithoutbar extends StatefulWidget {
  const Userhomewithoutbar({Key? key}) : super(key: key);

  @override
  State<Userhomewithoutbar> createState() => _UserhomewithoutbarState();
}

class _UserhomewithoutbarState extends State<Userhomewithoutbar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              SlideAnimation(
                begin: Offset(0, -400),
                intervalStart: 0.4,
                duration: Duration(milliseconds: 4000),
                child: CarouselSlider.builder(
                  itemCount: Uhomecontroller.uhomecontroller.imgsliderimg.length,
                  itemBuilder: (context, index, _) {
                    return Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                              "${Uhomecontroller.uhomecontroller.imgsliderimg[index]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
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
                    TextButton(
                      onPressed: () {
                        Uhomecontroller.uhomecontroller.category.value = "";
                      },
                      child: Text(
                        "Clear Filter",
                        style: GoogleFonts.poppins(fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: FadeAnimation(
                  child: SlideAnimation(
                    begin: Offset(500, 0),
                    intervalStart: 0.4,
                    duration: Duration(milliseconds: 4000),
                    child: Row(
                      children: Uhomecontroller.uhomecontroller.ctegorylist
                          .asMap()
                          .entries
                          .map(
                            (e) => Container(
                              margin: EdgeInsets.all(15),
                              child: InkWell(
                                onTap: () {
                                  Uhomecontroller.uhomecontroller.category.value =
                                      Uhomecontroller
                                          .uhomecontroller.ctegorylistnames[e.key];

                                  log("${Uhomecontroller.uhomecontroller.category.value}");
                                },
                                child: Ink(
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade400
                                                .withOpacity(0.5),
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
                                              "${Uhomecontroller.uhomecontroller.ctegorylist[e.key]}"),
                                        ),
                                        Text(
                                          "${Uhomecontroller.uhomecontroller.ctegorylistnames[e.key]}",
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
                ),
              ),
              Obx(
                () => StreamBuilder(
                  stream: Uhomecontroller.uhomecontroller.category.value == ""
                      ? alldataread()
                      : Usercategorywise(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasError) {
                      Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      Uhomecontroller.uhomecontroller.allfinal.clear();
                      var storedata = snapshot.data!;

                      for (var z in storedata.docs) {
                        Map finaldata = z.data() as Map<String, dynamic>;
                        String docid = z.id;
                        String proname = finaldata['productname'];
                        String proprice = finaldata['productprice'];
                        String prodisc = finaldata['description'];
                        String imglink = finaldata['imageurl'];
                        String category = finaldata['category'];
                        Uhomemodel f = Uhomemodel(
                            productname: proname,
                            productprice: proprice,
                            productdes: prodisc,
                            prodocimg: imglink,
                            category: category,
                            docid: docid);
                        Uhomecontroller.uhomecontroller.allfinal.value.add(f);
                      }

                      return Uhomecontroller.uhomecontroller.allfinal.length ==
                              0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SizedBox(
                                    height: 32.h,
                                    child:
                                        Image.asset("assets/images/cart.png"),
                                  ),
                                ),
                              ],
                            )
                          : SingleChildScrollView(
                              child: FadeAnimation(
                                intervalStart: 0.4,
                                duration: Duration(milliseconds: 2500),
                                child: SlideAnimation(
                                  begin: Offset(0, 400),
                                  intervalStart: 0.4,
                                  duration: Duration(milliseconds: 4000),
                                  child: StaggeredGrid.count(
                                    crossAxisCount: 2,
                                    children: Uhomecontroller
                                        .uhomecontroller.allfinal
                                        .map(
                                          (index) => Padding(
                                            padding: EdgeInsets.all(1.h),
                                            child: GestureDetector(
                                              onTap: () async {
                                                Userprodetailcont.uprodetailcont
                                                        .uproductdetail =
                                                    Uproductdetail(
                                                        productname:
                                                            index.productname,
                                                        productprice:
                                                            index.productprice,
                                                        discription:
                                                            index.productdes,
                                                        imgurl: index.prodocimg,
                                                        category: index.category,
                                                        docid: index.docid);
                                                Favcontroller.Favcont.e = (await Favexits(
                                                "${Userprodetailcont.uprodetailcont.uproductdetail.docid}"))!;
                                                Get.to(Cproductdetail(),
                                                    transition:
                                                        Transition.cupertino);
                                              },
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
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(2.w),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        height: 20.h,
                                                        width: double.infinity,
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10),
                                                            child: FadeInImage
                                                                .memoryNetwork(
                                                              placeholder:
                                                                  kTransparentImage,
                                                              fit: BoxFit.cover,
                                                              imageCacheHeight:
                                                                  1000,
                                                              //adding these two parameters
                                                              imageCacheWidth: 1000,
                                                              image:
                                                                  "${index.prodocimg}",
                                                            )),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 4.h,
                                                            width: 40.w,
                                                            child: Text(
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              "${index.productname}",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                            ),
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
                                                                    fontSize:
                                                                        14.sp),
                                                          ),
                                                          Text(
                                                            "${index.category}",
                                                            style:
                                                                GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .black),
                                                          )
                                                        ],
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
                              ),
                            );
                    }
                    return Center(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
