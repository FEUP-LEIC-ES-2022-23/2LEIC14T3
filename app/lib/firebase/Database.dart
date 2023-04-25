import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/review.dart';

class Database{
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static Future<List<Review>> fetchReviews(int idEntity, int entityOrigin, int categoryIndex) async {
    Query query = db.collection("reviews")
        .where("idEntity", isEqualTo: idEntity)
        .where("entityOrigin", isEqualTo: entityOrigin)
        .where("categoryIndex", isEqualTo: categoryIndex);
    List<Review> reviews = [];
    QuerySnapshot review = await query.get();
    try {
      for (var doc in review.docs) {
        Review? r = doc.data() as Review?;
        if (r!=null){
          reviews.add(r);
        }
      }
    }
    catch (e){
      print("Error Fetching Reviews");
    }
    return reviews;
  }
}