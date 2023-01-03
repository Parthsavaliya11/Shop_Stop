import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class spleashController extends GetxController
{
  spleashController._();
  static final spleash = spleashController._();
  String? introcount;
  final introcontroller = GetStorage();

   void writeStorage()
   {
      introcontroller.write("intro", true);
      introcontroller.listen(() => print("Key Was Added"));
   }

}