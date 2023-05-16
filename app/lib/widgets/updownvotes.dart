import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth/Authentication.dart';
import '../firestore/database.dart';
import '../model/review.dart';

class UpDownVotes extends StatefulWidget{
  Review review;
  UpDownVotes({
    super.key,
    required this.review,
  });

  @override
  State<UpDownVotes> createState() => _UpDownVotesState();
}

class _UpDownVotesState extends State<UpDownVotes> {
  int userVote = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Database.getVoting(widget.review.reviewRef!),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData){
          userVote = snapshot.data!;
          return Row(
            children: [
              IconButton(
                onPressed: () {
                  updownvoteDynamic(1);
                },
                icon: upvoteIcon(userVote),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  updownvoteDynamic(-1);
                },
                icon: downvoteIcon(userVote),
              ),
              Text(
                '${widget.review.votes}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          );
        }
        else if (snapshot.hasError) return Text("Ahhhh error!");
        else {
          return Row(
            children: [
              Icon(FontAwesomeIcons.thumbsUp),
              SizedBox(width: 8),
              Icon(FontAwesomeIcons.thumbsDown),
              Text('0', style: TextStyle(fontSize: 18)),
            ],
          );
        }
      },
    );
  }

  Widget upvoteIcon(int userVote){
    if (userVote == 1) return Icon(FontAwesomeIcons.solidThumbsUp, color: Color(0xFF1976D2),);
    else return Icon(FontAwesomeIcons.thumbsUp, color: Color(0xFF1976D2),);
  }

  Widget downvoteIcon(int userVote){
    if (userVote == -1) return Icon(FontAwesomeIcons.solidThumbsDown, color: Color(0xFF1976D2),);
    else return Icon(FontAwesomeIcons.thumbsDown, color: Color(0xFF1976D2),);
  }

  void updownvoteDynamic(int upOrdown){
    String currUser = Authentication.auth.currentUser!.uid;
    if (currUser != widget.review.authorId) {
      int newUserVote;
      userVote == upOrdown ? newUserVote = 0: newUserVote = upOrdown;
      Database.updateVoteReview(widget.review, newUserVote-userVote);
      setState(() {
        widget.review.votes += newUserVote - userVote;
        userVote = newUserVote;
      });
      Database.setVoting(widget.review.reviewRef!, userVote);
    }
  }
}