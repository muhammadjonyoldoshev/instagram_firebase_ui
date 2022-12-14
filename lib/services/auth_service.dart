import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_firebase_ui/services/pref_service.dart';
import 'package:instagram_firebase_ui/services/utils_service.dart';
import '../pages/sign_in_page.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;

  static Future<User?> signUpUser(BuildContext context, String name, String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      var user = userCredential.user;
      await auth.currentUser?.updateDisplayName(name);
      return user;
    } catch (e) {
      debugPrint(e.toString());
      Utils.snackBar(e.toString(), context);
    }
    return null;
  }

  static Future<User?>? signInUser(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      debugPrint(e.toString());
      Utils.snackBar(e.toString(), context);
    }
    return null;
  }

  static Future<void> signOutUser(BuildContext context) async {
    await auth.signOut();
    HiveDB.removeUid().then((value) => {
      Navigator.pushReplacementNamed(context, SignInPage.id),
    });
  }
}