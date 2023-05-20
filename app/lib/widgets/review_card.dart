import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_it/screens/profile_page.dart';
import 'package:rate_it/widgets/updownvotes.dart';

import '../auth/Authentication.dart';
import '../firestore/database.dart';
import '../model/review.dart';
import '../model/user.dart';

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
  late Future<User> authorUser;
  bool showFullReview = false;

  @override
  void initState() {
    authorUser = Database.getUser(widget.review.authorId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 8.0),
              Text(
                widget.review.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8.0),
              const Text(
                'by',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              FutureBuilder(
                future: authorUser,
                builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                  if (snapshot.hasData) {
                    User reviewUser = snapshot.data!;
                    String uid = Authentication.auth.currentUser!.uid;
                    if (!widget.review.anonymous || widget.review.authorId == uid) {
                      return TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage(user: reviewUser)),
                          );
                        },
                        child: Text(
                          '${reviewUser.username}',
                          style: const TextStyle(
                            color: Color(0xFF1976D2),
                          ),
                        ),
                      );
                    } else {
                      return ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Text('@${reviewUser.username}'),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text("User couldn't be fetched");
                  } else {
                    return LinearProgressIndicator();
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              SizedBox(width: 8.0),
              Text(
                'Reviewed to:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8.0),
              Text(
                '${widget.review.idEntity}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              SizedBox(width: 8.0),
              Text(
                'Rating:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8.0),
              Text(
                '${widget.review.rating}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 8.0),
              Row(
                children: List.generate(
                  widget.review.rating,
                      (index) => Icon(Icons.star, color: Colors.yellow[700]),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Visibility(
            visible: widget.review.review.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 8.0),
                    Text(
                      'Review: ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final textSpan = TextSpan(
                            text: widget.review.review,
                            style: TextStyle(fontSize: 18),
                          );
                          final textPainter = TextPainter(
                            text: textSpan,
                            textDirection: TextDirection.ltr,
                            maxLines: 2,
                          );
                          textPainter.layout(maxWidth: constraints.maxWidth);

                          final hasOverflow = textPainter.didExceedMaxLines;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.review.review,
                                style: TextStyle(fontSize: 18),
                                maxLines: showFullReview || !hasOverflow ? null : 2,
                                overflow: TextOverflow.fade,
                              ),
                              if (hasOverflow)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          showFullReview = !showFullReview;
                                        });
                                      },
                                      child: Text(
                                        showFullReview ? 'Show Less' : 'Show More',
                                        style: TextStyle(fontSize: 18, color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: UpDownVotes(review: widget.review),
          ),
        ],
      ),
    );
  }
}

