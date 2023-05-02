import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/Authentication.dart';
import '../firestore/database.dart';
import '../model/review.dart';

class ReviewCard extends StatefulWidget{
  final Review review;
  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.review.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'By ${widget.review.authorId}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Rating: ${widget.review.rating}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  String currUser = Authentication.auth.currentUser!.uid;
                  if (currUser != widget.review.authorId) {
                    Database.updateVoteReview(widget.review, 1);
                    setState(() {
                      widget.review.upvote();
                    });
                  }
                },
                icon: Icon(Icons.thumb_up),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  String currUser = Authentication.auth.currentUser!.uid;
                  if (currUser != widget.review.authorId) {
                    Database.updateVoteReview(widget.review, -1);
                    setState(() {
                      widget.review.downvote();
                    });
                  }
                },
                icon: Icon(Icons.thumb_down),
              ),
              Text(
                '${widget.review.votes}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '${widget.review.review}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}