import 'package:fierbase/View/componets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Userorseller extends StatefulWidget {
  const Userorseller({Key? key}) : super(key: key);

  @override
  State<Userorseller> createState() => _UserorsellerState();
}

class _UserorsellerState extends State<Userorseller> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 4.h, bottom: 6.h),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 30.h,
                  child: Image.asset("assets/images/shopstopblue.png"),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                "Choose One\nFor Next",
                style: GoogleFonts.poppins(
                    fontSize: 30.sp, height: 1.2, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.h,
              ),
              bigbtn(buttonname: "User"),
              bigbtn(buttonname: "Sel ler"),
            ],
          ),
        ),
      ),
    );
  }
}
