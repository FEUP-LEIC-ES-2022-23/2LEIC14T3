import 'package:flutter/material.dart';
import 'dart:math';

class Review {
  final String title;
  final String review;
  final String author;
  final int rating;
  int? votes;

  Review({
    required this.title,
    required this.review,
    required this.author,
    required this.rating,
    this.votes,
  });

  void upvote() {
    votes = (votes ?? 0) + 1;
  }

  void downvote() {
    votes = (votes ?? 0) - 1;
  }
}
class ReviewsPage extends StatefulWidget {
  final List<Review> reviews;

  const ReviewsPage({Key? key, required this.reviews}) : super(key: key);

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView.builder(
          itemCount: widget.reviews.length,
          itemBuilder: (context, index) {
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
                    '${widget.reviews[index].title}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'By ${widget.reviews[index].author}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rating: ${widget.reviews[index].rating}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.reviews[index].upvote();
                          });
                        },
                        icon: Icon(Icons.thumb_up),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.reviews[index].downvote();
                          });
                        },
                        icon: Icon(Icons.thumb_down),
                      ),
                      Text(
                        '${widget.reviews[index].votes}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${widget.reviews[index].review}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
