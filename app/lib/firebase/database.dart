import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/review.dart';
import '../model/user.dart';

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
      Review review = reviewFromMap(reviewData, doc.id);
      reviews.add(review);
    }
    return reviews;
  }

  static void addReview(Review review) {
      db.collection('reviews').add({
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

  static void updateVoteReview(Review review, int vote) {
    try {
      db.collection("reviews").doc(review.reviewRef).update(
          {"votes": FieldValue.increment(vote)}
      );
    } catch(e){
      print("Error in updateVoteReview: $e");
    }
  }

  Future<User?> getUser(String uid) async {
    Query query = db.collection("users");
    query = query.where("uid", isEqualTo: uid);
    User? user;
    QuerySnapshot querySnapshot = await query.get();
    for (var doc in querySnapshot.docs){
      Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      user = userFromMap(userData);
    }
    if(user != null) {
      return user;
    }
    return null;
  }

  static Future<bool> isUsernameInUse(String username) async {
    Query query = db.collection("users");
    query = query.where("username", isEqualTo: username);
    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs.isNotEmpty;
  }
}