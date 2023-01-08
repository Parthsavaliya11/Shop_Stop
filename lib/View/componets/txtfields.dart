import 'package:fierbase/main.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget txtfield(String validation, String hinttext, IconData iconData,
    TextEditingController txtcontroller) {
  return Padding(
    padding: const EdgeInsets.only(right: 15, left: 15),
    child: TextFormField(
      controller: txtcontroller,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 18.0, color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: Icon(
          iconData,
          size: 25,
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: '$hinttext',
        hintStyle: TextStyle(fontSize: 15),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(11),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(11),
        ),
      ),
    ),
  );
}

Widget addtxtfiels(TextEditingController txt_cont, TextInputType txt_type,
    String hint, String validate) {
  return Padding(
    padding: EdgeInsets.only(right: 5.w, left: 5.w,  bottom: 2.h,top: 2.h),
    child: TextFormField(
      validator: (value) => value!.isEmpty ? '$validate' : null,
      controller: txt_cont,
      keyboardType: txt_type,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        hintText: '$hint',

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(11),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(11),
        ),
      ),
    ),
  );
}
