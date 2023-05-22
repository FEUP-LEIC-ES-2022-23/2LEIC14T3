import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_it/screens/credits_page.dart';

void main() {
  testWidgets('CreditsPage displays credits', (WidgetTester tester) async {
    // Build the CreditsPage widget
    await tester.pumpWidget(MaterialApp(home: CreditsPage()));

    // Verify that the credits are displayed
    expect(find.text('Credits'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsNWidgets(5));
    expect(find.text('Francisco Campos'), findsOneWidget);
    expect(find.text('Diogo Silva'), findsOneWidget);
    expect(find.text('João Figueiredo'), findsOneWidget);
    expect(find.text('Tiago Simões'), findsOneWidget);
    expect(find.text('Pedro Plácido'), findsOneWidget);
  });
}
