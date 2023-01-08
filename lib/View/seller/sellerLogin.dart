import 'package:fierbase/View/seller/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';

class Seller extends StatefulWidget {
  const Seller({Key? key}) : super(key: key);

  @override
  State<Seller> createState() => _SellerState();
}

class _SellerState extends State<Seller> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.only(top: 6.h, bottom: 6.h),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: 280,
                    child: Image.asset("assets/images/seller.png"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Seller Account",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Please Enter The Detail Below To Continue.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(splashColor: Colors.transparent),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter Product Price' : null,
                      autofocus: false,
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(fontSize: 18),
                        contentPadding: const EdgeInsets.only(
                            left: 25.0, bottom: 5.0, top: 5.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(6),
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
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(splashColor: Colors.transparent),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter Password' : null,
                      autofocus: false,
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(fontSize: 18),
                        contentPadding: const EdgeInsets.only(
                            left: 25.0, bottom: 5.0, top: 5.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(6),
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
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              String msg = await getsign.signIn(
                                  getsign.txt_mailIn.text,
                                  getsign.txt_passwordIn.text);
                              await Get.snackbar(
                                  duration: Duration(milliseconds: 800),
                                  "${"ShopStop"}",
                                  "${msg}");
                              if (msg == "Login success") {
                                Get.offAllNamed('homeScreen');
                                getsign.txt_mailIn.clear();
                                getsign.txt_passwordIn.clear();
                              }
                            },
                            child: Text(
                              "LOGIN",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: Colors.lightGreenAccent),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "SIGNUP",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: Colors.lightGreenAccent),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(2.5.h),
                  child: SignInButton(
                    Buttons.google,
                    text: "Sign up with Google",
                    onPressed: () async {
                      bool msg = await getsign.signWithgoogle();
                      if (msg == true) {
                        GetStorage g1 = GetStorage();
                        g1.write("auth", 'google');
                        await Get.to(homeScreen(),
                            transition: Transition.fadeIn);
                      } else {
                        await Get.snackbar("Shop Stop", "Invalid Entry");
                      }
                    },
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
