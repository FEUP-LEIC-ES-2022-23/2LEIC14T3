import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/review.dart';

class Database{
  static final DatabaseReference dbReference = FirebaseDatabase.instance.ref();

}