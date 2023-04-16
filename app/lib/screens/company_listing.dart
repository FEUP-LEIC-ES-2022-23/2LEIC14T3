

import 'package:flutter/material.dart';
import 'package:rate_it/screens/rating_page.dart';
import 'package:rate_it/screens/reviews_page.dart';

import '../model/company.dart';

class CompanyListing extends StatelessWidget {
  final String searchResult;
  CompanyListing({
    super.key,
    required this.searchResult,
  });
  late Future<List<Company>> futureCompanies;

  void initCompanies(){
    if(searchResult.length>1){
      futureCompanies = searchCompanies(searchResult);
    }
    else {
      futureCompanies = fetchCompanies();
    }
  }
  @override
  Widget build(BuildContext context) {
    initCompanies();
    return FutureBuilder(
        future:futureCompanies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Company> companies = snapshot.data!;
            return Center(
              child: ListView(
                children: [
                  for(var company in companies)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EventRatingPage(company: company)),
                            );
                          },
                          child: Text(company.name),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewsPage(company: company,),
                              ),
                            );
                          },
                          child: Text('See Reviews'),
                        ),
                      ],
                    ),
                  SizedBox(height: 16),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
  }
}
