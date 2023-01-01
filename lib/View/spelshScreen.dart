import 'dart:async';

import 'package:fierbase/main.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sizer/sizer.dart';

class spelshScreen extends StatefulWidget {
  const spelshScreen({Key? key}) : super(key: key);

  @override
  State<spelshScreen> createState() => _spelshScreenState();
}

class _spelshScreenState extends State<spelshScreen> {
  bool check = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocal.init();
    check = getsign.checkuser();
  }

  @override
  Widget build(BuildContext context) {
     Timer(Duration(seconds: 4), () => checkuserton());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Stack(children: [
          Center(
            child: SizedBox(
              height: 30.h,
              child: Image.asset("assets/images/shopstopwhite.png"),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: JumpingDotsProgressIndicator(
              color: Colors.white,
              numberOfDots: 5,
              milliseconds: 100,
              fontSize: 35.sp,
            ),
          ),


        ]),
      ),
    );
  }

  void checkuserton() async {
    check == true
        ? await Get.offNamed('homeScreen')
        : await Get.offNamed('intro');
  }
}
