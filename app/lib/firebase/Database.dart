import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/review.dart';

class Database{
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static Future<List<Review>> fetchReviews(int idEntity, int entityOrigin, int categoryIndex) async {
    Query query = db.collection("reviews");
    query = query.where("idEntity", isEqualTo: idEntity);
    query = query.where("entityOrigin", isEqualTo: entityOrigin);
    query = query.where("categoryIndex", isEqualTo: categoryIndex);
    List<Review> reviews = [];

    QuerySnapshot querySnapshot = await query.get();
    for (var doc in querySnapshot.docs){
      Map<String, dynamic> reviewData = doc.data() as Map<String, dynamic>;
      print(reviewData);
      Review review = reviewFromMap(reviewData);
      reviews.add(review);
    }
    return reviews;
  }

  static void addReview(Review review){
    Database.db.collection('reviews').add({
      'title': review.title,
      'rating': review.rating,
      'review': review.review,
      'author': review.author,
      'idEntity': review.idEntity, // Add the companyId field
      'categoryIndex': review.categoryIndex,
      'entityOrigin': review.entityOrigin,
      'votes': review.votes,
    });
  }
}