
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/model/company.dart';
import 'package:rate_it/widgets/review_card.dart';

import '../model/course.dart';
import '../model/event.dart';
import '../model/review.dart';
import '../screens/company/company_page.dart';
import '../screens/course/course_page.dart';
import '../screens/event/event_page.dart';

class ReviewCardProfile extends StatefulWidget{
  Review review;

  ReviewCardProfile({
    super.key,
    required this.review,
  });

  @override
  State<ReviewCardProfile> createState() => _ReviewCardProfileState();
}

class _ReviewCardProfileState extends State<ReviewCardProfile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: ReviewCard(review: widget.review),
        ),
        if (widget.review.categoryIndex == 0)
          Positioned(
            top: 0,
            right: 10,
            child: FutureBuilder(
              future: getCompany(widget.review.slug),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData){
                  Company company = snapshot.data!;
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompanyScreen(company: company),
                          ),
                        );
                      },
                      child: Text("Learn More")
                  );
                } else if (snapshot.hasError) {
                  return Text("Something went wrong: ${snapshot.error}");
                } else {
                  return ElevatedButton(onPressed: null, child: Text('...'));
                }
              },
            )
          ),
        if (widget.review.categoryIndex == 1)
          Positioned(
              top: 0,
              right: 10,
              child: FutureBuilder(
                future: getCourse(widget.review.idEntity),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData){
                    Course course = snapshot.data!;
                    return ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseScreen(course: course),
                            ),
                          );
                        },
                        child: Text("Learn More")
                    );
                  } else if (snapshot.hasError) {
                    return Text("Something went wrong");
                  } else {
                    return ElevatedButton(onPressed: null, child: Text('...'));
                  }
                },
              )
          ),
        if (widget.review.categoryIndex == 2)
          Positioned(
              top: 0,
              right: 10,
              child: FutureBuilder(
                future: getEvent(widget.review.idEntity),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData){
                    Event event = snapshot.data!;
                    return ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventScreen(event: event),
                            ),
                          );
                        },
                        child: Text("Learn More")
                    );
                  } else if (snapshot.hasError) {
                    return Text("Something went wrong");
                  } else {
                    return ElevatedButton(onPressed: null, child: Text('...'));
                  }
                },
              )
          ),
      ],
    );
  }
}