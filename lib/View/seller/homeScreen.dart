import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fierbase/Controller/addproductcontroller.dart';
import 'package:fierbase/Controller/homeScreenController.dart';
import 'package:fierbase/Controller/searchcontroller.dart';
import 'package:fierbase/Controller/searchpagecontroller.dart';
import 'package:fierbase/Controller/userprofile.dart';
import 'package:fierbase/Firebase/Messaging/messageing.dart';
import 'package:fierbase/Storage/storage.dart';
import 'package:fierbase/View/componets/txtfields.dart';
import 'package:fierbase/View/pagehomescreen.dart';
import 'package:fierbase/View/seller/addproductpage.dart';
import 'package:fierbase/View/seller/searchpage.dart';
import 'package:fierbase/firestore/fierStonehelper.dart';
import 'package:fierbase/firestore/firestore%20controller.dart';
import 'package:fierbase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sizer/sizer.dart';

import '../componets/homeDrawer.dart';

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
        drawer: dwr(),
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
          physics: BouncingScrollPhysics(),
          controller: HomeScreenController.homeController.tabcontroller,
          children: [
            pagehome(),
            addproduct(),
            pagehome(),
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
