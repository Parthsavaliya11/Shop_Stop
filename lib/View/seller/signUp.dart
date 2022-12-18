import 'package:fierbase/View/seller/signinScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.lightGreenAccent,
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/bg.jpg",
                ),
                opacity: 0.2,
                fit: BoxFit.cover),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 200,
                        child: Image.asset("assets/images/shopstop.png"),
                      ),
                    ),
                    Text("Registerd",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        controller: getsign.txt_mailUp,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          isDense: true,
                          hintText: "Enter Registerd Email ",
                          label: Text(
                            "Email Id",
                            style: TextStyle(color: Colors.black),
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        controller: getsign.txt_passwordUp,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.password,
                            color: Colors.black,
                          ),
                          isDense: true,
                          hintText: "Enter Registerd Password ",
                          label: Text(
                            "Password",
                            style: TextStyle(color: Colors.black),
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 120,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: () async {
                                String msg = await getsign.signUp(
                                    getsign.txt_mailUp.text,
                                    getsign.txt_passwordUp.text);
                                await Get.snackbar("${"ShopStop"}", "${msg}");
                                if (msg == "Registerd success") {
                                  await Get.offAllNamed('homeScreen');
                                  getsign.txt_passwordUp.clear();
                                  getsign.txt_mailIn.clear();
                                }
                              },
                              child: Text("SignUp"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already Have A account?",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                          TextButton(
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800),
                            ),
                            onPressed: () {
                              // Get.a(signIn(),);
                              Get.offAllNamed('signin');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
