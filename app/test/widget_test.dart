// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_it/screens/credits_page.dart';
import 'package:rate_it/screens/header_page.dart';
import 'package:rate_it/screens/home_page.dart';
import 'package:rate_it/main.dart';
import 'package:rate_it/model/review.dart';
import 'package:rate_it/model/company.dart';
import 'package:rate_it/screens/profile_page.dart';


void main() {
  //dá erro (não reconhece o nome Francisco Campos)
  group('CreditsPage widget', () {
    testWidgets('should display a "Credits:" heading', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CreditsPage()));
      final creditsHeadingFinder = find.text('Credits:');
      expect(creditsHeadingFinder, findsOneWidget);
    });

    testWidgets('should display a list of credits', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CreditsPage()));
      final creditsFinder = find.byType(Text).hitTestable();
      expect(creditsFinder, findsNWidgets(6));
    });

    testWidgets('should display each credit name in the list', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CreditsPage()));
      final creditNames = ['Francisco Campos', 'Diogo Silva', 'João Figueiredo', 'Tiago Simões', 'Pedro Plácido'];
      for (final name in creditNames) {
        final creditNameFinder = find.text(name);
        expect(creditNameFinder, findsOneWidget);
      }
    });
  });

//este teste dá certo
  testWidgets('CreditsPage displays text with the correct style',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: CreditsPage()));
        final textWidget = tester.widget<Text>(find.byType(Text).first); // Find the first Text widget
        expect(textWidget.style!.fontSize, 24); // Check if font size is correct
      });

  group('MyHomePage', () {
    testWidgets('Renders the correct widgets on init', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MyHomePage()));
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(CreditsPage), findsNothing);
      expect(find.byType(ProfilePage), findsNothing);
    });

    testWidgets('Updates search results when search is submitted', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MyHomePage()));

      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);

      // Enter some search text and submit the search
      await tester.enterText(searchField, 'search query');
      expect(find.text('search query'), findsOneWidget);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('search query'), findsNothing);
    });

    testWidgets('Updates search results and clears search field when search is submitted', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MyHomePage()));

      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);

      // Enter some search text and submit the search
      await tester.enterText(searchField, 'search query');
      expect(find.text('search query'), findsOneWidget);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('search query'), findsNothing);

      // Enter more search text and submit the search again
      await tester.enterText(searchField, 'more search text');
      expect(find.text('more search text'), findsOneWidget);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('more search text'), findsNothing);
    });
  });

  //este teste funciona mas atribuindo um input
  group('Review', () {
    late Review review;

    setUp(() {
      review = Review(
        title: 'Review Title',
        rating: 3,
        review: 'This is a review',
        author: 'John Doe',
      );
    });

    test('has correct title', () {
      expect(review.title, 'Review Title');
    });

    test('has correct rating', () {
      expect(review.rating, 3);
    });

    test('has correct review', () {
      expect(review.review, 'This is a review');
    });

    test('has correct author', () {
      expect(review.author, 'John Doe');
    });
  });


}


  //____________________________________arranjar esta função


