import 'package:fierbase/Controller/addproductcontroller.dart';
import 'package:fierbase/Controller/editupdatecontroller.dart';
import 'package:fierbase/Controller/productdetailcontroller.dart';
import 'package:fierbase/Storage/storage.dart';
import 'package:fierbase/View/seller/edittoupdate.dart';
import 'package:fierbase/View/seller/searchpage.dart';
import 'package:fierbase/model/updatemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

class editproduct extends StatefulWidget {
  const editproduct({Key? key}) : super(key: key);

  @override
  State<editproduct> createState() => _editproductState();
}

class _editproductState extends State<editproduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h, bottom: 4.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Product Detail",
                      style: GoogleFonts.poppins(
                          fontSize: 18.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 50.h,
                          width: double.infinity,
                          child: Image.network(
                              fit: BoxFit.cover,
                              "${ProductDetailCont.detailcontroller.productdetailmodel.imgurl}"),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 4.w, right: 4.w, top: 4.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 55.w,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                "${ProductDetailCont.detailcontroller.productdetailmodel.productname}",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "\$ ${ProductDetailCont.detailcontroller.productdetailmodel.productprice}",
                              style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueAccent),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h),
                        child: ReadMoreText(
                            style: GoogleFonts.poppins(fontSize: 12.sp),
                            trimLines: 3,
                            lessStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600),
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show More',
                            trimExpandedText: 'Show Less',
                            moreStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600),
                            "${ProductDetailCont.detailcontroller.productdetailmodel.discription} "),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(2.5.h),
          child: SizedBox(
            height: 50,
            width: 340,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () {
                Editupdatecontroller.editupdate.updatemodel = Updatemodel(
                    productprice: ProductDetailCont
                        .detailcontroller.productdetailmodel.productprice,
                    category: ProductDetailCont
                        .detailcontroller.productdetailmodel.category,
                    imgurl: ProductDetailCont
                        .detailcontroller.productdetailmodel.imgurl,
                    productname: ProductDetailCont
                        .detailcontroller.productdetailmodel.productname,
                    discription: ProductDetailCont
                        .detailcontroller.productdetailmodel.discription,
                    docid: ProductDetailCont
                        .detailcontroller.productdetailmodel.docid);
                Get.to(editupdate(), transition: Transition.cupertino);
              },
              child: Text(
                "Update Product",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
