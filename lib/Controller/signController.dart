import 'package:fierbase/model/Signindetailmodel;.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class signController extends GetxController {
  bool checks = true;

  TextEditingController txt_mailUp = TextEditingController();
  TextEditingController txt_passwordUp = TextEditingController();
  TextEditingController txt_mailIn = TextEditingController();
  TextEditingController txt_passwordIn = TextEditingController();
  RxString useremail = "".obs,userid = "".obs;


  Future<String> signUp(String e1, String p1) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.createUserWithEmailAndPassword(
          email: e1, password: p1);
      return "Registerd success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return "Password Too Weak";
      } else if (e.code == 'email-already-in-use') {
        return "Email Already Registerd";
      }
    }
    return "Invalid Entry";
  }

  Future<String> signIn(String e1, String p1) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signInWithEmailAndPassword(email: e1, password: p1);
      return "Login success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return "Email Not Found";
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return "Wrong Password";
      }
    }
    return "Invalid Entry";
  }

  bool checkuser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  void logout() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut();
  }

  Future<bool> signWithgoogle() async {
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    var cred = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signInWithCredential(cred);
    return checkuser();
  }

  Future<void> googlelogout() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

   void signdetail() async {
    User? user = FirebaseAuth.instance.currentUser;
    useremail.value = await user!.email!;
    userid.value = await user.uid;
  }
}
