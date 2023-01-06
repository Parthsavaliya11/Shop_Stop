import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../Controller/userprofile.dart';
import '../../firestore/fierStonehelper.dart';
import '../../main.dart';
import '../seller/addproductpage.dart';

Widget dwr()
{
  return Drawer(
    child: Column(
      children: [
        Profilecontroller.cont.alluserdetail.length == 0
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Container(
                        height: 6.h,
                        width: 6.h,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${FirebaseAuth.instance.currentUser!.photoURL}"),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${FirebaseAuth.instance.currentUser!.displayName}",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            "${FirebaseAuth.instance.currentUser!.email}",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 8.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Manage Profile",
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(addproduct());
                },
                child: ListTile(
                  leading: Icon(
                    Icons.edit_note_rounded,
                    size: 3.5.h,
                  ),
                  title: Text(
                    "Update Profile",
                    style: GoogleFonts.poppins(fontSize: 13.sp),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  getsign.logout();
                  getsign.googlelogout();
                  Get.offAllNamed('login');
                },
                child: ListTile(
                  leading: Icon(
                    Icons.logout_rounded,
                    size: 3.2.h,
                  ),
                  title: Text(
                    "Logout",
                    style: GoogleFonts.poppins(fontSize: 13.sp),
                  ),
                ),
              ),
            ],
          ),
        )
            : StreamBuilder(
            stream: readuserprofile(),
            builder:
                (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                var userdata = snapshot.data!.docs;

                Profilecontroller.cont.alluserdetail.clear();

                for (QueryDocumentSnapshot z in userdata) {
                  var datadocs = z.data() as Map<String, dynamic>;

                  UserprofileData u = UserprofileData(
                      username: datadocs['username'],
                      mobile: datadocs['mobile'],
                      userprofilelink: datadocs['userprofilelink']);
                  Profilecontroller.cont.alluserdetail.value.add(u);
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.blueAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Container(
                                height: 6.h,
                                width: 6.h,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${Profilecontroller.cont.alluserdetail[0].userprofilelink}"),
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${Profilecontroller.cont.alluserdetail[0].username}",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "${FirebaseAuth.instance.currentUser!.email}",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 11.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Manage Profile",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(addproduct());
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.edit_note_rounded,
                            size: 3.5.h,
                          ),
                          title: Text(
                            "Update Profile",
                            style:
                            GoogleFonts.poppins(fontSize: 13.sp),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          getsign.logout();
                          getsign.googlelogout();
                          Get.offAllNamed('login');
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.logout_rounded,
                            size: 3.2.h,
                          ),
                          title: Text(
                            "Logout",
                            style:
                            GoogleFonts.poppins(fontSize: 13.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return CircularProgressIndicator();
            }),
        // InkWell(
        //   onTap: () {
        //     getsign.logout();
        //     getsign.googlelogout();
        //     Get.offAllNamed('login');
        //   },
        //   child: ListTile(
        //     title: Text("Logout"),
        //     leading: Icon(
        //       Icons.logout,
        //       size: 25,
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}