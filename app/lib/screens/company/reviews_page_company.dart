import 'package:flutter/material.dart';
import 'package:rate_it/model/review.dart';
import 'package:rate_it/model/company.dart';
import 'package:rate_it/widgets/review_card.dart';


class ReviewsPageCompany extends StatefulWidget {
  Company company;

  ReviewsPageCompany({required this.company});

  @override
  _ReviewsPageCompanyState createState() => _ReviewsPageCompanyState();
}

class _ReviewsPageCompanyState extends State<ReviewsPageCompany> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews - ${widget.company.name} (${widget.company.averageRating.toStringAsFixed(2)})'),
      ),
      body: FutureBuilder<List<Review>>(
        future: widget.company.reviews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final reviews = snapshot.data!;
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ReviewCard(review: reviews[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
