import 'package:flutter/material.dart';

import '../model/company.dart';
import '../model/review.dart';
import 'home_page.dart';

class EventRatingPage extends StatefulWidget {

  Company company;

  EventRatingPage({Key? key, required this.company}) : super(key: key);


  int _rating = 0;
  String _review = "";


  @override
  _EventRatingPageState createState() => _EventRatingPageState();

  void setReview(String value) {
    _review = value;
  }
}

class _EventRatingPageState extends State<EventRatingPage> {
  int rating = 0;

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
            ElevatedButton(
              onPressed: () {
                Review review = Review(
                  title: 'Review',
                  rating: widget._rating,
                  review: widget._review,
                  author: 'Anonymous',
                 );



                if(widget._rating > 0){
                  widget.company.addReview(review);
                  Navigator.pop(context);}



              },
              child: Text('Submit'),
            ),
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

}
