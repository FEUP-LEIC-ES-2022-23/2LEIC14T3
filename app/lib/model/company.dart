import 'package:flutter/material.dart';
import 'package:rate_it/model/review.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<Company> fetchCompanies({String query='a',int limit=10}) async {
  String apiKey = '80ab3270aee92b0b9b864fa3ae812ee9';
  String url = 'https://api.itjobs.pt/company/search.json?q=$query&api_key=$apiKey';
  url += '&limit=$limit';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Company.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Companies');
  }
}


class Company{
  final String name;
  String logo;
  String description;
  String address;
  String phone;
  String fax;
  String email;
  String url;
  String url_twitter;
  String url_facebook;
  String url_linkedin;
  double averageRating;
  List<Review> reviews;

  Company({
    required this.name,
    this.logo = "",
    this.description = "",
    this.address = "",
    this.phone = "",
    this.fax = "",
    this.email = "",
    this.url = "",
    this.url_twitter = "",
    this.url_facebook = "",
    this.url_linkedin = "",
    this.averageRating = 0,
    required this.reviews,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['results'][0]['name'],
      logo: json['results'][0]['logo'],
      description: json['results'][0]['description'],
      address: json['results'][0]['address'],
      phone: json['results'][0]['phone'],
      fax: json['results'][0]['fax'],
      email: json['results'][0]['email'],
      url: json['results'][0]['url'],
      url_twitter: json['results'][0]['url_twitter'],
      url_facebook: json['results'][0]['url_facebook'],
      url_linkedin: json['results'][0]['url_linkedin'],
      reviews: [],
    );
  }



  void addReview(Review review){
    double temp = averageRating;
    reviews.add(review);
    averageRating = (temp * (reviews.length - 1) + review.rating)/reviews.length ;
  }
}


