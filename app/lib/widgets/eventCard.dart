import 'package:flutter/material.dart';

import '../firestore/database.dart';
import '../model/event.dart';
import '../model/review.dart';
import '../screens/event/event_page.dart';

class EventCard extends StatefulWidget{
  final Event event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
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
                    builder: (context) => EventScreen(event: widget.event),
                  ),
                ).then((_){
                  setState(() {
                    widget.event.reviews = Database.fetchReviews(widget.event.id, widget.event.entityOrigin, 2);
                    widget.event.setAverageRating();
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
                            widget.event.title,
                            style: TextStyle(fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.calendar_month_sharp,color: Colors.blue[600],),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      '${widget.event.dateStart}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: 20.0,
                                      color: Colors.blueAccent,
                                    ),
                                    Text(
                                      '${widget.event.dateEnd}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.place,color: Colors.red,),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  '${widget.event.place}',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          FutureBuilder<List<Review>>(
                            future: widget.event.reviews,
                            builder: (context, snapshot) {
                              if (snapshot.hasData){
                                List<Review> rendReviews = snapshot.data!;
                                return Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow[700],),
                                    SizedBox(width: 8.0),
                                    Text(
                                      widget.event.averageRating
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
                  ],
                ),
              ),
            ),
          );
  }
}