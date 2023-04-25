import 'package:flutter/material.dart';

class Review {
  final String title;
  final String review;
  final String author;
  final int rating;
  final int categoryIndex; //0 if company; 1 if course; 2 if event.
  final int entityOrigin; //0 if itjobs; 1 if RateIT
  final int idEntity;
  int? votes;

  Review({
    required this.title,
    required this.review,
    required this.author,
    required this.rating,
    required this.categoryIndex,
    required this.idEntity,
    required this.entityOrigin,
    this.votes,
  });

  void upvote() {
    votes = (votes ?? 0) + 1;
  }

  void downvote() {
    votes = (votes ?? 0) - 1;
  }
}