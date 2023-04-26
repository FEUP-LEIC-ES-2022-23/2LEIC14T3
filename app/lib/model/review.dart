import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Review {
  String title;
  String review;
  String author;
  String? reviewRef;
  int rating;
  int categoryIndex; //0 if company; 1 if course; 2 if event.
  int entityOrigin; //0 if itjobs; 1 if RateIT
  int idEntity;
  int votes;

  Review({
    required this.title,
    required this.review,
    required this.author,
    required this.rating,
    required this.categoryIndex,
    required this.idEntity,
    required this.entityOrigin,
    required this.votes,
    this.reviewRef,
  });

  void upvote() {
    votes = votes + 1;
  }

  void downvote() {
    votes = votes - 1;
  }
}

Review reviewFromMap(Map<String, dynamic> data, String id){
  Review review = Review(
      reviewRef: id,
      title: data['title'],
      review: data['review'],
      author: data['author'],
      rating: data['rating'],
      categoryIndex: data['categoryIndex'],
      idEntity: data['idEntity'],
      entityOrigin: data['entityOrigin'],
      votes: data['votes']
  );
  return review;
}