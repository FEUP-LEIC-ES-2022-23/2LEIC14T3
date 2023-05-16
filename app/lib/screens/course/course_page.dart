import 'package:flutter/material.dart';
import 'package:rate_it/screens/course/rating_page_course.dart';
import 'package:rate_it/screens/course/reviews_page_course.dart';
import '../../model/course.dart';
import 'package:rate_it/screens/company/reviews_page_company.dart';
import '../../firestore/database.dart';
import '../../model/review.dart';
import '../company/rating_page_company.dart';

class CourseScreen extends StatefulWidget {
  final Course course;
  Review? userReviewOnCourse;

  CourseScreen({required this.course});

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _fetchReview();
  }

  Future<void> _fetchReview() async {
    Review? r = await Database.alreadyReviewedCourse(widget.course);
    setState(() {
      widget.userReviewOnCourse = r;
    });
  }

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
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(width: 8.0),
                              if (widget.course.company.description != null && widget.course.company.description.isNotEmpty)
                                Container(
                                  child: AnimatedCrossFade(
                                    duration: Duration(milliseconds: 300),
                                    firstChild: Flexible(
                                      child: Text(
                                        widget.course.company.description,
                                        maxLines: 3,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    secondChild: Text(
                                      widget.course.company.description,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                    firstCurve: Curves.easeIn,
                                  ),
                                ),
                              if (widget.course.company.description != null && widget.course.company.description.isNotEmpty)
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isExpanded = !isExpanded;
                                      });
                                    },
                                    child: Text(
                                      isExpanded ? 'Show Less' : 'Show More',
                                      style: TextStyle(color: Colors.blue, fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              if (widget.course.company.description == null || widget.course.company.description.isEmpty)
                                Container(
                                  child: Text(
                                    'No description available',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          widget.course.body,
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
                              widget.course.price == 0 ? 'Paid' : 'Free',
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
                            if (widget.userReviewOnCourse != null)
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                        builder: (context) => EventRatingPageCourse(course: widget.course, review: widget.userReviewOnCourse),
                                      )).then((_) {
                                    setState(() {
                                      widget.course.reviews = Database.fetchReviews(widget.course.id, widget.course.entityOrigin, 1);
                                      widget.course.setAverageRating();
                                    });
                                    _fetchReview();
                                  });
                                },
                                child: Text('Edit your review'),
                              ),
                            if (widget.userReviewOnCourse == null)
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                        builder: (context) => EventRatingPageCourse(course: widget.course),
                                      )).then((_){
                                    setState(() {
                                      widget.course.reviews = Database.fetchReviews(widget.course.id, widget.course.entityOrigin, 1);
                                      widget.course.setAverageRating();
                                    });
                                    _fetchReview();
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
