import 'package:flutter/material.dart';

import '../model/company.dart';
import '../model/review.dart';
import '../screens/company_page.dart';

class CompanyCard extends StatelessWidget{
  final Company company;

  const CompanyCard({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Review>>(
      future: company.reviews,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          List<Review> rendReviews = snapshot.data!;
          return Card(
            color: Colors.blue[50],
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompanyScreen(company: company),
                  ),
                );
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
                            company.name,
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
                                  company.address,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.star),
                              SizedBox(width: 8.0),
                              Text(
                                company.averageRating.toStringAsFixed(1),
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                '(${rendReviews.length} reviews)',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      child: Image.network(company.logo),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }

}