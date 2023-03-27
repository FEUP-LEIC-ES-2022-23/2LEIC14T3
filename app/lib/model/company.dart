import 'package:flutter/material.dart';
import 'package:my_app/model/review.dart';


class Company{
  final String name;
  double averageRating;
  List<Review> reviews;

  Company({
    required this.name,
    this.averageRating = 0,
    required this.reviews,
  });

  void addReview(Review review){

    double temp = averageRating;

    reviews.add(review);

    averageRating = (temp * (reviews.length - 1) + review.rating)/reviews.length ;

  }
}


