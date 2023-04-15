import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/screens/company_listing.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            tabs: [
              Tab(icon: Icon(FontAwesomeIcons.briefcase)),
              Tab(icon: Icon(FontAwesomeIcons.graduationCap)),
              Tab(icon: Icon(FontAwesomeIcons.solidCalendarDays)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CompanyListing(),
            CompanyListing(),
            CompanyListing(),
          ],
        ),
      ),
    );
  }
}