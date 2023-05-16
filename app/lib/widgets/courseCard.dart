import 'package:flutter/material.dart';

import '../firestore/database.dart';
import '../model/course.dart';
import '../model/review.dart';
import '../screens/course/course_page.dart';

class CourseCard extends StatefulWidget{
  final Course course;

  const CourseCard({
    super.key,
    required this.course,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
            color: Colors.blue[50],
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseScreen(course: widget.course),
                  ),
                ).then((_){
                  setState(() {
                    widget.course.reviews = Database.fetchReviews(widget.course.id, widget.course.entityOrigin, 1);
                    widget.course.setAverageRating();
                  });
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.course.title,
                            style: TextStyle(fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
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
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.place),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  '${widget.course.place}',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          FutureBuilder<List<Review>>(
                            future: widget.course.reviews,
                            builder: (context, snapshot) {
                              if (snapshot.hasData){
                                List<Review> rendReviews = snapshot.data!;
                                return Row(
                                  children: [
                                    Icon(Icons.star),
                                    SizedBox(width: 8.0),
                                    Text(
                                      widget.course.averageRating
                                          .toStringAsFixed(1),
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      '(${rendReviews.length} reviews)',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                );
                              }
                              else if (snapshot.hasError) {
                                print('You have an error! ${snapshot.error.toString()}');
                                return Text('Something went wrong!');
                              }
                              else {
                                return Center(child: LinearProgressIndicator(),);
                              }
                            }
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 125,
                      width: 125,
                      child: Image.network(widget.course.company.logo),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}