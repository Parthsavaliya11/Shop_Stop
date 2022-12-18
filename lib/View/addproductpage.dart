import 'package:fierbase/firestore/fierStonehelper.dart';
import 'package:fierbase/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class addproduct extends StatefulWidget {
  const addproduct({Key? key}) : super(key: key);

  @override
  State<addproduct> createState() => _addproductState();
}

class _addproductState extends State<addproduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                ))
          ],
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Product Detail",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: MediaQuery
              .of(context)
              .viewInsets
              .bottom == 0.0
              ? ScrollPhysics()
              : BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Form(
            key: getstore.k,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Live Your Product!",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Live product Live Income",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.transparent),
                          child: TextFormField(
                            validator: (value) =>
                            value!.isEmpty ? 'Enter Product Name' : null,
                            controller: getstore.pronamee,
                            maxLength: 30,
                            autofocus: false,
                            style:
                            TextStyle(fontSize: 20.0, color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Product Name',
                              contentPadding: const EdgeInsets.only(
                                  left: 25.0, bottom: 5.0, top: 5.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.transparent),
                          child: TextFormField(
                            validator: (value) =>
                            value!.isEmpty ? 'Enter Product Price' : null,
                            controller: getstore.propricee,
                            maxLength: 30,
                            autofocus: false,
                            style:
                            TextStyle(fontSize: 20.0, color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Product Price',
                              contentPadding: const EdgeInsets.only(
                                  left: 25.0, bottom: 5.0, top: 5.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(splashColor: Colors.transparent),
                          child: TextFormField(
                            validator: (value) =>
                            value!.isEmpty
                                ? 'Enter Product Description'
                                : null,
                            controller: getstore.prodescription,
                            maxLength: 100,
                            autofocus: false,
                            style:
                            TextStyle(fontSize: 20.0, color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Description',
                              contentPadding: const EdgeInsets.only(
                                  left: 25.0, bottom: 5.0, top: 5.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 340,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightGreenAccent),
                          onPressed: () {
                            if (getstore.k.currentState!.validate()) {
                              print("-----------------------------------");
                              userwiefirestore(
                                  getstore.pronamee.text,
                                  getstore.propricee.text,
                                  getstore.prodescription.text,
                                  "${getsign.userid.obs}");
                              getlocal.showbuttonmethod();
                              Get.snackbar("${"ShopStop"}", "Your Product Lauch Successfully");
                              Get.offAllNamed('homeScreen');
                              getstore.pronamee.clear();
                              getstore.propricee.clear();
                              getstore.prodescription.clear();
                              print('Form is valid');
                            } else {
                              print('Form is invalid');
                            }
                          },
                          child: Text(
                            "Add Customer",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
