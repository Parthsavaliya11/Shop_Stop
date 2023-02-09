import 'dart:developer';

import 'package:fierbase/View/Customer/cproductdetail.dart';
import 'package:fierbase/model/cProdetailModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../Controller/FavController.dart';
import '../../Controller/productdetailcontroller.dart';
import '../../Controller/searchpagecontroller.dart';
import '../../Controller/uproDetailcontroller.dart';
import '../../firestore/fierStonehelper.dart';
import '../../model/prodetailmodel.dart';
import '../../model/searchmodaldata.dart';
import '../seller/editproductpage.dart';

class Usersearch extends StatefulWidget {
  const Usersearch({Key? key}) : super(key: key);

  @override
  State<Usersearch> createState() => _UsersearchState();
}

class _UsersearchState extends State<Usersearch> {
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
                stream:  userKsearch(),

                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    log("${snapshot.error}");
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    var datalist = snapshot.data!.docs;
                    SearchPageController.searchcontroller.searchdata.clear();
                    for (var z in datalist) {
                      Searchmodeldata data = Searchmodeldata(
                        productname: z['productname'],
                        productprice: z['productprice'],
                        category: z['category'],
                        discription: z['description'],
                        imgurl: z['imageurl'],
                        docid: z.id,
                      );
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
                              onTap: () async {
                                Userprodetailcont
                                        .uprodetailcont.uproductdetail =
                                    Uproductdetail(
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
                                            .category,
                                        docid: SearchPageController
                                            .searchcontroller
                                            .searchdata[index]
                                            .docid);
                                Favcontroller.Favcont.e = (await Favexits(
                                    "${Userprodetailcont.uprodetailcont.uproductdetail.docid}"))!;
                                Get.to(Cproductdetail(),
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
