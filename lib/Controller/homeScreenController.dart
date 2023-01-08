import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreenController extends GetxController {
  HomeScreenController._();

  static final homeController = HomeScreenController._();
  RxDouble opicity = 1.0.obs;
  RxInt tabindex = 0.obs;
  GetStorage authseprate = GetStorage();
  String? authmethod;
  PageController tabcontroller = PageController();
  List ctegorylist = [

    "assets/images/fashion.png",
    "assets/images/electric.png",
    "assets/images/lifestyle.png",
    "assets/images/kitchen.png"
  ];
  List ctegorylistnames = ["Fashion", "Electric", "Lifestyle", "Kitchen"];

  void abc() {}
}
