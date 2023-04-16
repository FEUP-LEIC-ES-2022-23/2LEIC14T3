import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/screens/company_listing.dart';
import 'package:rate_it/screens/event_listing.dart';

import 'course_listing.dart';

class HomePage extends StatelessWidget {
  final String searchResult;
  const HomePage({
    super.key,
    required this.searchResult,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
            CompanyListing(searchResult: searchResult,),
            CourseListing(),
            EventListing(),
          ],
        ),
      ),
    );
  }
}