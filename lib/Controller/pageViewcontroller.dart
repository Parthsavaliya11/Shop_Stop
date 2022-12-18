import 'package:fierbase/View/seller/sellerLogin.dart';
import 'package:fierbase/View/seller/testLogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroCont extends GetxController {
  IntroCont._();

  static final pageviewcontroller = IntroCont._();
  List<PageViewModel> pagelist = [
    PageViewModel(
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
      ),
      title: "Welcome",
      body: "Join With StopShop Fashion World",
      image: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SizedBox(
          height: 280,
          child: Image.asset("assets/images/i4.png"),
        ),
      ),
    ),
    PageViewModel(
      title: "ShopStop Design For You and Your Dreams",
      body: "Shopstop Provide A All Of Fashion Item!",
      image: SizedBox(
        height: 280,
        child: Image.asset("assets/images/i1.png"),
      ),
    ),
    PageViewModel(
      title: "Your Business Go Online For Seller",
      body: "Welcome to the app! This app is helpful for you wishes!",
      image: SizedBox(
        height: 260,
        child: Image.asset("assets/images/i3.png"),
      ),
    ),
    PageViewModel(
      decoration: PageDecoration(
        titleTextStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
      ),
      footer: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(Seller(), transition: Transition.cupertino);
                },
                child: Text(
                  "I Am Seller",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.lightGreenAccent),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(loginscreen(), transition: Transition.cupertino);
                },
                child: Text(
                  "I Am Customer",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.lightGreenAccent),
              ),
            ),
          ),
        ],
      ),
      title: "Who Are you!",
      body: "Please Select Field And Start journey",
      image: SizedBox(
        height: 280,
        child: Image.asset("assets/images/i2.png"),
      ),
    ),
  ];
}
