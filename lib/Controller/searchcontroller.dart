import 'package:fierbase/firestore/firestore%20controller.dart';
import 'package:fierbase/main.dart';
import 'package:get/get.dart';

class searchsystem extends GetxController {
  RxList<fstoremodel> tempsearch = <fstoremodel>[].obs;

  searchsystem._();

  static final searchhelper = searchsystem._();

  void search(String query, List<fstoremodel> s) {
    getstore.allfinal.value = s;
    tempsearch = getstore.allfinal;

    if (query.isNotEmpty) {
      List<fstoremodel> filtersearchdata = [];
      for (var search in tempsearch) {
        if (search.productname!.toLowerCase().contains(query.toLowerCase())) {
          filtersearchdata.add(search);
        }
      }
      getstore.allfinal.value = filtersearchdata;
    } else {
      getstore.allfinal.value = s;
    }
  }
}
