import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/screens/company/company_listing.dart';
import 'package:rate_it/screens/course/course_listing.dart';
import 'package:rate_it/screens/event/event_listing.dart';
import 'package:rate_it/screens/home_page.dart';

void main() {
  group('HomePage Tests', () {
    testWidgets('Renders with correct tab icons', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomePage(
        companySearchResult: '',
        courseSearchResult: '',
        eventSearchResult: '',
        onTabChanged: (index) {},
      )));

      // Verify that the tab icons are rendered correctly
      expect(find.byIcon(FontAwesomeIcons.briefcase), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.graduationCap), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.solidCalendarDays), findsOneWidget);
    });

    testWidgets('TabBar onTap callback is triggered', (WidgetTester tester) async {
      int selectedTabIndex = 0;

      await tester.pumpWidget(MaterialApp(home: HomePage(
        companySearchResult: '',
        courseSearchResult: '',
        eventSearchResult: '',
        onTabChanged: (index) {
          selectedTabIndex = index;
        },
      )));

      // Tap on the second tab
      await tester.tap(find.byIcon(FontAwesomeIcons.graduationCap));
      await tester.pumpAndSettle();

      // Verify that the onTap callback is triggered and the selected tab index is updated
      expect(selectedTabIndex, 1);
    });

    testWidgets('Renders CompanyListing for the first tab', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomePage(
        companySearchResult: '',
        courseSearchResult: '',
        eventSearchResult: '',
        onTabChanged: (index) {},
      )));

      // Verify that the CompanyListing widget is rendered for the first tab
      expect(find.byType(CompanyListing), findsOneWidget);
    });

    testWidgets('Renders CourseListing for the second tab', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomePage(
        companySearchResult: '',
        courseSearchResult: '',
        eventSearchResult: '',
        onTabChanged: (index) {},
      )));

      // Tap on the second tab
      await tester.tap(find.byIcon(FontAwesomeIcons.graduationCap));
      await tester.pumpAndSettle();

      // Verify that the CourseListing widget is rendered for the second tab
      expect(find.byType(CourseListing), findsOneWidget);
    });

    testWidgets('Renders EventListing for the third tab', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomePage(
        companySearchResult: '',
        courseSearchResult: '',
        eventSearchResult: '',
        onTabChanged: (index) {},
      )));

      // Tap on the third tab
      await tester.tap(find.byIcon(FontAwesomeIcons.solidCalendarDays));
      await tester.pumpAndSettle();

      // Verify that the EventListing widget is rendered for the third tab
      expect(find.byType(EventListing), findsOneWidget);
    });
  });
}
