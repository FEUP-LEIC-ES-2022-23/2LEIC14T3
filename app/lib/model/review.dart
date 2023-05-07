import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Review {
  String title;
  String review;
  String authorId;
  String? reviewRef;
  int rating;
  int categoryIndex; //0 if company; 1 if course; 2 if event.
  int entityOrigin; //0 if itjobs; 1 if RateIT
  int idEntity;
  bool anonymous;
  int votes;
  String slug;

  Review({
    required this.title,
    required this.review,
    required this.authorId,
    required this.rating,
    required this.categoryIndex,
    required this.idEntity,
    required this.entityOrigin,
    required this.votes,
    required this.anonymous,
    this.slug = "",
    this.reviewRef,
  });
}

Review reviewFromMap(Map<String, dynamic> data, String id){
  Review review = Review(
      reviewRef: id,
      title: data['title'],
      review: data['review'],
      authorId: data['authorId'],
      rating: data['rating'],
      categoryIndex: data['categoryIndex'],
      idEntity: data['idEntity'],
      entityOrigin: data['entityOrigin'],
      votes: data['votes'],
      anonymous: data['anonymous'],
      slug: data['slug']
  );
  return review;
}