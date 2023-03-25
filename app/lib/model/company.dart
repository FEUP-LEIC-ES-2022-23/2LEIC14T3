import 'package:flutter/material.dart';
import 'package:my_app/model/review.dart';


class Company{
  final String name;
  int averageRating;
  List<Review> reviews;

  Company({
    required this.name,
    this.averageRating = 0,
    this.reviews = const [],
  });

  void addReview(Review review){
    final List<Review> updatedReviews = List.from(reviews)..add(review);
    final totalRating = updatedReviews.fold(0, (sum, review) => sum + review.rating);
    averageRating = totalRating ~/ updatedReviews.length;
    reviews = updatedReviews;
  }
}


