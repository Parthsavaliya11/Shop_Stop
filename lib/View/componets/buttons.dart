import 'package:fierbase/View/seller/testLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';

Widget bigbtn({String? buttonname}) {
  return SizedBox(
    width: 90.w,
    height: 7.h,
    child: CupertinoButton(
        color: Colors.blueAccent,
        child: Text(
          "$buttonname",
          style: GoogleFonts.poppins(),
        ),
        onPressed: () {}),
  );
}

Widget loginbtn() {
  return SizedBox(
    width: 90.w,
    height: 7.h,
    child: CupertinoButton(
        color: Colors.blueAccent,
        child: Text(
          "Login",
          style: GoogleFonts.poppins(),
        ),
        onPressed: () async {
          String msg = await getsign.signIn(
              getsign.txt_mailIn.text, getsign.txt_passwordIn.text);
          await Get.snackbar("${"ShopStop"}", "${msg}");
          if (msg == "Login success") {
            Get.offAllNamed('homeScreen');
            getsign.txt_mailIn.clear();
            getsign.txt_passwordIn.clear();
          }
        }),
  );
}

Widget signupbtn() {
  return SizedBox(
    width: 90.w,
    height: 7.h,
    child: CupertinoButton(
        color: Colors.blueAccent,
        child: Text(
          "Sign Up",
          style: GoogleFonts.poppins(),
        ),
        onPressed: () async {
          String msg = await getsign.signUp(getsign.txt_mailUp.text, getsign.txt_passwordUp.text);
          await Get.snackbar("${"ShopStop"}", "${msg}");
          if (msg == "Registerd success") {
            Get.offAll(loginscreen(),transition: Transition.topLevel);
            getsign.txt_mailIn.clear();
            getsign.txt_passwordIn.clear();
          }
        }),
  );
}
