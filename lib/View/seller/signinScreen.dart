import 'package:fierbase/View/seller/signUp.dart';
import 'package:fierbase/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../Controller/signController.dart';

class signIn extends StatefulWidget {
  const signIn({Key? key}) : super(key: key);

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
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
              physics: MediaQuery.of(context).viewInsets.bottom == 0.0
                  ? ScrollPhysics()
                  : BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 200,
                      child: Image.asset("assets/images/shopstop.png"),
                    ),
                  ),
                  Text(
                    "Sign-In ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: getsign.txt_mailIn,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password, color: Colors.black),
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
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      controller: getsign.txt_passwordIn,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail, color: Colors.black),
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
                            onPressed: ()  {

                            },
                            child: Text("Log in"),
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
                          "Dont Have An Account?",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        TextButton(
                          child: Text(
                            "Signup",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w800),
                          ),
                          onPressed: () {
                            Get.to(Signup());
                          },
                        ),
                      ],
                    ),
                  ),
                  SignInButton(
                    Buttons.google,
                    text: "Sign up with Google",
                    onPressed: () async {
                      bool msg = await getsign.signWithgoogle();
                      if (msg == false) {
                        Get.snackbar("Shop Stop", "Invalid Entry");
                      } else {
                        Get.offAllNamed('homeScreen');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
