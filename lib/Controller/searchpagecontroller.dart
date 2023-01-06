import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/searchmodaldata.dart';

class SearchPageController extends GetxController {
  SearchPageController._();

  static final searchcontroller = SearchPageController._();
  TextEditingController txtsearch = TextEditingController();
  RxString searchkeywords = "".obs;
  RxString category = "".obs;
  RxList<Searchmodeldata> searchdata = <Searchmodeldata>[].obs;


  searchsystem(String value)
  {
    List<String> charsearchlist = [];
    String temp = "";
    for(int i=0; i<value.length ;i++)
      {
        temp = temp + value[i];
        charsearchlist.add(temp);
      }
    return charsearchlist;
  }
  void keywordsearch(String value)
  {
    searchkeywords.value = value;
  }
}
