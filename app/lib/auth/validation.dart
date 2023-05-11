import 'package:flutter/material.dart';

import '../firestore/database.dart';

class Validation{
  static bool emptyField(String? value){
    return value == null || value.isEmpty;
  }

  static bool shortPassword(String? value){
    return value!.length < 6;
  }

  static bool invalidEmail(String? value){
    RegExp emailRegEx = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return !emailRegEx.hasMatch(value!);
  }

  static bool invalidPhone(String value){
    RegExp ptPhoneRegEx = RegExp(r'^(\+351)?[29]\d{8}$');
    return !ptPhoneRegEx.hasMatch(value);
  }

  static Future<bool> usedUsername(String value){
    return Database.isUsernameInUse(value);
  }

  static Future<bool> usedEmail(String value){
    return Database.isEmailInUse(value);
  }
}