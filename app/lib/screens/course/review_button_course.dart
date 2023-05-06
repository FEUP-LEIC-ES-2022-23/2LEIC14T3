import 'package:flutter/material.dart';
import 'package:rate_it/screens/course/rating_page_course.dart';

import '../../firestore/database.dart';
import '../../model/course.dart';
import '../../model/review.dart';

class ReviewButtonCourse extends StatefulWidget{
  Course course;

  ReviewButtonCourse({
    super.key,
    required this.course,
  });

  @override
  State<ReviewButtonCourse> createState() => _ReviewButtonCourseState();
}

class _ReviewButtonCourseState extends State<ReviewButtonCourse> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        Review? userReviewOnCourse = await Database.alreadyReviewedCourse(widget.course);
        if(userReviewOnCourse == null){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EventRatingPageCourse(course: widget.course),
            ),
          ).then((_){
            setState(() {
              widget.course.reviews = Database.fetchReviews(widget.course.id, widget.course.entityOrigin, 1);
              widget.course.setAverageRating();
            });
          });
        }
      },
      child: Text('Rate this course'),

    );
  }
}

