import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
       appBar : AppBar(
          toolbarHeight: 10.h,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: SizedBox(
            height: 13.h,
            width: 13.h,
            child: Image.asset("assets/images/shopstopblue.png"),
          ),
          backgroundColor: Colors.white,
          elevation: 0,

        ),
      ),
    );
  }
}
