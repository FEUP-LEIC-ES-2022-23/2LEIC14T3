import 'package:flutter/material.dart';
import 'package:rate_it/model/review.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../firestore/database.dart';

Future<List<Event>> fetchEvents({int limit=10, int page=1}) async {
  String apiKey = '80ab3270aee92b0b9b864fa3ae812ee9';
  String url = 'https://api.itjobs.pt/event/list.json?api_key=$apiKey';
  url += '&limit=$limit';
  url += '&page=$page';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> results = jsonDecode(response.body)['results'];
    List<Event> events = [];
    for (var result in results) {
      Event event = Event.fromJson(result);
      event.setAverageRating();
      events.add(event);
    }
    return events;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Companies');
  }
}

Future<List<Event>> searchEvents(String query,{int limit=10, int page=1}) async {
  String apiKey = '80ab3270aee92b0b9b864fa3ae812ee9';
  String url = 'https://api.itjobs.pt/event/search.json?q=$query&api_key=$apiKey';
  url += '&limit=$limit';
  url += '&page=$page';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    List<dynamic> results = jsonDecode(response.body)['results'];
    List<Event> events = [];
    for (var result in results) {
      Event event = Event.fromJson(result);
      event.setAverageRating();
      events.add(event);
    }
    return events;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Companies');
  }
}


class Event{
  final int entityOrigin; //0 if itjobs; 1 if RateIT
  final int id;
  final String title;
  String description;
  String dateStart;
  String dateEnd;
  String place;
  String email;
  String url;
  bool isPaid;
  String updatedAt;
  double averageRating;
  Future<List<Review>> reviews;

  Event({
    required this.entityOrigin,
    required this.id,
    required this.title,
    this.description = "",
    this.dateStart = "",
    this.dateEnd = "",
    this.place = "",
    this.email = "",
    this.url = "",
    this.isPaid = false,
    this.updatedAt = "",
    this.averageRating = 0,
    required this.reviews,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      entityOrigin: 0,
      id: json['id'],
      title: json['title']??"",
      description: json['description']??"",
      dateStart: json['dateStart']??"",
      dateEnd: json['dateEnd']??"",
      place: json['place']??"",
      email: json['email']??"",
      url: json['url']??"",
      isPaid: json['isPaid']??false,
      updatedAt: json['updateAt']??"",
      reviews: Database.fetchReviews(json['id'],0,2),
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
    } else {
      averageRating = 0;
    }
  }
}
