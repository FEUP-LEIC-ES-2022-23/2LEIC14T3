import 'package:flutter/material.dart';
import 'package:rate_it/screens/company/rating_page_company.dart';

import '../../firestore/database.dart';
import '../../model/company.dart';
import '../../model/review.dart';

class ReviewButtonCompany extends StatefulWidget{
  Company company;

  ReviewButtonCompany({
    super.key,
    required this.company,
  });

  @override
  State<ReviewButtonCompany> createState() => _ReviewButtonCompanyState();
}

class _ReviewButtonCompanyState extends State<ReviewButtonCompany> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        Review? userReviewOnCompany = await Database.alreadyReviewedCompany(widget.company);
        if(userReviewOnCompany == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EventRatingPageCompany(
                      company: widget.company),
            ),
          ).then((_) {
            setState(() {
              widget.company.reviews =
                  Database.fetchReviews(widget.company.id,
                      widget.company.entityOrigin, 0);
              widget.company.setAverageRating();
            });
          });
        }
      },
      child: Text('Rate this company'),
    );
  }
}

