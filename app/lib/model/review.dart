import 'package:flutter/material.dart';

class Review {
  String title;
  String review;
  String author;
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
  });

  void upvote() {
    votes = votes + 1;
  }

  void downvote() {
    votes = votes - 1;
  }
}

Review reviewFromMap(Map<String, dynamic> data){
  Review review = Review(
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