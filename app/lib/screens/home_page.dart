import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/screens/company_listing.dart';
import 'package:rate_it/screens/event_listing.dart';

import 'course_listing.dart';

class HomePage extends StatelessWidget {
  final String companySearchResult;
  final String courseSearchResult;
  final String eventSearchResult;
  final ValueChanged<int> onTabChanged;
  const HomePage({
    Key? key,
    required this.companySearchResult,
    required this.courseSearchResult,
    required this.eventSearchResult,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TabBar(
            tabs: const [
              Tab(icon: Icon(FontAwesomeIcons.briefcase)),
              Tab(icon: Icon(FontAwesomeIcons.graduationCap)),
              Tab(icon: Icon(FontAwesomeIcons.solidCalendarDays)),
            ],
            onTap: onTabChanged,
          ),
        ),
        body: TabBarView(
          children: [
            CompanyListing(searchResult: companySearchResult,),
            CourseListing(searchResult: courseSearchResult,),
            EventListing(searchResult: eventSearchResult,),
          ],
        ),
      ),
    );
  }
}