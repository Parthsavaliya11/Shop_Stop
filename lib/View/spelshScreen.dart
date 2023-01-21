import 'dart:async';

import 'package:fierbase/Controller/spleshController.dart';
import 'package:fierbase/main.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
    String? k = spleashController.spleash.introcontroller.read("key");

    print("$k -------ghjwewetklwthl");
    // check == true
    //     ? await Get.offNamed('homeScreen')
    //     : await Get.offNamed('intro');
    GetStorage getStorage = GetStorage();

    // this is a check user login is userlogin or seller login
    String? key = getStorage.read("U");

    check == true
        ? (k == "true"
            ? await Get.offNamed(key == "seller" ? 'homeScreen' : "userhome")
            : await Get.offNamed('intro'))
        : k == "true"
            ? await Get.offNamed('userorseller')
            : await Get.offNamed('intro');
  }
}
