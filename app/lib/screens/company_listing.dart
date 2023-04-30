import 'package:flutter/material.dart';
import 'package:rate_it/screens/rating_page_company.dart';
import 'package:rate_it/screens/reviews_page_company.dart';
import 'package:rate_it/screens/company_page.dart';

import '../model/company.dart';
import '../widgets/companyCard.dart';

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
              return CompanyCard(company: company);
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


