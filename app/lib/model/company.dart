import 'package:flutter/material.dart';
import 'package:rate_it/model/review.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<List<Company>> fetchCompanies({String query='a',int limit=10, int page=1}) async {
  String apiKey = '80ab3270aee92b0b9b864fa3ae812ee9';
  String url = 'https://api.itjobs.pt/company/search.json?q=$query&api_key=$apiKey';
  url += '&limit=$limit';
  url += '&page=$page';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> results = jsonDecode(response.body)['results'];
    List<Company> companies = [];
    for (var result in results) {
      companies.add(Company.fromJson(result));
    }
    return companies;
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
      name: json['name']??"",
      logo: json['logo']??"",
      description: json['description']??"",
      address: json['address']??"",
      phone: json['phone']?.toString()??"",
      fax: json['fax']?.toString()??"",
      email: json['email']??"",
      url: json['url']??"",
      url_twitter: json['url_twitter']??"",
      url_facebook: json['url_facebook']??"",
      url_linkedin: json['url_linkedin']??"",
      reviews: [],
    );
  }



  void addReview(Review review){
    double temp = averageRating;
    reviews.add(review);
    averageRating = (temp * (reviews.length - 1) + review.rating)/reviews.length ;
  }
}


