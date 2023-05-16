import 'package:flutter/material.dart';

import '../firestore/database.dart';
import '../model/company.dart';
import '../model/review.dart';
import '../screens/company/company_page.dart';

class CompanyCard extends StatefulWidget{
  final Company company;

  const CompanyCard({
    super.key,
    required this.company,
  });

  @override
  State<CompanyCard> createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
            color: Colors.blue[50],
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompanyScreen(company: widget.company),
                  ),
                ).then((_){
                  setState(() {
                    widget.company.reviews = Database.fetchReviews(widget.company.id, widget.company.entityOrigin, 0);
                    widget.company.setAverageRating();
                  });
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.company.name,
                            style: TextStyle(fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  widget.company.address,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          FutureBuilder<List<Review>>(
                            future: widget.company.reviews,
                            builder: (context, snapshot) {
                              if (snapshot.hasData){
                                List<Review> rendReviews = snapshot.data!;
                                return Row(
                                  children: [
                                    Icon(Icons.star),
                                    SizedBox(width: 8.0),
                                    Text(
                                      widget.company.averageRating
                                          .toStringAsFixed(1),
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      '(${rendReviews.length} reviews)',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                );
                              }
                              else if (snapshot.hasError) {
                                print('You have an error! ${snapshot.error.toString()}');
                                return Text('Something went wrong!');
                              }
                              else {
                                return Center(child: LinearProgressIndicator(),);
                              }
                            }
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 125,
                      width: 125,
                      child: Image.network(widget.company.logo),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}