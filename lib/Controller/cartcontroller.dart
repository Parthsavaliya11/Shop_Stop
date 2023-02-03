import 'dart:developer';
import 'package:fierbase/model/cartModel.dart';
import 'package:get/get.dart';

class Cartcontroller extends GetxController {
  Cartcontroller._();

  int? doclength;
  static final cartController = Cartcontroller._();
  Cartmodel cartmodel = Cartmodel();
  RxList<Cartmodel> allfinal = <Cartmodel>[].obs;
  RxBool cartqty = false.obs;

  String Cartpriceincriment(int price, int index, int qty)  {

    log("${qty} QTYYYYY ${price} PRICE");
    int totalprice = price * qty;

    return totalprice.toString();
  }

  String CartpriceDecriment(int price, int index, int orignalprice)  {

    int totalprice = price - orignalprice;

    return totalprice.toString();
  }
}
