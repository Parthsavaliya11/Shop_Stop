import 'package:flutter/material.dart';

Widget txtfield(String validation, String hinttext, IconData iconData,TextEditingController txtcontroller) {
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
