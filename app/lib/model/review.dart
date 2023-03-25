import 'package:flutter/material.dart';

class Review {
  final String title;
  final String review;
  final String author;
  final int rating;
  int? votes;

  Review({
    required this.title,
    required this.review,
    required this.author,
    required this.rating,
    this.votes,
  });

  void upvote() {
    votes = (votes ?? 0) + 1;
  }

  void downvote() {
    votes = (votes ?? 0) - 1;
  }
}