import 'package:flutter/material.dart';
import 'package:rate_it/screens/event/rating_page_event.dart';

import '../../firestore/database.dart';
import '../../model/event.dart';
import '../../model/review.dart';

class ReviewButtonEvent extends StatefulWidget{
  Event event;

  ReviewButtonEvent({
    super.key,
    required this.event,
  });

  @override
  State<ReviewButtonEvent> createState() => _ReviewButtonEventState();
}

class _ReviewButtonEventState extends State<ReviewButtonEvent> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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

    );
  }
}

