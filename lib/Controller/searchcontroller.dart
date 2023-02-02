import 'package:fierbase/firestore/firestore%20controller.dart';
import 'package:get/get.dart';

class searchsystem extends GetxController {
  RxList<fstoremodel> tempsearch = <fstoremodel>[].obs;

  searchsystem._();

  static final searchhelper = searchsystem._();

  void search(String query, List<fstoremodel> s) {

    firestoreget.Firestoreget.allfinal.value = s;
    tempsearch =  firestoreget.Firestoreget.allfinal;

    if (query.isNotEmpty) {
      List<fstoremodel> filtersearchdata = [];
      for (var search in tempsearch) {
        if (search.productname!.toLowerCase().contains(query.toLowerCase())) {
          filtersearchdata.add(search);
        }
      }
      firestoreget.Firestoreget.allfinal.value = filtersearchdata;
    } else {
      firestoreget.Firestoreget.allfinal.value = s;
    }
  }
}
