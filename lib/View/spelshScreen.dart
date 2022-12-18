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
  bool? check;

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
        backgroundColor: Colors.lightGreenAccent,
        body: Center(
          child: Column(

            children: [
              Align(
                alignment: Alignment.center,
                child: Center(
                  child: SizedBox(
                    height: 250,
                    child: Image.asset("assets/images/shopstop.png"),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: JumpingDotsProgressIndicator(
                  numberOfDots: 5,
                  milliseconds: 100,
                  fontSize: 70.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkuserton() async {
    check == true
        ? await Get.offNamed('homeScreen')
        : await Get.offNamed('testlogin');
  }
}
