import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/screens/company/reviews_page_company.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../firestore/database.dart';
import '../../model/company.dart';
import '../../model/review.dart';
import 'rating_page_company.dart';
import 'package:url_launcher/url_launcher.dart';


class CompanyScreen extends StatefulWidget {
  final Company company;
  Review? userReviewOnCompany;

  CompanyScreen({required this.company});

  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _fetchReview();
  }

  Future<void> _fetchReview() async {
    Review? r = await Database.alreadyReviewedCompany(widget.company);
    setState(() {
      widget.userReviewOnCompany = r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company.name),
      ),
      body: FutureBuilder<List<Review>>(
        future: widget.company.reviews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Review> renderedReviews = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Image.network(widget.company.logo),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.company.name,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(width: 8.0),
                            if (widget.company.description != null &&
                                widget.company.description.isNotEmpty)
                              Container(
                                child: AnimatedCrossFade(
                                  duration: Duration(milliseconds: 300),
                                  firstChild: Text(
                                    widget.company.description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  secondChild: Text(
                                    widget.company.description,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  crossFadeState: isExpanded
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                  firstCurve: Curves.easeIn,
                                ),
                              ),
                            if (widget.company.description != null &&
                                widget.company.description.isNotEmpty)
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: Text(
                                    isExpanded ? 'Show Less' : 'Show More',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            if (widget.company.description == null ||
                                widget.company.description.isEmpty)
                              Container(
                                child: Text(
                                  'No description available',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Visibility(
                        visible: widget.company.address != null && widget.company.address.isNotEmpty,
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.red),
                            SizedBox(width: 8.0),
                            Flexible(
                              child: Text(
                                widget.company.address,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      if (widget.company.phone != null && widget.company.phone.isNotEmpty) ...[
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.grey),
                            SizedBox(width: 8.0),
                            Text(
                              widget.company.phone,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                      ],
                      if (widget.company.fax != null && widget.company.fax.isNotEmpty) ...[
                        Row(
                          children: [
                            Icon(Icons.fax, color: Colors.green),
                            SizedBox(width: 8.0),
                            Text(
                              widget.company.fax,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                      ],
                      if (widget.company.email != null && widget.company.email.isNotEmpty) ...[
                        Row(
                          children: [
                            Icon(Icons.mail, color: Colors.redAccent),
                            SizedBox(width: 8.0),
                            Text(
                              widget.company.email,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                      ],
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow[700]),
                          SizedBox(width: 8.0),
                          Text(
                            widget.company.averageRating.toStringAsFixed(1),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            '(${renderedReviews.length} reviews)',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (widget.userReviewOnCompany != null)
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventRatingPageCompany(
                                      company: widget.company,
                                      review: widget.userReviewOnCompany,
                                    ),
                                  ),
                                ).then((_) {
                                  setState(() {
                                    widget.company.reviews = Database.fetchReviews(
                                        widget.company.id,
                                        widget.company.entityOrigin,
                                        0);
                                    widget.company.setAverageRating();
                                  });
                                  _fetchReview();
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Edit your review',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 8.0),
                                  Icon(Icons.edit, color: Colors.white),
                                ],
                              ),
                            ),
                          if (widget.userReviewOnCompany == null)
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventRatingPageCompany(
                                      company: widget.company,
                                    ),
                                  ),
                                ).then((_) {
                                  setState(() {
                                    widget.company.reviews = Database.fetchReviews(
                                        widget.company.id,
                                        widget.company.entityOrigin,
                                        0);
                                    widget.company.setAverageRating();
                                  });
                                  _fetchReview();
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Rate this company',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 8.0),
                                  Icon(Icons.star, color: Colors.white),
                                ],
                              ),
                            ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewsPageCompany(
                                    company: widget.company,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Check Reviews',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(width: 8.0),
                                Icon(Icons.remove_red_eye, color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.company.url != null && widget.company.url.isNotEmpty) ...[
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all<double>(0),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                ),
                                onPressed: () {
                                  launchUrl(Uri.parse(widget.company.url));
                                },
                                child: const Icon(Icons.language, color: Colors.blue, size: 50.0),
                              ),
                            ),
                          ],
                          if (widget.company.url_facebook != null && widget.company.url_facebook.isNotEmpty) ...[
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all<double>(0),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                ),
                                onPressed: () {
                                  launchUrl(Uri.parse(widget.company.url_facebook));
                                },
                                child: const Icon(Icons.facebook, color: Color(0xFF4267B2), size: 50.0),
                              ),
                            ),
                          ],
                          if (widget.company.url_linkedin != null && widget.company.url_linkedin.isNotEmpty) ...[
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all<double>(0),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                ),
                                onPressed: () {
                                  launchUrl(Uri.parse(widget.company.url_linkedin));
                                },
                                child: const Icon(FontAwesomeIcons.linkedin, color: Color(0xFF0A66C2), size: 50.0),
                              ),
                            ),
                          ],
                          if (widget.company.url_twitter != null && widget.company.url_twitter.isNotEmpty) ...[
                            Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all<double>(0),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                ),
                                onPressed: () {
                                  launchUrl(Uri.parse(widget.company.url_twitter));
                                },
                                child: const Icon(FontAwesomeIcons.twitter, color: Color(0xff1DA1F2), size: 50.0),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return Text('Something went wrong!');
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
