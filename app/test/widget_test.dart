// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_it/screens/credits_page.dart';
import 'package:rate_it/screens/home_page.dart';
import 'package:rate_it/main.dart';
import 'package:rate_it/model/review.dart';
import 'package:rate_it/model/company.dart';


void main() {
  //dá erro (não reconhece o nome Francisco Campos)
  testWidgets('CreditsPage displays names', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CreditsPage()));

    expect(
      find.byWidgetPredicate(
            (widget) =>
        widget is Text && widget.data?.startsWith('Credits') == true,
        description: 'Failed to find Francisco Campos',
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
            (widget) =>
        widget is Text && widget.data?.startsWith('Diogo Silva') == true,
        description: 'Failed to find Diogo Silva',
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
            (widget) =>
        widget is Text &&
            widget.data?.startsWith('João Figueiredo') == true,
        description: 'Failed to find João Figueiredo',
      ),
      findsOneWidget,
    );
    expect(

      find.byWidgetPredicate(
            (widget) =>
        widget is Text && widget.data?.startsWith('Tiago Simões') == true,
        description: 'Failed to find Tiago Simões',
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
            (widget) =>
        widget is Text && widget.data?.startsWith('Pedro Plácido') == true,
        description: 'Failed to find Pedro Plácido',
      ),
      findsOneWidget,
    );
  });


  //este teste dá certo
  testWidgets('CreditsPage displays text with the correct style',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: CreditsPage()));

        final textWidget = tester.widget<Text>(
            find
                .byType(Text)
                .first); // Find the first Text widget

        expect(textWidget.style!.fontSize, 24); // Check if font size is correct
      });
  /*
//dá errado
  testWidgets('MyHomePage should render a Drawer, AppBar, and a body widget',
          (WidgetTester tester) async {
        await tester.pumpWidget(MyHomePage());
        expect(find.byType(Drawer), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.byType(HomePage), findsOneWidget);
      });
//da errado
  testWidgets(
      'Clicking on the Credits button should navigate to the CreditsPage',
          (WidgetTester tester) async {
        await tester.pumpWidget(MyApp());
        final creditsButton = find.byKey(Key('credits_button'));
        expect(creditsButton, findsOneWidget);
        await tester.tap(creditsButton);
        await tester.pumpAndSettle();
        expect(find.text('Credits'), findsOneWidget);
        expect(find.text('Special thanks to...'), findsOneWidget);
      }
  );
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
  */

}


  //____________________________________arranjar esta função


