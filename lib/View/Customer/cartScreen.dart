import 'dart:developer';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fierbase/Controller/cartcontroller.dart';
import 'package:fierbase/firestore/fierStonehelper.dart';
import 'package:fierbase/model/cartModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int total = 0;
  RxBool isvisible = true.obs;
  ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: usercart(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("${snapshot.error}");
            } else if (snapshot.hasData) {
              Cartcontroller.cartController.allfinal.clear();
              total = 0;
              var snapdata = snapshot.data;
              for (var z in snapdata!.docs) {
                total += int.parse(z['productprice']);
                String productname = z['productname'];
                String productprice = z['productprice'];
                String productdisc = z['description'];
                String imgurl = z['imageurl'];
                String category = z['category'];
                String orignalprice = z["orignalprice"];
                int qty = z['qty'];
                String docid = z.id;
                Cartmodel cartmodel = Cartmodel(
                    productname: productname,
                    productprice: productprice,
                    docid: docid,
                    category: category,
                    discription: productdisc,
                    imgurl: imgurl,
                    qty: qty.toString(),
                    orignalprice: orignalprice);
                log("TOTAL ${total}");
                Cartcontroller.cartController.allfinal.add(cartmodel);
              }
              return Stack(
                children: [
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: Cartcontroller.cartController.allfinal.length,
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
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                      "${Cartcontroller.cartController.allfinal[index].imgurl}"),
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
                                      "${Cartcontroller.cartController.allfinal[index].productname}",
                                      style:
                                          GoogleFonts.poppins(fontSize: 12.sp),
                                    ),
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    "${Cartcontroller.cartController.allfinal[index].category}",
                                    style: GoogleFonts.poppins(fontSize: 12.sp),
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    "\$ ${Cartcontroller.cartController.allfinal[index].productprice}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 15, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      splashRadius: 20,
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection("Cart")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .collection("usercart")
                                            .doc(Cartcontroller.cartController
                                                .allfinal[index].docid)
                                            .delete();
                                        Fluttertoast.showToast(
                                            msg: "Item Removed");
                                      },
                                      icon: Icon(
                                        size: 30,
                                        Icons.delete_outline,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (int.parse(Cartcontroller
                                                    .cartController
                                                    .allfinal[index]
                                                    .qty!) <=
                                                1) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Minimum 1 Item In Cart...");
                                            } else {
                                              FirebaseFirestore.instance
                                                  .collection("Cart")
                                                  .doc(
                                                      "${FirebaseAuth.instance.currentUser!.uid}")
                                                  .collection("usercart")
                                                  .doc(
                                                      "${Cartcontroller.cartController.allfinal[index].docid}")
                                                  .update({
                                                "qty": FieldValue.increment(-1),
                                                "productprice": Cartcontroller
                                                    .cartController
                                                    .CartpriceDecriment(
                                                        int.parse(Cartcontroller
                                                            .cartController
                                                            .allfinal[index]
                                                            .productprice!),
                                                        index,
                                                        int.parse(Cartcontroller
                                                            .cartController
                                                            .allfinal[index]
                                                            .orignalprice!))
                                              });
                                            }
                                          },
                                          child: SizedBox(
                                            height: 25,
                                            child: CircleAvatar(
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${Cartcontroller.cartController.allfinal[index].qty.toString()}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 13.sp),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            FirebaseFirestore.instance
                                                .collection("Cart")
                                                .doc(
                                                    "${FirebaseAuth.instance.currentUser!.uid}")
                                                .collection("usercart")
                                                .doc(
                                                    "${Cartcontroller.cartController.allfinal[index].docid}")
                                                .update({
                                              "qty": FieldValue.increment(1),
                                            });
                                            FirebaseFirestore.instance
                                                .collection("Cart")
                                                .doc(
                                                    "${FirebaseAuth.instance.currentUser!.uid}")
                                                .collection("usercart")
                                                .doc(
                                                    "${Cartcontroller.cartController.allfinal[index].docid}")
                                                .update({
                                              "productprice": Cartcontroller
                                                  .cartController
                                                  .Cartpriceincriment(
                                                int.parse(Cartcontroller
                                                    .cartController
                                                    .allfinal[index]
                                                    .orignalprice!),
                                                index,
                                                int.parse(Cartcontroller
                                                        .cartController
                                                        .allfinal[index]
                                                        .qty!) +
                                                    1,
                                              )
                                            });
                                          },
                                          child: SizedBox(
                                            height: 25,
                                            child: CircleAvatar(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: BlurryContainer(
                        blur: 10,
                        width: double.infinity,
                        height: 17.h,
                        elevation: 0,
                        color: Colors.white.withOpacity(0.5),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Total",
                                style: GoogleFonts.poppins(fontSize: 17.sp),
                              ),
                              trailing: Text(
                                "\$ $total",
                                style: GoogleFonts.poppins(fontSize: 17.sp),
                              ),
                            ),
                            SizedBox(
                              height: 7.h,
                              width: 90.w,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                    backgroundColor:
                                        Colors.blueAccent.withOpacity(0.8)),
                                onPressed: () {},
                                child: Text(
                                  "CHECKOUT",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
