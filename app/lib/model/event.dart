import 'package:flutter/material.dart';
import 'package:rate_it/model/review.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

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
      events.add(Event.fromJson(result));
    }
    return events;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Companies');
  }
}


class Event{
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

  Event({
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
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title']??"",
      description: json['description']??"",
      dateStart: json['dateStart']??"",
      dateEnd: json['dateEnd']??"",
      place: json['fax']??"",
      email: json['email']??"",
      url: json['url']??"",
      isPaid: json['url_twitter']??false,
      updatedAt: json['updateAt']??"",
    );
  }
}