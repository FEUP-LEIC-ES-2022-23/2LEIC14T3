import 'package:flutter/material.dart';
import 'package:rate_it/model/review.dart';
import 'dart:math';
import 'package:rate_it/model/company.dart';

import '../../firebase/database.dart';
import '../../model/course.dart';

class ReviewsPageCourse extends StatefulWidget {
  Course course;

  ReviewsPageCourse({required this.course});

  @override
  _ReviewsPageCourseState createState() => _ReviewsPageCourseState();
}

class _ReviewsPageCourseState extends State<ReviewsPageCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews - ${widget.course.title} (${widget.course.averageRating.toStringAsFixed(2)})'),
      ),
      body: FutureBuilder<List<Review>>(
        future: widget.course.reviews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final reviews = snapshot.data!;
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${reviews[index].title}',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'By ${reviews[index].authorId}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Rating: ${reviews[index].rating}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Database.updateVoteReview(reviews[index], 1);
                              setState(() {
                                reviews[index].upvote();
                              });
                            },
                            icon: Icon(Icons.thumb_up),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              Database.updateVoteReview(reviews[index], -1);
                              setState(() {
                                reviews[index].downvote();
                              });
                            },
                            icon: Icon(Icons.thumb_down),
                          ),
                          Text(
                            '${reviews[index].votes}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${reviews[index].review}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
