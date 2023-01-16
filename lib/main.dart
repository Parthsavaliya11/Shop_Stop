import 'package:fierbase/Controller/editupdatecontroller.dart';
import 'package:fierbase/Controller/local_notification.dart';
import 'package:fierbase/Controller/signController.dart';
import 'package:fierbase/View/pagehomescreen.dart';
import 'package:fierbase/View/seller/addproductpage.dart';
import 'package:fierbase/View/seller/adminaccountpage.dart';
import 'package:fierbase/View/seller/edittoupdate.dart';
import 'package:fierbase/View/seller/homeScreen.dart';
import 'package:fierbase/View/introduction/introScreen.dart';
import 'package:fierbase/View/seller/sellerLogin.dart';
import 'package:fierbase/View/seller/userprofilesetup.dart';
import 'package:fierbase/View/spelshScreen.dart';
import 'package:fierbase/View/seller/testLogin.dart';
import 'package:fierbase/View/seller/testsignup.dart';
import 'package:fierbase/firestore/firestore%20controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'View/seller/editproductpage.dart';
import 'View/seller/searchpage.dart';

signController getsign = Get.put(signController());
firestoreget getstore = Get.put(firestoreget());
localnotificatio getlocal = Get.put(localnotificatio());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  {
    runApp(
      Sizer(
        builder: (context, orientation, devicetype) => GetMaterialApp(
          debugShowCheckedModeBanner: false,

          routes: {
            '/': (context) => spelshScreen(),
            'homeScreen': (context) => homeScreen(),
            'addpro': (context) => addproduct(),
            'login': (context) => loginscreen(),
            'signup': (context) => signupscreen(),
            'intro': (context) => interoScreen(),
            'seller': (context) => Seller(),
            'uprofile' : (context) => userprofile(),
            'search' : (context) => SearchPage(),
            'pagehomescreen' : (context) => pagehome(),
            'edit' : (context) => editproduct(),
            'editupdatepage' :(context) => editupdate(),
            'adminaccountpage' :(context) => Adminaccountpage(),
          },
        ),
      ),
    );
  }
}
