import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rate_it/screens/company_page.dart';

import '../model/company.dart';

class CompanyListing extends StatefulWidget {

  final String searchResult;
  const CompanyListing({
    super.key,
    required this.searchResult,
  });

  @override
  State<CompanyListing> createState() => _CompanyListingState();
}

class _CompanyListingState extends State<CompanyListing> {

  late Future<List<Company>> futureCompanies;

  void initCompanies(){
    if(widget.searchResult.length>1){
      futureCompanies = searchCompanies(widget.searchResult);
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
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Icon(Icons.location_on),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      company.address,
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Icon(Icons.star),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    company.averageRating.toStringAsFixed(1),
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    '(${company.reviews.length} reviews)',
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
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
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}


