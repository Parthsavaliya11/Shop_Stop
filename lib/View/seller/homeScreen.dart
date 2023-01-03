import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fierbase/Controller/addproductcontroller.dart';
import 'package:fierbase/Controller/searchcontroller.dart';
import 'package:fierbase/Firebase/Messaging/messageing.dart';
import 'package:fierbase/View/seller/addproductpage.dart';
import 'package:fierbase/firestore/fierStonehelper.dart';
import 'package:fierbase/firestore/firestore%20controller.dart';
import 'package:fierbase/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebasenoti();
    getsignin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          splashColor: Colors.lightGreen,
          onPressed: () {
            Get.to(addproduct(), transition: Transition.leftToRightWithFade);
          },
          backgroundColor: Colors.lightGreenAccent,
          label: Text(
            "Product",
            style: TextStyle(color: Colors.black),
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  getsign.logout();
                  getsign.googlelogout();
                  Get.offAllNamed('login');
                },
                child: ListTile(
                  title: Text("Logout"),
                  leading: Icon(
                    Icons.logout,
                    size: 25,
                  ),
                ),
              ),
              Obx(() => Text("${getsign.userid}")),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "Shop Stop",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.lightGreenAccent,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(3.h),
              child: TextField(
                controller: getstore.propricee,
                autofocus: false,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Product Price',
                  border: InputBorder.none,
                ),
              ),
            ),
            StreamBuilder(
              stream: userwiseread(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  getstore.allfinal.clear();

                  // for (var z in storedata) {
                  //   Map finaldata = z.data() as Map<String, dynamic>;
                  //
                  //   String proname = finaldata['productname'];
                  //   String proprice = finaldata['productprice'];
                  //   String prodisc = finaldata['description'];
                  //   String imglink = finaldata['imageurl'];
                  //   fstoremodel f = fstoremodel(
                  //     productname: proname,
                  //     productprice: proprice,
                  //     productdes: prodisc,
                  //     prodocimg: imglink,
                  //   );
                  //   getstore.allfinal.value.add(f);
                  // }
                  return getstore.allfinal.length == 0
                      ? Expanded(
                          child: Center(
                              child: Text("Launch Your First Product.....")))
                      : Expanded(
                          child: SingleChildScrollView(
                            physics: getstore.allfinal.length > 4
                                ? BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  )
                                : null,
                            child: StaggeredGrid.count(
                                crossAxisCount: 2,
                                children: getstore.allfinal
                                    .map((index) => Padding(
                                        padding: EdgeInsets.all(1.h),
                                        child: Container(
                                          height: 35.h,
                                          width: 10.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade200,
                                                    blurRadius: 3.h,
                                                    offset: Offset(1.h, 2.h)),
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
                                                      style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                                                      style: TextStyle(
                                                          fontSize: 15.sp),
                                                    ),
                                                    Icon(
                                                        Icons.favorite_outline),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )))
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

void getsignin() async {
  getsign.signdetail();
}
