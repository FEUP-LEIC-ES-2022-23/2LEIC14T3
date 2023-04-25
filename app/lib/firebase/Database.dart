import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/review.dart';

class Database{
  static final FirebaseFirestore db = FirebaseFirestore.instance;

}