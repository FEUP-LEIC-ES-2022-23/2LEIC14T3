import 'package:flutter/material.dart';

import '../firebase/database.dart';

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

  static Future<bool> usedUsername(String value){
    return Database.isUsernameInUse(value);
  }
}