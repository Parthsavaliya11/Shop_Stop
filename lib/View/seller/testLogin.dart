import 'package:fierbase/View/seller/homeScreen.dart';
import 'package:fierbase/View/seller/testsignup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';
import '../componets/buttons.dart';
import '../componets/txtfields.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Form(
          key: getstore.loginkey,
          child: Container(
            height: 100.h,
            width: 100.w,
            child: SingleChildScrollView(
              physics: MediaQuery.of(context).viewInsets.bottom == 0
                  ? NeverScrollableScrollPhysics()
                  : BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
              child: Padding(
                padding: EdgeInsets.only(top: 4.h, bottom: 6.h),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 30.h,
                        child: Image.asset("assets/images/shopstopblue.png"),
                      ),
                    ),
                    txtfield("Invalid", "Enter The Email", Icons.person,
                        getsign.txt_mailIn),
                    SizedBox(
                      height: 5.h,
                    ),
                    txtfield("Invalid", "Enter The Password", Icons.lock,
                        getsign.txt_passwordIn),
                    SizedBox(
                      height: 7.h,
                    ),
                    loginbtn(),
                    SizedBox(
                      height: 5.h,
                    ),
                    Divider(
                        color: Colors.grey,
                        thickness: 0.8,
                        endIndent: 10.w,
                        indent: 10.w),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CupertinoButton(
                            onPressed: () {},
                            child: SizedBox(
                              height: 4.h,
                              child: Image.asset("assets/images/facebook.png"),
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () async {
                              bool msg = await getsign.signWithgoogle();
                              if (msg == false) {
                                Get.snackbar("Shop Stop", "Invalid Entry");
                              } else {
                                Get.offAllNamed('homeScreen');
                              }
                            },
                            child: SizedBox(
                              height: 4.h,
                              child: Image.asset("assets/images/google.png"),
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () {},
                            child: SizedBox(
                              height: 4.h,
                              child: Image.asset("assets/images/apple.png"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              softWrap: true,
              maxLines: 2,
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: true),
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 36),
                children: [
                  TextSpan(
                      text: '${"Dont't Have An Account"} ',
                      style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            TextButton(
              child: Text('${"Signup"} ',
                  style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w600)),
              onPressed: () {
                Get.offAll(signupscreen(), transition: Transition.leftToRight);
              },
            ),
          ],
        ),
      ),
    );
  }
}
