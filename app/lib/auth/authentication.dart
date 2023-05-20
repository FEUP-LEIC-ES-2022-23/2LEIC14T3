import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Authentication {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static String uEmail = "";
  static String uPassword = "";

  static Future<String> register(String email, String password) async {
    await Firebase.initializeApp();
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
    return "successful-register";
  }

  static Future<String> login(String email, String password) async {
    await Firebase.initializeApp();
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      uEmail = email;
      uPassword = password;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }

      return e.code;
    }
    return "successful-login";
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }



  static Future<bool> verifyPassword(String currentPassword) async {
    try {
      await Firebase.initializeApp();

      // Get the currently logged-in user
      User? currentUser = auth.currentUser;

      // Re-authenticate the user with the current password
      AuthCredential credential =
      EmailAuthProvider.credential(email: uEmail, password: currentPassword);
      await currentUser?.reauthenticateWithCredential(credential);

      // If re-authentication is successful, the current password is correct
      return true;
    } on FirebaseAuthException catch (e) {
      // Handle any authentication errors, such as incorrect password
      return false;
    } catch (e) {
      // Handle other exceptions
      return false;
    }
  }
}
