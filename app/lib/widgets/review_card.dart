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
          FutureBuilder(
            future: authorUser,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData){
                User reviewUser = snapshot.data!;
                String uid = Authentication.auth.currentUser!.uid;
                if(!widget.review.anonymous || widget.review.authorId == uid){
                  return TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage(user: reviewUser)),
                      );
                    },
                    child: Text('@${reviewUser.username}'),
                  );
                } else {
                  return ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Text('@${reviewUser.username}'),
                  );
                }
              }
              else if (snapshot.hasError){
                return Text("User couldn't be fetched");
              }
              else return LinearProgressIndicator();
            },
          ),
          SizedBox(height: 8),
          Text(
            'Rating: ${widget.review.rating}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          UpDownVotes(review: widget.review),
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