import 'package:fierbase/View/introduction/introscreen1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  IntroController._();

  static final introcontrol = IntroController._();

  PageController indicator = PageController();
  RxInt pagecount = 0.obs;
  List<Widget> introscreen = <Widget>[
    Center(
        child: Intro1(
      img: "assets/images/f1.jpg",
    )),
    Center(
        child: Intro1(
      img: "assets/images/f2.jpg",
    )),
    Center(
        child: Intro1(
      img: "assets/images/f3.jpg",
    )),
  ];

  void pagechange(int index) {
    pagecount.value = index;

  }
}
