import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fierbase/Controller/FavController.dart';
import 'package:fierbase/model/favoritemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../firestore/fierStonehelper.dart';

class favScreen extends StatefulWidget {
  const favScreen({Key? key}) : super(key: key);

  @override
  State<favScreen> createState() => _favScreenState();
}

class _favScreenState extends State<favScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: readfav(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("${snapshot.error}");
            } else if (snapshot.hasData) {
              Favcontroller.Favcont.allfinal.clear();

              var snapdata = snapshot.data;
              for (var z in snapdata!.docs) {
                String productname = z['productname'];
                String productprice = z['productprice'];
                String productdisc = z['description'];
                String imgurl = z['imageurl'];
                String category = z['category'];
                String docid = z.id;
                Favmodel cartmodel = Favmodel(
                    productname: productname,
                    productprice: productprice,
                    docid: docid,
                    category: category,
                    discription: productdisc,
                    imgurl: imgurl);
                Favcontroller.Favcont.allfinal.add(cartmodel);
              }
              return Stack(
                children: [
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: Favcontroller.Favcont.allfinal.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(top: 2.5.h, left: 1.h, right: 1.h),
                        child: Container(
                          height: 18.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 0.5, color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                      "${Favcontroller.Favcont.allfinal[index].imgurl}"),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      "${Favcontroller.Favcont.allfinal[index].productname}",
                                      style:
                                          GoogleFonts.poppins(fontSize: 12.sp),
                                    ),
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    "${Favcontroller.Favcont.allfinal[index].category}",
                                    style: GoogleFonts.poppins(fontSize: 12.sp),
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    "\$ ${Favcontroller.Favcont.allfinal[index].productprice}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.only(right: 5),
                                child: TextButton.icon(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection("Fav")
                                          .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                          .collection("Fav")
                                          .doc(Favcontroller.Favcont
                                          .allfinal[index].docid)
                                          .delete();
                                      Fluttertoast.showToast(
                                          msg: "Item Removed");
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    label: Text("Remove")),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Fluttertoast.cancel();
  }
}
