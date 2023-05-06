import 'package:flutter/material.dart';
import 'package:rate_it/screens/event/rating_page_event.dart';
import 'package:rate_it/screens/event/reviews_page_event.dart';
import '../../firestore/database.dart';
import '../../model/event.dart';
import '../../model/review.dart';

class EventScreen extends StatefulWidget {
  final Event event;

  EventScreen({required this.event});

  @override
  _EventScreenState createState() => _EventScreenState();

}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
      ),
      body: FutureBuilder<List<Review>>(
          future: widget.event.reviews,
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
                          widget.event.title,
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Icon(Icons.calendar_month_sharp),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                '${widget.event.dateStart} -> ${widget.event.dateEnd}',
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
                              widget.event.isPaid ? 'Paid' : 'Free',
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
                              widget.event.place,
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
                              widget.event.averageRating.toStringAsFixed(1),
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
                              onPressed: () async {
                                Review? userReviewOnEvent = await Database.alreadyReviewedEvent(widget.event);
                                if(userReviewOnEvent == null){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EventRatingPageEvent(event: widget.event),
                                    ),
                                  ).then((_){
                                    setState(() {
                                      widget.event.reviews = Database.fetchReviews(widget.event.id, widget.event.entityOrigin, 2);
                                      widget.event.setAverageRating();
                                    });
                                  });
                                }
                              },
                              child: Text('Rate this event'),

                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ReviewsPageEvent(event: widget.event),
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