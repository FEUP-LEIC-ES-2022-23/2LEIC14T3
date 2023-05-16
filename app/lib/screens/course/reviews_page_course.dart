import 'package:flutter/material.dart';
import 'package:rate_it/model/review.dart';
import 'package:rate_it/widgets/review_card.dart';

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
                return ReviewCard(review: reviews[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
