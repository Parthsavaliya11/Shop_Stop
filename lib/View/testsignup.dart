import 'package:fierbase/View/homeScreen.dart';
import 'package:fierbase/View/signinScreen.dart';
import 'package:fierbase/View/testLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

import '../main.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({Key? key}) : super(key: key);

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics:
          BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              SizedBox(
                  height: 100,
                  child: Image.asset("assets/images/shopstop.png")),
              Center(
                child: SizedBox(
                  height: 280,
                  child: Image.asset("assets/images/signup.png"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Register Now",
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
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async{

                    },
                    child: Text(
                      "REGISTER",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: Colors.lightGreenAccent),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  ),
                  TextButton(
                    onPressed: ()  {
                      Get.offAll(loginscreen(),
                          transition: Transition.cupertino);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
