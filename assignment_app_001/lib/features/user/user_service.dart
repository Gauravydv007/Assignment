import 'package:assignment_app_001/features/user/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManagement {
  storeNewUser(user, context) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      FirebaseFirestore.instance
          .collection('user')
          .doc(firebaseUser.uid)
          .set({'email': user.email, 'uid': user.uid}).then((value) =>
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserPage()))
                  .catchError((e) {
                print(e);
              }));
    } else {
      print("User is not authenticated.");
    }
  }
}
