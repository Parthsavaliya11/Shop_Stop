import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fierbase/View/seller/editproductpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../Controller/productdetailcontroller.dart';
import '../../Controller/searchpagecontroller.dart';
import '../../firestore/fierStonehelper.dart';
import '../../model/prodetailmodel.dart';
import '../../model/searchmodaldata.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(right: 5.w, left: 5.w, top: 5.h, bottom: 2.h),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    SearchPageController.searchcontroller.searchkeywords.value =
                        value;
                    SearchPageController.searchcontroller.keywordsearch(value);
                  });
                },
                controller: SearchPageController.searchcontroller.txtsearch,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 18.0, color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 25,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Explore Item',
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
            StreamBuilder(
                stream: (SearchPageController
                                .searchcontroller.searchkeywords.value !=
                            "" &&
                        SearchPageController
                                .searchcontroller.searchkeywords.value !=
                            null)
                    ? searchwiseread()
                    : searchwisereadfull(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("No Found");
                  } else if (snapshot.hasData) {
                    var datalist = snapshot.data!.docs;
                    SearchPageController.searchcontroller.searchdata.clear();
                    for (var z in datalist) {
                      Searchmodeldata data = Searchmodeldata(
                          productname: z['productname'],
                          productprice: z['productprice'],
                          category: z['category'],
                          discription: z['description'],
                          imgurl: z['imageurl']);
                      SearchPageController.searchcontroller.searchdata
                          .add(data);
                    }
                    return Expanded(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          itemCount: SearchPageController
                              .searchcontroller.searchdata.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                ProductDetailCont
                                        .detailcontroller.productdetailmodel =
                                    Productdetailmodel(
                                        productname: SearchPageController
                                            .searchcontroller
                                            .searchdata[index]
                                            .productname,
                                        productprice: SearchPageController
                                            .searchcontroller
                                            .searchdata[index]
                                            .productprice,
                                        discription: SearchPageController
                                            .searchcontroller
                                            .searchdata[index]
                                            .discription,
                                        imgurl: SearchPageController
                                            .searchcontroller
                                            .searchdata[index]
                                            .imgurl,
                                        category: SearchPageController
                                            .searchcontroller
                                            .searchdata[index]
                                            .category);
                                Get.to(editproduct(),
                                    transition: Transition.cupertino);
                              },
                              child: ListTile(
                                leading: Icon(Icons.search),
                                title: Text(
                                  "${SearchPageController.searchcontroller.searchdata[index].productname}",
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
// }(name != "
// "
// &&
// name != null
// )
// ?
// Firestore.instance
//     .collection('
// items
// '
// )
// .
// where
// ("searchKeywords
// "
// ,
// arrayContains: name).
// snapshots
// (
// ): Firestore.instance.collection("
// items
// "
// )
// .
// snapshots
// (
// ),
