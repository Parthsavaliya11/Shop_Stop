import 'package:firebase_messaging/firebase_messaging.dart';

void firebasenoti() {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  firebaseMessaging.getToken().then((value) {
    print("${value}--------------------------------");
  });

}
