import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fierbase/Controller/homeScreenController.dart';
import 'package:fierbase/Firebase/Messaging/messageing.dart';
import 'package:fierbase/View/pagehomescreen.dart';
import 'package:fierbase/View/seller/addproductpage.dart';
import 'package:fierbase/View/seller/adminaccountpage.dart';
import 'package:fierbase/View/seller/searchpage.dart';
import 'package:fierbase/View/userorseller.dart';
import 'package:fierbase/firestore/firestore%20controller.dart';
import 'package:fierbase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fierbase/Controller/addproductcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sizer/sizer.dart';
import '../../Controller/userprofile.dart';
import '../../firestore/fierStonehelper.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  GetStorage g1 = GetStorage();
  String? auth;

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
        bottomNavigationBar: GNav(
          selectedIndex: HomeScreenController.homeController.tabindex.value,
          onTabChange: (tab) {
            HomeScreenController.homeController.tabindex.value = tab;
            HomeScreenController.homeController.tabcontroller.animateToPage(tab,
                duration: Duration(milliseconds: 700),
                curve: Curves.easeInOutExpo);
          },
          textStyle: GoogleFonts.poppins(color: Colors.white),
          tabMargin: EdgeInsets.all(13),
          rippleColor: Colors.grey.shade100,
          // tab button ripple color when pressed
          haptic: true,
          // haptic feedback
          tabBorderRadius: 50,

          curve: Curves.easeIn,
          // tab animation curves
          duration: Duration(milliseconds: 500),
          // tab animation duration
          gap: 10,
          color: Colors.grey,
          activeColor: Colors.white,
          iconSize: 30,
          tabBackgroundColor: Colors.blueAccent,
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15),
          tabs: [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.add,
              text: "Add New",
            ),
            GButton(
              onPressed: () {},
              icon: Icons.person,
              text: "Profile",
            ),
          ],
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          child: Column(
            children: [
              HomeScreenController.homeController.authmethod == "custom"
                  ? FutureBuilder(
                      future: readuserprofile(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else if (snapshot.hasData) {
                          Profilecontroller.cont.alluserdetail.clear();
                          var userdata = snapshot.data!.docs;

                          for (QueryDocumentSnapshot z in userdata) {
                            var datadocs = z.data() as Map<String, dynamic>;

                            UserprofileData u = UserprofileData(
                                username: datadocs['username'],
                                mobile: datadocs['mobile'],
                                userprofilelink: datadocs['userprofilelink']);
                            Profilecontroller.cont.alluserdetail.value.add(u);
                            log("${Profilecontroller.cont.alluserdetail.value}");
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
                                          height: 6.h,
                                          width: 6.h,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "${Profilecontroller.cont.alluserdetail[0].userprofilelink}"),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${Profilecontroller.cont.alluserdetail[0].username}",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 15.sp,
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
                              ],
                            ),
                          );
                        }
                        return CircularProgressIndicator();
                      })
                  : Center(
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
                                    height: 6.h,
                                    width: 6.h,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "${FirebaseAuth.instance.currentUser!.photoURL}"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${FirebaseAuth.instance.currentUser!.displayName}",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        "${FirebaseAuth.instance.currentUser!.email}",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 8.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Manage Profile",
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(addproduct());
                },
                child: ListTile(
                  leading: Icon(
                    Icons.edit_note_rounded,
                    size: 3.5.h,
                  ),
                  title: Text(
                    "Update Profile",
                    style: GoogleFonts.poppins(fontSize: 13.sp),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  HomeScreenController.homeController.authseprate
                      .remove("auth");

                  getsign.logout();
                  getsign.googlelogout();
                  Get.offAll(Userorseller());
                },
                child: ListTile(
                  leading: Icon(
                    Icons.logout_rounded,
                    size: 3.2.h,
                  ),
                  title: Text(
                    "Logout",
                    style: GoogleFonts.poppins(fontSize: 13.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 10.h,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: SizedBox(
            height: 13.h,
            width: 13.h,
            child: Image.asset("assets/images/shopstopblue.png"),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: IconButton(
                iconSize: 25,
                onPressed: () {
                  Get.to(SearchPage(), transition: Transition.rightToLeft);
                },
                icon: Icon(Icons.search),
              ),
            ),
          ],
        ),
        body: PageView(
          onPageChanged: (index) {
            firestoreget.Firestoreget.pronamee.clear();
            firestoreget.Firestoreget.propricee.clear();
            firestoreget.Firestoreget.prodescription.clear();
            addproductcontroller.addpro.productpic = null;
            addproductcontroller.addpro.indicator_Flag.value = false;
          },
          physics: NeverScrollableScrollPhysics(),
          controller: HomeScreenController.homeController.tabcontroller,
          children: [
            pagehome(),
            addproduct(),
            Adminaccountpage(),
          ],
        ),
      ),
    );
  }
}

Future<void> getsignin() async {
  HomeScreenController.homeController.authmethod =
      HomeScreenController.homeController.authseprate.read("auth");
  log("${HomeScreenController.homeController.authmethod}");
  getsign.signdetail();
}
