import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rate_it/screens/reviews_page.dart';
import '../model/company.dart';
import '../model/review.dart';
import 'rating_page.dart';


class CompanyScreen extends StatefulWidget {
  final Company company;

  CompanyScreen({required this.company});

  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company.name),
      ),
      body: FutureBuilder<List<Review>>(
        future: widget.company.reviews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Review> renderedReviews = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Image.network(widget.company.logo),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.company.name,
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        widget.company.description,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 8.0),
                          Text(
                            widget.company.address,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Icon(Icons.star),
                          SizedBox(width: 8.0),
                          Text(
                            widget.company.averageRating.toStringAsFixed(1),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            '(${renderedReviews.length} reviews)',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EventRatingPage(company: widget.company),
                                ),
                              );
                            },
                            child: Text('Rate this company'),

                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ReviewsPage(company: widget.company),
                                ),
                              );
                            },
                            child: Text('Check Reviews'),
                          ),
                        ],

                      ),

                    ],
                  ),
                ),
              ],
            );
          }
          else if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong!');
          }
          else {
            return Center( child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}
