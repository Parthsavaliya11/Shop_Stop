import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fierbase/View/Customer/userhomewihouappbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sizer/sizer.dart';

import '../../Controller/homeScreenController.dart';
import '../../Controller/userhomecontroller.dart';
import '../../Controller/userprofile.dart';
import '../../firestore/fierStonehelper.dart';
import '../../main.dart';
import '../seller/searchpage.dart';
import '../userorseller.dart';

class Userhome extends StatefulWidget {
  const Userhome({Key? key}) : super(key: key);

  @override
  State<Userhome> createState() => _UserhomeState();
}

class _UserhomeState extends State<Userhome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeScreenController.homeController.authmethod =
        HomeScreenController.homeController.authseprate.read("auth");
    log("${HomeScreenController.homeController.authmethod} ccccccccccccccccc");
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
                      onPressed: alldataread,
                      icon: Icon(Icons.search),
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
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  onPageChanged: (index) {},
                  physics: NeverScrollableScrollPhysics(),
                  controller: Uhomecontroller.uhomecontroller.Uhometabcont,
                  children: [
                    Userhomewithoutbar(),
                    Userhomewithoutbar(),
                    Userhomewithoutbar(),
                    Userhomewithoutbar(),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                onTap: () {},
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
        bottomNavigationBar: GNav(
          selectedIndex: Uhomecontroller.uhomecontroller.tabindex.value,
          onTabChange: (tab) {
            Uhomecontroller.uhomecontroller.tabindex.value = tab;
            Uhomecontroller.uhomecontroller.Uhometabcont.animateToPage(tab,
                duration: Duration(milliseconds: 700),
                curve: Curves.easeInOutExpo);
          },
          textStyle: GoogleFonts.poppins(color: Colors.white),
          tabMargin: EdgeInsets.all(10),
          rippleColor: Colors.grey.shade100,
          // tab button ripple color when pressed
          haptic: true,
          // haptic feedback
          tabBorderRadius: 50,

          curve: Curves.easeIn,
          // tab animation curves
          duration: Duration(milliseconds: 500),
          // tab animation duration
          gap: 2,
          color: Colors.grey,
          activeColor: Colors.white,
          iconSize: 25,
          tabBackgroundColor: Colors.blueAccent,
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15),
          tabs: [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.favorite,
              text: "Fav",
            ),
            GButton(
              icon: Icons.shopping_cart,
              text: "Cart",
            ),
            GButton(
              icon: Icons.person,
              text: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
