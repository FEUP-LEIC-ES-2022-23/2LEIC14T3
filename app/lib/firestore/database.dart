import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rate_it/auth/Authentication.dart';

import '../model/company.dart';
import '../model/course.dart';
import '../model/event.dart';
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
        'authorId': review.authorId,
        'idEntity': review.idEntity, // Add the companyId field
        'categoryIndex': review.categoryIndex,
        'entityOrigin': review.entityOrigin,
        'votes': review.votes,
        'anonymous': review.anonymous,
      });
  }

  static void updateVoteReview(Review review, int increment) {
      db.collection("reviews").doc(review.reviewRef).update(
          {"votes": FieldValue.increment(increment)}
      );

  }

  static Future<User> getUser(String uid) async {
    var val = await db.collection("users").doc(uid).get();
    Map<String,dynamic> map = val.data()!;
    User user = userFromMap(map);
    return user;
  }

  static void addUser(User user) {
    String uid = Authentication.auth.currentUser!.uid;
    db.collection('users').doc(uid).set({
      'uid': user.uid,
      'username': user.username,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'email': user.email,
      'photoURL': user.photoURL,
      'description': user.description,
      'phone': user.phone,
      'isPrivate': user.isPrivate,
    });
  }

  static Future<bool> isUsernameInUse(String username) async {
    Query query = db.collection("users");
    query = query.where("username", isEqualTo: username);
    QuerySnapshot querySnapshot = await query.get();
    return querySnapshot.docs.isNotEmpty;
  }

  static void changePrivate(String uid, bool value) {
    db.collection("users").doc(uid).update({"isPrivate": value});
  }

  static Future<bool> isPrivate(String uid) async {
    var val = await db.collection("users").doc(uid).get();
    Map<String,dynamic> map = val.data()!;
    User user = userFromMap(map);
    return user.isPrivate;
  }


  static void updateUsername(String uid, String username) {
      db.collection("users").doc(uid).update({"username": username});
  }

  static void updateName(String uid, String firstName, String lastName) {
      db.collection("users").doc(uid).update({"firstName": firstName, "lastName": lastName});
  }

  static void updateBio(String uid, String bio) {
    db.collection("users").doc(uid).update({"description": bio});
  }

  static void updatePhone(String uid, String phone) {
    db.collection("users").doc(uid).update({"phone": phone});
  }

  static Future<Review?> alreadyReviewedCompany(Company company) async {
    Query query = db.collection("reviews");
    query = query.where("idEntity", isEqualTo: company.id);
    query = query.where("entityOrigin", isEqualTo: company.entityOrigin);
    query = query.where("categoryIndex", isEqualTo: 0);
    query = query.where("authorId", isEqualTo: Authentication.auth.currentUser!.uid);
    QuerySnapshot querySnapshot = await query.get();
    Review? review;
    for(var doc in querySnapshot.docs){
      Map<String, dynamic> reviewData = doc.data() as Map<String, dynamic>;
      review = reviewFromMap(reviewData, doc.id);
    }
    return review;
  }

  static Future<Review?> alreadyReviewedCourse(Course course) async {
    Query query = db.collection("reviews");
    query = query.where("idEntity", isEqualTo: course.id);
    query = query.where("entityOrigin", isEqualTo: course.entityOrigin);
    query = query.where("categoryIndex", isEqualTo: 1);
    query = query.where("authorId", isEqualTo: Authentication.auth.currentUser!.uid);
    QuerySnapshot querySnapshot = await query.get();
    Review? review;
    for(var doc in querySnapshot.docs){
      Map<String, dynamic> reviewData = doc.data() as Map<String, dynamic>;
      review = reviewFromMap(reviewData, doc.id);
    }
    return review;
  }

  static Future<Review?> alreadyReviewedEvent(Event event) async {
    Query query = db.collection("reviews");
    query = query.where("idEntity", isEqualTo: event.id);
    query = query.where("entityOrigin", isEqualTo: event.entityOrigin);
    query = query.where("categoryIndex", isEqualTo: 2);
    query = query.where("authorId", isEqualTo: Authentication.auth.currentUser!.uid);
    QuerySnapshot querySnapshot = await query.get();
    Review? review;
    for(var doc in querySnapshot.docs){
      Map<String, dynamic> reviewData = doc.data() as Map<String, dynamic>;
      review = reviewFromMap(reviewData, doc.id);
    }
    return review;
  }

  static void updateUserPhotoURL(String uid, String url){
    db.collection("users").doc(uid).update(
        {"photoURL": url}
    );
  }

  static Future<List<Review>> getUserReviews(String uid, int categoryIndex) async {
    Query query = db.collection("reviews");
    query = query.where("categoryIndex", isEqualTo: categoryIndex);
    query = query.where("authorId", isEqualTo: uid);
    QuerySnapshot querySnapshot = await query.get();
    List<Review> lr = [];
    for(var doc in querySnapshot.docs){
      Map<String, dynamic> reviewData = doc.data() as Map<String, dynamic>;
      Review review = reviewFromMap(reviewData, doc.id);
      lr.add(review);
    }
    return lr;
  }

  static Future<int> getVoting(String reviewRef) async {
    String uid = Authentication.auth.currentUser!.uid;
    var query = db.collection("reviews").doc(reviewRef).collection("updownvotes").doc(uid);
    var snapshot = await query.get();
    if(snapshot.exists){
      Map<String,dynamic> map = snapshot.data()!;
      return map['voting'];
    }
    else {
      return 0;
    }
  }

  static void setVoting(String reviewRef, int voting){
    String uid = Authentication.auth.currentUser!.uid;
    if (voting != 0) {
      db.collection('reviews').doc(reviewRef)
        .collection("updownvotes").doc(uid).set({'voting': voting, 'uid':uid}, SetOptions(merge: true));
    } else {
      db.collection('reviews').doc(reviewRef)
          .collection("updownvotes").doc(uid).delete();
    }
  }

  static Future<void> updateReview(Review? review) async {
    await deleteReviewUpDownvotes(review!);
    db.collection("reviews").doc(review.reviewRef).set({
      'title': review.title,
      'rating': review.rating,
      'review': review.review,
      'authorId': review.authorId,
      'idEntity': review.idEntity, // Add the companyId field
      'categoryIndex': review.categoryIndex,
      'entityOrigin': review.entityOrigin,
      'votes': 0,
      'anonymous': review.anonymous,
    }, SetOptions(merge: true));
  }

  static Future<void> deleteReviewUpDownvotes(Review review) async {
    Query query = db.collection("reviews").doc(review.reviewRef).collection("updownvotes");
    QuerySnapshot snapshot = await query.get();
    for(var doc in snapshot.docs){
      await doc.reference.delete();
    }
  }

  static Future<void> deleteReview(Review review) async {
    await deleteReviewUpDownvotes(review);
    await db.collection("reviews").doc(review.reviewRef).delete();
  }
}