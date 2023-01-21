import 'package:fierbase/View/seller/testLogin.dart';
import 'package:fierbase/View/seller/testsignup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../Controller/userprofile.dart';
import '../../main.dart';

Widget bigbtn(String buttonname, StatefulWidget screen, String storagekey) {
  return SizedBox(
    width: 90.w,
    height: 7.h,
    child: CupertinoButton(
        color: Colors.blueAccent,
        child: Text(
          "$buttonname",
          style: GoogleFonts.poppins(),
        ),
        onPressed: () {
          GetStorage getStorage = GetStorage();
          getStorage.write("U", "$storagekey");
          Get.to(screen, transition: Transition.rightToLeft);
        }),
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
            GetStorage g1 = GetStorage();

            g1.write("auth",'custom');
            String key = g1.read("U");
            Future.delayed(
              Duration(seconds: 2),
              () {
                key == "user"
                    ? Get.offAllNamed('userhome')
                    : Get.offAllNamed('homeScreen');
                getsign.txt_mailIn.clear();
                getsign.txt_passwordIn.clear();
              },
            );
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
          String msg = await getsign.signUp(
              getsign.txt_mailUp.text, getsign.txt_passwordUp.text);

          if (msg == "Registerd success") {
            GetStorage g1 = GetStorage();

            g1.write("auth",'custom');

            await Get.offNamed('uprofile');
            getsign.txt_mailIn.clear();
            getsign.txt_passwordIn.clear();
          }
        }),
  );
}
