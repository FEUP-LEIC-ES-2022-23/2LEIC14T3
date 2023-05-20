import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../auth/Authentication.dart';
import '../../firestore/database.dart';
import '../../model/company.dart';
import '../../model/review.dart';

class EventRatingPageCompany extends StatefulWidget {
  Company company;
  Review? review;

  EventRatingPageCompany({Key? key, required this.company, this.review}) : super(key: key);

  int _rating = 0;
  String _review = "";
  String _title = "";
  bool _anonymous = false;

  @override
  _EventRatingPageCompanyState createState() => _EventRatingPageCompanyState();

  void setReview(String value) {
    _review = value;
  }

  void setTitle(String value) {
    _title = value;
  }
}

class _EventRatingPageCompanyState extends State<EventRatingPageCompany> {
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
        title: Text('Rate this Company'),
      ),
      body: SingleChildScrollView( // Adicionado SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How many stars would you give this company?',
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
                'Title:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your title here...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
                onChanged: widget.setTitle,
              ),
              SizedBox(height: 16),
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
                    ),
                ],
              ),
            ],
          ),
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
        widget.review!.title = widget._title;
        widget.review!.review = widget._review;
        widget.review!.anonymous = widget._anonymous;
        widget.review!.rating = widget._rating;
      });
      if (widget._rating > 0 && widget._title != ""){
        await Database.updateReview(widget.review);
        Navigator.pop(context);
      }
    }
    else{
      Review newReview = Review(
        title: widget._title,
        rating: widget._rating,
        review: widget._review,
        authorId: author,
        anonymous: widget._anonymous,
        categoryIndex: 0,
        idEntity: widget.company.id,
        entityOrigin: widget.company.entityOrigin,
        slug: widget.company.slug,
        votes: 0,
      );

      if (widget._rating > 0 && widget._title != "") {
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
