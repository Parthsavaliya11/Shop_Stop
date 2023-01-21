import 'package:fierbase/model/Uhomemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Uhomecontroller extends GetxController {
  Uhomecontroller._();

  static final uhomecontroller = Uhomecontroller._();
  RxList<Uhomemodel> allfinal = <Uhomemodel>[].obs;
  RxInt tabindex = 0.obs;
  PageController Uhometabcont = PageController();
  List ctegorylist = [
    "assets/images/fashion.png",
    "assets/images/electric.png",
    "assets/images/lifestyle.png",
    "assets/images/kitchen.png"
  ];

  List imgsliderimg = [
    "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/sports-design-template-799dd14806c37cd6a9a489949909f2c9_screen.jpg?ts=1665920166",
    "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/fashion-sale-advert-shopping-discount-promo-model-wall-promo-design-template-afa19648eee2ee51865f1e306827ce63_screen.jpg?ts=1561512961",
    "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/big-sale-design-template-627bc3d8ec48543bb548815a92b34876_screen.jpg?ts=1595360349",
    "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/black-friday-sale-poster-template-design-74ac4310cfa1327eda3a683be56d4987_screen.jpg?ts=1661356746",
    "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/fashion-apparel-cover-design-template-f011fad24eaf1165a4b2533298c47b98_screen.jpg?ts=1632879960"
  ];
  List ctegorylistnames = ["Fashion", "Electric", "LifeStyle", "Kitchen"];
  RxString category = "".obs;
}
