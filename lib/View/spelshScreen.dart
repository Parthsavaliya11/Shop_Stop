import 'dart:async';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:fierbase/View/homeScreen.dart';
import 'package:fierbase/View/signinScreen.dart';
import 'package:fierbase/main.dart';
import 'package:fierbase/model/Signindetailmodel;.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';

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
    check = getsign.checkuser();
    getlocal.init();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () => checkuserton());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightGreenAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/images/shopstop.png")),
            Align(
              alignment: Alignment.bottomCenter,
              child: JumpingDotsProgressIndicator(
                numberOfDots: 5,
                milliseconds: 100,
                fontSize: 80.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

 void checkuserton() async {
    check == true
        ? await Get.offAll(homeScreen(), transition: Transition.upToDown)
        : await Get.offAll(signIn(), transition: Transition.upToDown);


  }
}
