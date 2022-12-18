import 'package:fierbase/Controller/local_notification.dart';
import 'package:fierbase/Controller/signController.dart';
import 'package:fierbase/View/seller/addproductpage.dart';
import 'package:fierbase/View/seller/homeScreen.dart';
import 'package:fierbase/View/introScreen.dart';
import 'package:fierbase/View/seller/sellerLogin.dart';
import 'package:fierbase/View/seller/signUp.dart';
import 'package:fierbase/View/seller/signinScreen.dart';
import 'package:fierbase/View/spelshScreen.dart';
import 'package:fierbase/View/seller/testLogin.dart';
import 'package:fierbase/View/seller/testsignup.dart';
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
          initialRoute: 'addpro',
          routes: {
            '/': (context) => spelshScreen(),
            'homeScreen': (context) => homeScreen(),
            'signin': (context) => signIn(),
            'signup': (context) => Signup(),
            'addpro': (context) => addproduct(),
            'testlogin': (context) => loginscreen(),
            'testsignup': (context) => signupscreen(),
            'intro' : (context) => interoScreen(),
            'seller' : (context) => Seller(),
          },
        ),
      ),
    );
  }
}
