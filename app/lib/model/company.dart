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

  addReview(Review review){
    reviews.add(review);
    averageRating = (averageRating + review.rating) ~/ reviews.length;
  }
}


