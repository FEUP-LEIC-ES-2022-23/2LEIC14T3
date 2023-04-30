import 'package:flutter/material.dart';
import 'package:rate_it/screens/rating_page_course.dart';
import 'package:rate_it/screens/reviews_page_course.dart';
import '../model/course.dart';
import 'package:rate_it/screens/reviews_page_company.dart';
import '../firebase/database.dart';
import '../model/review.dart';
import 'rating_page_company.dart';

class CourseScreen extends StatefulWidget {
  final Course course;

  CourseScreen({required this.course});

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
      ),
      body: FutureBuilder<List<Review>>(
          future: widget.course.reviews,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Review> renderedReviews = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 16.0),
                        Text(
                          widget.course.title,
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          widget.course.description,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Icon(Icons.calendar_month_sharp),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                '${widget.course.dateStart} -> ${widget.course.dateEnd}',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Icon(Icons.attach_money),
                            SizedBox(width: 8.0),
                            Text(
                              widget.course.isPaid ? 'Paid' : 'Free',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 8.0),
                            Text(
                              widget.course.place,
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
                              widget.course.averageRating.toStringAsFixed(1),
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
                                        EventRatingPageCourse(course: widget.course),
                                  ),
                                ).then((_){
                                  setState(() {
                                    widget.course.reviews = Database.fetchReviews(widget.course.id, widget.course.entityOrigin, 0);
                                    widget.course.setAverageRating();
                                  });
                                });
                              },
                              child: Text('Rate this course'),

                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ReviewsPageCourse(course: widget.course),
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
