import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fierbase/Controller/addproductcontroller.dart';
import 'package:fierbase/Controller/searchcontroller.dart';
import 'package:fierbase/Controller/userprofile.dart';
import 'package:fierbase/Firebase/Messaging/messageing.dart';
import 'package:fierbase/Storage/storage.dart';
import 'package:fierbase/View/seller/addproductpage.dart';
import 'package:fierbase/firestore/fierStonehelper.dart';
import 'package:fierbase/firestore/firestore%20controller.dart';
import 'package:fierbase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
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
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          splashColor: Colors.white,
          onPressed: () {
            Get.to(addproduct(), transition: Transition.leftToRightWithFade);
          },
          backgroundColor: Colors.blueAccent,
          label: Text(
            "Product",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              StreamBuilder(
                  stream: readuserprofile(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      var userdata = snapshot.data!.docs;

                      Profilecontroller.cont.alluserdetail.clear();

                      for (QueryDocumentSnapshot z in userdata) {
                        var datadocs = z.data() as Map<String, dynamic>;

                        UserprofileData u = UserprofileData(
                            username: datadocs['username'],
                            mobile: datadocs['mobile'],
                            userprofilelink: datadocs['userprofilelink']);
                        Profilecontroller.cont.alluserdetail.value.add(u);
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.blueAccent,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 8.h,
                                      width: 8.h,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "${Profilecontroller.cont.alluserdetail[0].userprofilelink}"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${Profilecontroller.cont.alluserdetail[0].username}",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "${FirebaseAuth.instance.currentUser!.email}",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 11.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Manage Products",
                                        style: GoogleFonts.poppins(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: homeScreenController,
                              duration: Duration(),
                              child: ListTile(
                                leading: Icon(
                                  Icons.edit_note_rounded,
                                  size: 3.5.h,
                                ),
                                title: Text(
                                  "Update Products",
                                  style: GoogleFonts.poppins(fontSize: 13.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  }),
              // InkWell(
              //   onTap: () {
              //     getsign.logout();
              //     getsign.googlelogout();
              //     Get.offAllNamed('login');
              //   },
              //   child: ListTile(
              //     title: Text("Logout"),
              //     leading: Icon(
              //       Icons.logout,
              //       size: 25,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 8.h,
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            "Shop Stop",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 17.sp),
          ),
          backgroundColor: Colors.blueAccent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(4.h),
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
                            physics: getstore.allfinal.length > 4
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

void getsignin() async {
  getsign.signdetail();
}
// StreamBuilder(
// stream: readuserprofile(),
// )
// StreamBuilder(
// stream: readuserprofile(),
// builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// if (snapshot.hasError) {
// return Text("${snapshot.error}");
// } else if (snapshot.hasData) {
// var userdata = snapshot.data!.docs;
//
// Profilecontroller.cont.alluserdetail.clear();
//
// for (QueryDocumentSnapshot z in userdata) {
// var datadocs = z.data() as Map<String, dynamic>;
//
// UserprofileData u = UserprofileData(
// username: datadocs['username'],
// mobile: datadocs['mobile'],
// userprofilelink: datadocs['userprofilelink']);
// Profilecontroller.cont.alluserdetail.value.add(u);
// }
// return GestureDetector(
// onTap: (){},
// child: Padding(
// padding: EdgeInsets.only(
// top: 1.9.h, left: 1.9.h, bottom: 1.9.h, right: 1.9.h),
// child: CircleAvatar(
// backgroundImage: NetworkImage(
// "${Profilecontroller.cont.alluserdetail[0].userprofilelink}"),
// ),
// ),
// );
// }
// return CircularProgressIndicator();
// }),
