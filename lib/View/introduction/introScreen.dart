import 'dart:developer';

import 'package:fierbase/Controller/spleshController.dart';
import 'package:fierbase/View/seller/testLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Controller/introcontroller.dart';

class interoScreen extends StatefulWidget {
  const interoScreen({Key? key}) : super(key: key);

  @override
  State<interoScreen> createState() => _interoScreenState();
}

class _interoScreenState extends State<interoScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImage(AssetImage("assets/images/f1.jpg"), context);
    precacheImage(AssetImage("assets/images/f2.jpg"), context);
    precacheImage(AssetImage("assets/images/f3.jpg"), context);
    spleashController.spleash.introcontroller.write("intro", true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              padEnds: true,
              onPageChanged: (index) {
                log("${index}");
                IntroController.introcontrol.pagechange(index);
              },
              controller: IntroController.introcontrol.indicator,
              children: IntroController.introcontrol.introscreen,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 35.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RichText(
                        strutStyle: StrutStyle(),
                        softWrap: true,
                        maxLines: 2,
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: true),
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 36),
                          children: [
                            TextSpan(
                                text: '${"All Fashion"} ',
                                style: GoogleFonts.poppins(fontSize: 35.sp)),
                            TextSpan(
                                text: '${"Stop "} ',
                                style: GoogleFonts.poppins(fontSize: 35.sp)),
                            TextSpan(
                                text: '${"SHOPSTOP\n"} ',
                                style: GoogleFonts.poppins(
                                    fontSize: 40.sp,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                              text: '${"We Fill Your All Need"} ',
                              style: GoogleFonts.poppins(
                                letterSpacing: 2.sp,
                                fontSize: 25.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        textScaleFactor: 0.5,
                      ),
                      SmoothPageIndicator(
                        effect: WormEffect(
                            dotHeight: 1.5.h,
                            dotWidth: 1.5.h,
                            activeDotColor: Colors.blueAccent),
                        controller: IntroController.introcontrol.indicator,
                        count: 3,
                      ),
                      SizedBox(
                        width: 90.w,
                        height: 7.h,
                        child: Obx(
                          () => CupertinoButton(
                              color: Colors.blueAccent,
                              child: IntroController
                                          .introcontrol.pagecount.value ==
                                      2
                                  ? Text("Done")
                                  : Text("Next"),
                              onPressed: () {
                                precacheImage(
                                    AssetImage("assets/images/f1.jpg"),
                                    context);
                                precacheImage(
                                    AssetImage("assets/images/f2.jpg"),
                                    context);
                                precacheImage(
                                    AssetImage("assets/images/f3.jpg"),
                                    context);
                                IntroController.introcontrol.pagecount.value !=
                                        2
                                    ? IntroController.introcontrol.indicator
                                        .nextPage(
                                            duration:
                                                Duration(milliseconds: 700),
                                            curve: Curves.ease)
                                    : null;
                                if (IntroController
                                        .introcontrol.pagecount.value ==
                                    2) {
                                  spleashController.spleash.introcontroller.write("key", "true");



                                  Get.offAll(loginscreen(),
                                      transition: Transition.leftToRight);
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
