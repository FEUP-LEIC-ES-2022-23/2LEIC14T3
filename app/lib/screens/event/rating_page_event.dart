import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/auth/Authentication.dart';

import '../../firestore/database.dart';
import '../../model/event.dart';
import '../../model/review.dart';

class EventRatingPageEvent extends StatefulWidget {

  Event event;
  Review? review;

  EventRatingPageEvent({Key? key, required this.event, this.review}) : super(key: key);

  int _rating = 0;
  String _review = "";
  bool _anonymous = false;

  @override
  _EventRatingPageEventState createState() => _EventRatingPageEventState();

  void setReview(String value) {
    _review = value;
  }
}

class _EventRatingPageEventState extends State<EventRatingPageEvent> {
  @override
  void initState() {
    if(widget.review != null){
      setState(() {
        widget._rating = widget.review!.rating;
        widget._anonymous = widget.review!.anonymous;
        widget._review = widget.review!.review;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate this Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How many stars would you give this event?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStarButton(1),
                _buildStarButton(2),
                _buildStarButton(3),
                _buildStarButton(4),
                _buildStarButton(5),
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Write a review:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter your review here...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: widget.setReview,
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Text(
                  'Anonymous Review:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 16),
                Switch(
                  value: widget._anonymous,
                  onChanged: (bool newValue) {
                    setState(() {
                      widget._anonymous = newValue;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 32),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: releaseReview,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Submit', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 8.0),
                        Icon(Icons.send_rounded, color: Colors.white),
                      ],
                    ),
                  ),
                  if (widget.review != null)
                    ElevatedButton(
                      onPressed: deleteReview,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.trashCan, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text('Delete Review', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    )
                ]
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStarButton(int value) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          widget._rating = value;
        });
      },
      child: Icon(
        Icons.star,
        color: value <= widget._rating ? Colors.amber : Colors.grey[400],
      ),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(16),
        primary: Colors.white,
        onPrimary: Colors.black,
      ),
    );
  }

  Future<void> releaseReview() async {
    String author = Authentication.auth.currentUser!.uid;
    if (widget.review != null){
      setState(() {
        widget.review!.review = widget._review;
        widget.review!.anonymous = widget._anonymous;
        widget.review!.rating = widget._rating;
      });
      if (widget._rating > 0){
        await Database.updateReview(widget.review);
        Navigator.pop(context);
      }
    }
    else{
      Review newReview = Review(
        title: 'Review',
        rating: widget._rating,
        review: widget._review,
        authorId: author,
        anonymous: widget._anonymous,
        categoryIndex: 2,
        idEntity: widget.event.id,
        entityOrigin: widget.event.entityOrigin,
        votes: 0,
      );

      if (widget._rating > 0) {
        Database.addReview(newReview);
        Navigator.pop(context);
      }
    }
  }
  Future<void> deleteReview() async {
    await Database.deleteReview(widget.review!);
    Navigator.pop(context);
  }
}
