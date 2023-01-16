import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fierbase/View/seller/updateprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../Controller/editprofilecontroller.dart';
import '../../Controller/homeScreenController.dart';
import '../../Controller/userprofile.dart';
import '../../firestore/fierStonehelper.dart';
import '../../main.dart';
import '../../model/editprofilemodel.dart';

class Adminaccountpage extends StatefulWidget {
  const Adminaccountpage({Key? key}) : super(key: key);

  @override
  State<Adminaccountpage> createState() => _AdminaccountpageState();
}

class _AdminaccountpageState extends State<Adminaccountpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              HomeScreenController.homeController.authmethod == "custom"
                  ? FutureBuilder(
                      future: readuserprofile(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else if (snapshot.hasData) {
                          Profilecontroller.cont.alluserdetail.clear();
                          var userdata = snapshot.data!.docs;

                          for (QueryDocumentSnapshot z in userdata) {
                            var datadocs = z.data() as Map<String, dynamic>;

                            UserprofileData u = UserprofileData(
                                docid: z.id,
                                username: datadocs['username'],
                                mobile: datadocs['mobile'],
                                userprofilelink: datadocs['userprofilelink']);
                            Profilecontroller.cont.alluserdetail.value.add(u);
                            log("${Profilecontroller.cont.alluserdetail.value}");
                          }
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  height: 20.h,
                                  width: 20.h,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "${Profilecontroller.cont.alluserdetail.value[0].userprofilelink}"),
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  "${Profilecontroller.cont.alluserdetail.value[0].username}",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  "${FirebaseAuth.instance.currentUser!.email}",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 15.sp),
                                ),
                              ],
                            ),
                          );
                        }
                        return CircularProgressIndicator();
                      })
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            height: 20.h,
                            width: 20.h,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "${FirebaseAuth.instance.currentUser!.photoURL}"),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "${FirebaseAuth.instance.currentUser!.displayName}",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            "${FirebaseAuth.instance.currentUser!.email}",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Manage Profile",
                style: GoogleFonts.poppins(
                    fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 3.h,
              ),
              GestureDetector(
                onTap: () {
                  Editprofile.editprofile.editprofilemodel = Editprofilemodel(
                      docid: Profilecontroller.cont.alluserdetail[0].docid,
                      refurl: Profilecontroller
                          .cont.alluserdetail.value[0].userprofilelink,
                      uname: Profilecontroller
                          .cont.alluserdetail.value[0].username,
                      umobile:
                          Profilecontroller.cont.alluserdetail.value[0].mobile);
                  Editprofile.editprofile.refurl = Profilecontroller
                      .cont.alluserdetail.value[0].userprofilelink;
                  HomeScreenController.homeController.authmethod == "custom"
                      ? Get.to(Updateprofile())
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Google Login Not Support"),
                          ),
                        );
                },
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  leading: Icon(
                    Icons.edit_note_rounded,
                    size: 3.5.h,
                  ),
                  title: Text(
                    "Update Profile",
                    style: GoogleFonts.poppins(fontSize: 15.sp),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  HomeScreenController.homeController.authseprate
                      .remove("auth");

                  getsign.logout();
                  getsign.googlelogout();
                  Get.offAllNamed('login');
                },
                child: ListTile(
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                  leading: Icon(
                    Icons.logout_rounded,
                    size: 3.2.h,
                  ),
                  title: Text(
                    "Logout",
                    style: GoogleFonts.poppins(fontSize: 15.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
