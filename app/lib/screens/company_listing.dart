import 'package:flutter/material.dart';
import 'package:rate_it/screens/rating_page.dart';
import 'package:rate_it/screens/reviews_page.dart';
import 'package:rate_it/screens/company_page.dart';

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
      future: futureCompanies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Company> companies = snapshot.data!;

          return ListView.builder(
            itemCount: companies.length,
            itemBuilder: (context, index) {
              Company company = companies[index];
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
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                                    '(${company.reviews.length} reviews)',
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
            },
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


