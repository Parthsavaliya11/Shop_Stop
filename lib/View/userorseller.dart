import 'dart:developer';

import 'package:fierbase/View/componets/buttons.dart';
import 'package:fierbase/View/seller/testLogin.dart';
import 'package:fierbase/View/seller/testsignup.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:sizer/sizer.dart';

import '../Controller/homeScreenController.dart';

class Userorseller extends StatefulWidget {
  const Userorseller({Key? key}) : super(key: key);

  @override
  State<Userorseller> createState() => _UserorsellerState();
}

class _UserorsellerState extends State<Userorseller> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -65.h,
                  child: SizedBox(
                    height: 100.h,
                    width: 100.h,
                    child: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Center(
                  child: Text(
                    "CHOOSE ONE \nFOR NEXT STEP",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        height: 1.2,
                        fontSize: 25.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: Center(
                    child: Text(
                      "Welcome To Our App And Choose One \nStep And Start Your Journey",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        height: 1.5,
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: SizedBox(
                      height: 40.h,
                      child: RiveAnimation.asset("assets/riveassets/walk.riv")),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        bigbtn("User",  loginscreen(), "user"),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "OR",
                          style: GoogleFonts.poppins(),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        bigbtn("Seller", loginscreen(), "seller"),
                      ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
