import 'package:fierbase/Controller/local_notification.dart';
import 'package:fierbase/Controller/signController.dart';
import 'package:fierbase/View/addproductpage.dart';
import 'package:fierbase/View/homeScreen.dart';
import 'package:fierbase/View/signUp.dart';
import 'package:fierbase/View/signinScreen.dart';
import 'package:fierbase/View/spelshScreen.dart';
import 'package:fierbase/View/testLogin.dart';
import 'package:fierbase/View/testsignup.dart';
import 'package:fierbase/firestore/firestore%20controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

signController getsign = Get.put(signController());
firestoreget getstore = Get.put(firestoreget());
localnotificatio getlocal = Get.put(localnotificatio());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(
      Sizer(
        builder: (context, orientation, devicetype) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => spelshScreen(),
            'homeScreen': (context) => homeScreen(),
            'signin': (context) => signIn(),
            'signup': (context) => Signup(),
            'addpro': (context) => addproduct(),
            'testlogin': (context) => loginscreen(),
            'testsignup': (context) => signupscreen(),
          },
        ),
      ),
    );
  }
}
