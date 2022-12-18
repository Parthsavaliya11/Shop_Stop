import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fierbase/Firebase/Messaging/messageing.dart';
import 'package:fierbase/View/addproductpage.dart';
import 'package:fierbase/firestore/fierStonehelper.dart';
import 'package:fierbase/firestore/firestore%20controller.dart';
import 'package:fierbase/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:cool_alert/cool_alert.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebasenoti();
    getsignin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          splashColor: Colors.lightGreen,
          onPressed: () {
            Get.to(addproduct(), transition: Transition.leftToRightWithFade);
          },
          backgroundColor: Colors.lightGreenAccent,
          label: Text(
            "Product",
            style: TextStyle(color: Colors.black),
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  getsign.logout();
                  getsign.googlelogout();
                  Get.offAllNamed('loginscreen');
                },
                child: ListTile(
                  title: Text("Logout"),
                  leading: Icon(
                    Icons.logout,
                    size: 25,
                  ),
                ),
              ),
              Obx(() => Text("${getsign.userid}")),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "Shop Stop",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.lightGreenAccent,
        ),
        body: Obx(
          () => StreamBuilder(
            stream: userwiseread(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                getstore.allfinal.clear();

                var storedata = snapshot.data!.docs;

                for (var z in storedata) {
                  Map finaldata = z.data() as Map<String, dynamic>;

                  getstore.proname.value = finaldata['productname'];
                  getstore.proprice.value = finaldata['productprice'];
                  getstore.prodisp.value = finaldata['description'];
                  fstoremodel f = fstoremodel(
                    productname: getstore.proname.value,
                    productprice: getstore.proprice.value,
                    productdes: getstore.prodisp.value,
                  );
                  getstore.allfinal.value.add(f);
                }
                print("${"${getstore.allfinal.length}"}");
                return getstore.allfinal.length == 0
                    ? Center(child: Text("Launch Your First Product....."))
                    : ListView.builder(
                        itemCount: getstore.allfinal.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              updatefirestore("pn", "feg", "fadgse",
                                  getstore.alldocs[index].id);
                            },
                            child: ListTile(
                              title: Text(
                                  "${getstore.allfinal[index].productname}"),
                            ),
                          );
                        });
              }
              return const Center(
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void getsignin() async {
  getsign.signdetail();
}
// child: Slidable(
// key: const ValueKey(0),
// startActionPane: ActionPane(
// motion: DrawerMotion(),
// children: [
// SlidableAction(
// flex: 2,
// onPressed: (contex) {
// CoolAlert.show(
// loopAnimation: true,
// backgroundColor:
// Colors.lightGreenAccent,
// animType: CoolAlertAnimType.slideInUp,
// showCancelBtn: true,
// confirmBtnColor:
// Colors.lightGreenAccent,
// cancelBtnTextStyle:
// TextStyle(color: Colors.black),
// cancelBtnText: "Back",
// confirmBtnText: "Update",
// title: "Update Product",
// confirmBtnTextStyle:
// TextStyle(color: Colors.black),
// context: context,
// type: CoolAlertType.info,
// text: "Delete Product",
// onConfirmBtnTap: () {},
// onCancelBtnTap: () {
// Get.back();
// },
// );
// },
// backgroundColor: Colors.red,
// autoClose: true,
// icon: Icons.delete_rounded,
// label: "Delete",
// ),
// ],
// ),
// child: getstore.allfinal.length == 0
// ? Text("data")
// : ListTile(
// title: Text(
// "${getstore.allfinal[index].productname}"),
// ),
// ),
