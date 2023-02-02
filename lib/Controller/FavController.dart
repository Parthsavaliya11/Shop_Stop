import 'package:fierbase/model/favoritemodel.dart';
import 'package:get/get.dart';

class Favcontroller extends GetxController
{
  Favcontroller._();
  static final Favcont =   Favcontroller._();
  int? doclength;
  Favmodel cartmodel = Favmodel();
  RxList<Favmodel> allfinal = <Favmodel>[].obs;
  bool e = true;


}