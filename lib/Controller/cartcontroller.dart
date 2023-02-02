import 'package:fierbase/model/cartModel.dart';
import 'package:get/get.dart';

class Cartcontroller extends GetxController {
  Cartcontroller._();

  int? doclength;
  static final cartController = Cartcontroller._();
  Cartmodel cartmodel = Cartmodel();
  RxList<Cartmodel> allfinal = <Cartmodel>[].obs;
}
