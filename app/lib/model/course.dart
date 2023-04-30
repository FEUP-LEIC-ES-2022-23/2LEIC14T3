import 'package:flutter/material.dart';
import 'package:rate_it/model/company.dart';
import 'package:rate_it/model/review.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../firebase/database.dart';

Future<List<Course>> fetchCourses({int limit=10, int page=1}) async {
  String apiKey = '80ab3270aee92b0b9b864fa3ae812ee9';
  String url = 'https://api.itjobs.pt/course/list.json?api_key=$apiKey';
  url += '&limit=$limit';
  url += '&page=$page';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> results = jsonDecode(response.body)['results'];
    List<Course> courses = [];
    for (var result in results) {
      courses.add(Course.fromJson(result));
    }
    return courses;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Companies');
  }
}

Future<List<Course>> searchCourses(String query,{int limit=10, int page=1}) async {
  String apiKey = '80ab3270aee92b0b9b864fa3ae812ee9';
  String url = 'https://api.itjobs.pt/course/search.json?q=$query&api_key=$apiKey';
  url += '&limit=$limit';
  url += '&page=$page';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> results = jsonDecode(response.body)['results'];
    List<Course> courses = [];
    for (var result in results) {
      courses.add(Course.fromJson(result));
    }
    return courses;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Companies');
  }
}


class Course{
  final int entityOrigin; //0 if itjobs; 1 if RateIT
  final int id;
  Company company;
  String title;
  String body;
  String dateStart;
  String dateEnd;
  int price;
  String place;
  int courseTypeId;
  int hours;
  String schedule;
  String target;
  bool isPresencial;
  bool isCertified;
  bool isFunded;
  String url;
  String contactName;
  String contactEmail;
  String contactPhone;
  String requirements;
  String publishedAt;
  String updatedAt;
  double averageRating;
  Future<List<Review>> reviews;


  Course({
    required this.entityOrigin,
    required this.id,
    required this.company,
    this.title = "",
    this.body = "",
    this.dateStart = "",
    this.dateEnd = "",
    this.price = 0,
    this.place = "",
    this.courseTypeId = 0,
    this.hours = 0,
    this.schedule = "",
    this.target = "",
    this.isPresencial = false,
    this.isCertified = false,
    this.isFunded = false,
    this.url = "",
    this.contactName = "",
    this.contactEmail = "",
    this.contactPhone = "",
    this.requirements = "",
    this.publishedAt = "",
    this.updatedAt = "",
    this.averageRating = 0,
    required this.reviews,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      entityOrigin: 0,
      id: json['id'],
      title: json['title']??"",
      company: Company.fromJson(json['company']),
      body: json['description']??"",
      dateStart: json['dateStart']??"",
      dateEnd: json['dateEnd']??"",
      price: json['price']??"",
      place: json['place']??"",
      courseTypeId: json['courseTypeId']??0,
      hours: json['hours']??0,
      schedule: json['schedule']??"|",
      target: json['target']??"",
      isPresencial: json['isPresencial'],
      isCertified: json['isCertified'],
      isFunded: json['isFunded'],
      contactName: json['contactName']??"",
      contactEmail: json['contactEmail']??"",
      contactPhone: json['contactPhone']??"",
      requirements: json['requirements']??"",
      publishedAt: json['requirements']??"",
      updatedAt: json['updatedAt']??"",
    );
  }
  void setAverageRating() async{
    List<Review> rendReviews = await reviews;
    int sum = 0;
    for (Review r in rendReviews){
      sum += r.rating;
    }
    if (sum != 0) {
      averageRating = sum / rendReviews.length;
    }
  }
}

