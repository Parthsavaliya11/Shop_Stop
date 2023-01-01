import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Controller/introcontroller.dart';

class Intro1 extends StatefulWidget {
  final String img;

  const Intro1({Key? key, required this.img}) : super(key: key);

  @override
  State<Intro1> createState() => _Intro1State();
}

class _Intro1State extends State<Intro1> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImage(AssetImage("assets/images/f1.jpg"), context);
    precacheImage(AssetImage("assets/images/f2.jpg"), context);
    precacheImage(AssetImage("assets/images/f3.jpg"), context);
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: 65.h,
              width: 100.w,
              child: Image.asset(fit: BoxFit.cover, "${widget.img}"),
            ),

          ],
        ),
      ),
    );
  }
}
// Stack(
// children: [
// Container(
// height: 65.h,
// width: 100.w,
// child: Image.asset(fit: BoxFit.cover, "assets/images/f1.jpg"),
// ),
// Align(
// alignment: Alignment.bottomCenter,
// child: Container(
// height: 35.h,
// width: 100.w,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(20),
// topRight: Radius.circular(20),
// ),
// ),
// child: Padding(
// padding: EdgeInsets.only(top: 7.h),
// child: Column(
// children: [
// Wrap(
// alignment: WrapAlignment.center,
// children: [
// RichText(
// strutStyle: StrutStyle(),
// softWrap: true,
// maxLines: 2,
// textHeightBehavior: TextHeightBehavior(
// applyHeightToFirstAscent: true),
// textAlign: TextAlign.center,
// text: TextSpan(
// style:
// TextStyle(color: Colors.black, fontSize: 36),
// children: [
// TextSpan(
// text: '${"All Fashion"} ',
// style:
// GoogleFonts.poppins(fontSize: 35.sp)),
// TextSpan(
// text: '${"Stop "} ',
// style:
// GoogleFonts.poppins(fontSize: 35.sp)),
// TextSpan(
// text: '${"SHOPSTOP\n"} ',
// style: GoogleFonts.poppins(
// fontSize: 40.sp,
// color: Colors.blueAccent,
// fontWeight: FontWeight.w600)),
// TextSpan(
// text: '${"We Fill Your All Need"} ',
// style: GoogleFonts.poppins(
// letterSpacing: 2.sp,
// fontSize: 25.sp,
// color: Colors.black,
// ),
// ),
// ],
// ),
// textScaleFactor: 0.5,
// ),
// SizedBox(
// height: 15.h,
// ),
// SmoothPageIndicator(
// effect: WormEffect(
// dotHeight: 2.h,
// dotWidth: 2.h,
// activeDotColor: Colors.blueAccent),
// controller: IntroController.introcontrol.indicator,
// count: 3,
// ),
// ],
// ),
// ],
// ),
// ),
// ),
// ),
// ],
// ),
